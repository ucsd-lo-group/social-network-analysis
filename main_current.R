############################################################################################
# Run script with ECHO off, source('~/path/to/main_current.R/', echo=FALSE)
cat("Please note that this script will clear your current environment workspace\n")
cat("You must have the 'igraph' library installed before continuing...\n")
invisible(readline(prompt="Press [enter] to continue\n"))

############################################################################################
# Clears R Environment Variables
rm(list=ls())
# Clears R Console
cat("\014")

############################################################################################
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai and Joshua Pei Le
# Principal Investigator: Stanley M. Lo
cat("UCSD Lo Lab Group Social Network Analysis Script\n")
cat("Written by Albert Chai and Joshua Pei Le\n")
cat("MIT License\n")
cat("\n")
cat("By using this script, you agree that there is no warranty guaranteed by the authors and the results\n")
cat("presented is up to the user for interpretation\n")
cat("\n")
cat("INSTRUCTIONS: \n")
cat("Your edge lists must be in the following format with one column for 'From' and one column for 'To'.\n")
cat("The top row is normally ignored because it assumes it as a header, but accepted if processed using the lab's MATLAB script\n")
cat("You will also be prompted to decide if your data is directed, weighted, and if self-interactions are allowed\n")
invisible(readline(prompt="Press [enter] to continue\n"))

############################################################################################
## Checks for Pre-requisite Libraries
# Loads the igraph library package
cat("Loading the igraph library package\n")
library(igraph)
# Loads the network library package
# cat("Loading the network library package\n")
# library(network)
# Loads the SNA library package
# cat("Loading the sna library package\n")
# library(sna)

############################################################################################
## Data Import and User Input (Information Collection)
# Asks user for a name for the project
project_name <- readline("What is the name of your project?\t")

# Asks user if data was processed using MATLAB SNA Script
# MATLAB SNA Script exports .csv files without headers, so script sets headers as FALSE for all imports in session
matlabsnaprocess <- readline("Was your data processed using the MATLAB SNA script? Please enter 1 for TRUE or 0 for FALSE: \t")
ifelse(matlabsnaprocess == 1, outcomeHeader <- FALSE, outcomeHeader <- TRUE)

# Asks user to select the data to import
cat("Please import your edge list \n")
cat("Awaiting for user selection... \n")
importedData <- read.csv(file.choose(), header = outcomeHeader)

# Prompts user to state if data is directed and confirm with 1 or 0
userInputdir <- readline("Is your data directed? Please enter 1 for TRUE or 0 for FALSE: \t")
ifelse(userInputdir == 1, outcomeBool <- "TRUE", outcomeBool <- "FALSE")

# Imports data based on directionality
# For no non-participants in network (Normal)
g <- graph.data.frame(importedData, directed = outcomeBool)

# Asks user if there is a weight for the imported data list
userInputweightaccept <- readline("Do you have a weighted list? Please enter 1 for YES or 0 for NO: \t")
# Based on user prompt, script will ask user to select file for list

# If user states that there is no weighted list, then script will skip all Weighted sections
if(userInputweightaccept == 1)
{
  cat("Please import your weight list \n")
  cat("Awaiting for user selection... \n")
  importedData_weight <- read.csv(file.choose(), header = outcomeHeader)
}
# Converts user input list to numeric value
# Creates an attribute for weight
if(userInputweightaccept == 1)
{
  g_weight <- unlist(importedData_weight)
  E(g)$weight <- g_weight
}

# Checks if the graph is weighted
graph_weighted <- is.weighted(g)

# Checks if self-interactions in the network are allowed
cat("Are self-interactions allowed in your network diagram? \n")
userInputselfinteract <- readline("Please enter 1 for YES or 0 for NO: \t")
ifelse(userInputselfinteract == 1, self_interact_permission <- "TRUE", self_interact_permission <- "FALSE")

# Creates Graph Adjacency Matrix
ifelse(userInputweightaccept ==1, graphadj <- as_adjacency_matrix(g, attr = "weight"), graphadj <- as_adjacency_matrix(g))
ifelse(userInputdir == 1, outcome <- "directed", outcome <- "undirected")
ifelse(userInputweightaccept == 1, outcome_weight <- "TRUE", outcome_weight <- "FALSE")
graphedadj <- graph.adjacency(graphadj, mode = outcome, weighted = outcome_weight)

# Prompts User to select a graph Projection and prompts for graphing
# Other Graph Projections that can be used
# Replace "layout = layout.projection" with either of the following
# layout.kamada.kawai
# layout.reingold.tilford
# layout.fruchterman.reingold
# layout.bipartite
if(userInputdir == 1)
{
  if(userInputselfinteract == 1)
  {
    cat("Because of the conditions you have selected, it is recommended that you do not plot your network.\n")
    cat("Errors may result requiring you to start the script again from source. \n")
    graphrequest_approval <- readline("Are you sure you want to proceed? Please enter 1 for YES or 0 for NO\t")
  }
}
if(userInputselfinteract == 0)
{
  graphrequest_approval <- readline("Do you want to plot your network? Please enter 1 for YES or 0 for NO\t")
}
if(graphrequest_approval == 1)
{
cat("Please select your graph projection that you want to plot. Options include: \n")
cat("Fruchterman Reingold = 0 (Default)\n")
cat("Kamada Kawai = 1\n")
cat("Reingold Tilfold = 2\n")
cat("Bipartite = 3\n")
cat("Awaiting for user selection... \n")
graph_projection_input <- readline("Selection:  \t")
if(graph_projection_input == 0)
{
  graph_layout_input = layout.fruchterman.reingold
  graph_layout_select = "Fruchterman Reingold"
}
if(graph_projection_input == 1)
{
  graph_layout_input = layout.kamada.kawai
  graph_layout_select = "Kamada Kawai"
}
if(graph_projection_input == 2)
{
  graph_layout_input = layout.reingold.tilford
  graph_layout_select = "Reingold Tilford"
}
if(graph_projection_input == 3)
{
  graph_layout_input = layout.bipartite
  graph_layout_select = "Bipartite"
}

# Creates Plot of Social Network Graph based on selected projection
plot_raw <- plot(graphedadj, layout = graph_layout_input, edge.width =E(g)$weight, edge.color = "black", edge.curved = FALSE)
title(project_name)
}

# Progress Check cat Call
cat("One Moment Please... The cats are working...\n")

############################################################################################
## Core Basic Analysis Parameters
# Edge Count
nedge <- ecount(g)

# Edge Weighted Count
if(userInputweightaccept==1)
{
  nedge_weighted <- sum(importedData_weight)
}
# Node Count
nnode <- gorder(g)

# Density (with self interactions allowed, user prompt)
ifelse(userInputdir ==1, den <- edge_density(g, loops=self_interact_permission), den <- (edge_density(g, loops=self_interact_permission)/2))

# Degrees of all nodes
inoutdeg <- degree(g)

# Average degree (both directions)
degavg.directional <- mean(degree(g)) 

# Average degree based on first occurance
degavg <- (mean(degree(g))/2)

# Average Path Length of Graph
avg_path <- average.path.length(g)

# Diameter of graph
diam_longest <- diameter(g, directed = outcomeBool)

# Reciprocity of Network
recip <- reciprocity(g, mode = "default")

# Finding and plotting strong/weak clusters
strwkplotchk <- clusters(g, mode = "strong")$membership

# plot_cluster <- plot(g, vertex.color = strwkplotchk, edge.curved = FALSE)
# WORK IN PROGRESS - GRAPH LABELING
#title(cat("Weak/Strong Cluster Graph of", project_name)) # Titles second plot, but does not title the plot

# Creates a vector based on short walkthroughs to find communities
membershipvec <- cluster_walktrap(g)

# Finds unrestricted modularity of graph
submod <- modularity(membershipvec)

# Calculate modularity can be calculated based on graph directionality (must be undirected)
if(userInputdir == 0)
{
  if(userInputweightaccept==1)
    {
    relsubmod <- modularity(g, membership(membershipvec), weights = g_weight)
    }
  relsubmod <- modularity(g, membership(membershipvec))
}

# Get.Graph Diameter
get_graph_diameter <- get.diameter(g, directed = outcomeBool)

############################################################################################
## Centrality of Network Members
central <- centr_degree(g, mode = c("all", "out", "in", "total"), loops = FALSE, normalized = TRUE)

# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)

# Centrality based on Betweenness
centbtwn <- centralization.betweenness(g, directed = userInputdir, normalized = TRUE)

############################################################################################
## Summary of Important Variables of Analysis
# Prompts user that their results are ready for viewing and option to export results as file
cat("\n")
cat("The cats have finished!\n")
cat("A summary of your analysis is ready for you to review. \n")
cat("Do you want your results to be automatically exported to a text file? \n")
export_approval <- readline("Please enter 1 for YES or 0 for NO: \t")
# Allows user to customize the path and filename of the file, else goes to default settings
#if(export_approval == 1)
#{
#  cat("Do you have a specific directory/filename you want to save your results as?\n")
#  cat("If you do not specify any name/directory, it will be saved in your document root\n")
#  cat("as your project name variable\n")
#  export_approval_nameproj <- readline("Please enter 1 for YES or 0 for NO: \t")
#  if(export_approval_nameproj == 1)
#  {
#    export_project_fullpath <- readline("What is the directory and file name where you want to save your results to?\t")
#  }
#}
# Prompts the user if they want to clear their console before viewing results
cat("Do you want your console cleared before showing your results?\n")
cat("This option is STRONGLY recommended if you want your results exported as a text file.\n")
summary_clear <-readline("Please enter 1 for YES or 0 for NO: \t")

# Clears R Console if user requests
if(summary_clear ==1)
{
  cat("\014")
}

# Begin Summary Presentation
cat("********************************************************************************************\n")
# Based on user option for export, console begins printing results to file directly. 
if(export_approval ==1)
{
#  if(export_approval_nameproj == 1)
#  {
#    sink(file=export_project_fullpath, append = FALSE, type = c("output"), split = FALSE)
#  }
  sink(file=project_name, append = FALSE, type = c("output"), split = FALSE)
}
######## SUMMARY DATA BEGINS BELOW THIS LINE FOR EXPORT #########
cat("Social Network Analysis Summary of Project\n")
cat("Summmary of project: ", project_name, "\n")
cat("Current Date and Time: ")
print(Sys.time())
cat("\n")
cat("Weighted Graph: ", graph_weighted, "\n")
cat("Self-Interactions Allowed: ", self_interact_permission, "\n")
cat("Number of Nodes: ", nnode, "\n")
cat("Number of Edges: ", nedge, "\n")
if(userInputweightaccept==1)
{
  cat("Weighted Edges: ",nedge_weighted, "\n")
}
cat("Graph Directed: ", outcome, "\n")
cat("Network Density: ", den, "\n")
cat("Network Diameter (Longest): ", diam_longest, "\n")
cat("Network Diameter (All Short Possible): \n")
print(get_graph_diameter)
cat("***Please note that this result returns a path with the actual diameter.\n")
cat("***If there are many shortest paths of the length of the diameter, then it returns the first one found.\n")
cat("Average Degree: ", degavg, "\n")
cat("Average Path Length: ", avg_path, "\n")
cat("Unrestricted Modularity: ", submod, "\n")
if(graphrequest_approval == 1)
{
  cat("Graph Projection Used: ", graph_layout_select, "\n")
}
cat("Graph Adjency Matrix: \n")
print(graphadj)
cat("\n")
cat("Strong/Weak Interactions: \n")
print(strwkplotchk)
cat("\n")
cat("Network Centrality: \n")
print(central)
cat("\n")
cat("Network Centrality - Eigenvector: \n")
print(centeigen)
cat("\n")
cat("Network Centrality - Betweeness: \n")
print(centbtwn)
cat("\n")
##### NO SUMMARY DATA BELOW THIS LINE - DATA BELOW THIS LINE WILL NOT BE EXPORTED #####
# Turns of console export and returns normal echo back to console
if(export_approval ==1)
{
  sink()
}
#if(export_approval_nameproj == 1)
#{
#  sink()
#}
# Notifies user that the requested export job has been completed.
if(export_approval == 1)
{
  cat("Your results have been exported as ",project_name, "\n")
  cat("Check in your Current Working Directory of your console for the exported file \n")
  cat("The default directory is ~/ \n")
  cat("The cats will now go back to purrrring...\n")
}