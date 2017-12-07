######### Code Execution Notes #########
# Run script with ECHO off, source('~/path/to/main_current.R/', echo=FALSE)
cat("Please note that this script will clear your current environment workspace\n")
cat("You must have the 'igraph' library installed before continuing...\n")
invisible(readline(prompt="Press [enter] to continue\n"))

######### Clears R Environment Variables #########
rm(list=ls())
# Clears R Console
cat("\014")

######### Code Version Check #########
# Sets current script version for Info Print Out
scriptversionRead <- "0.5.1 - 120717"
# Capture R version system information
cap_version <- version

######### Introduction #########
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai and Joshua Pei Le
# Principal Investigator: Stanley M. Lo
cat("UCSD Lo Lab Group Social Network Analysis Script\n")
cat("Written by Albert Chai and Joshua Pei Le\n")
cat("MIT License\n")
cat("Current Script Engine Version Build: ", scriptversionRead)
cat("\n")
cat("By using this script, you agree that there is no warranty guaranteed by the authors and the results\n")
cat("presented is up to the user for interpretation\n")
cat("\n")
cat("INSTRUCTIONS: \n")
cat("Read each of the following prompts carefully before choosing a selection.\n")
cat("Your edge lists must be in the following format with one column for 'From' and one column for 'To'.\n")
cat("You will have the chance to tell R if your data has a header and will import accordingly\n")
cat("You will also be prompted to decide if your data is directed, weighted, and if self-interactions are allowed\n")
invisible(readline(prompt="Press [enter] to continue\n"))

######### Checks for Pre-requisite Libraries #########
# Loads external script to check for package dependencies
cat("Loading dependencies script... The cats are working... \n")
source('r-script-dependencies.R',echo = FALSE)

######### Data Import and User Input (Information Collection) #########
# Asks user for a name for the project
project_name <- readline("What is the name of your project?\t")

# Asks user if data has header in imported data set
headerprocess <- readline("Does your data have a header? Please enter 1 for TRUE or 0 for FALSE: \t")
ifelse(headerprocess == 1, outcomeHeader <- TRUE, outcomeHeader <- FALSE)

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
if(userInputselfinteract == 1)
{
  self_interact_permission <- "TRUE"
}
if (userInputselfinteract == 0)
{
  self_interact_permission <- "FALSE"
}

# Creates Graph Adjacency Matrix
if(userInputweightaccept == 1){
  graphadj <- as_adjacency_matrix(g, attr = "weight")
  outcome_weight <- "TRUE"
}
if(userInputweightaccept == 0){
  graphadj <- as_adjacency_matrix(g)
  outcome_weight <- "FALSE"
}
ifelse(userInputdir ==1, outcome <-"directed",outcome <- "undirected")
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

######### Core Basic Analysis Parameters #########
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

######### Centrality of Network Members #########
central <- centr_degree(g, mode = c("all", "out", "in", "total"), loops = FALSE, normalized = TRUE)

# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)

# Centrality based on Betweenness
centbtwn <- centralization.betweenness(g, directed = userInputdir, normalized = TRUE)

# Articulation Points List 
# Articuation points or cut vertices are vertices whose removal increases the number of connected components in a graph.
artpoint <- articulation.points(g)

######### Subgraphs and Modularity #########
# Creates overview of possible cliques in network, Overall Subgraphs of networks
overview_clique_table <- table(sapply(cliques(g),length))

# Maximal cliques possible
# Top row is size of cliques and bottom is number of groups of mentioned size
maximal_clique_table <- table(sapply(maximal.cliques(g), length))

# Generate list members of possible people in subgroup
# Determines the maximal possible clique count in the dataset
maximal_clique_count <- maximal.cliques.count(g)

# Does loop function for each group to output members list
# Function is under Summary of Variables for Analysis because of print function required

# Determines core membranes of the group
cores <- graph.coreness(g)

# Determines symmetry of the group
# Generates simplified data of graph with no loops or multiple edges
graph_symet_pre <- simplify(g)
# Creates list of census of how symmetric the graph is 
graph_symet <- dyad.census(graph_symet_pre)

# Generates density of each of the relative subgroups found
# Example Code
#g_subden1 <- induced.subgraph(g,neighborhood(g,1,1)[[1]])
#subgraphdens <- graph.density(g_subden1)

# Generates RAW Cliques List
rawcliques <- cliques(g)

# Graph Connectedness Census
g_comps <- decompose.graph(g)
g_comps_table <- table(sapply(g_comps,vcount))

# Generates a list the neighborhood of each of the nodes adjacent to one another
neigh_g <- neighborhood(g)

# Transitivity/Clustering Coefficients 
# Measures the probability that the adjacent vertices of a vertex are connected
#(Based on the number of triangles connected to vertex and triplets centered around vertex)
# Transitivity of Local values
g_trans_local <- transitivity(g,type = "local")
# Transitivity of Global values
g_trans_global <- transitivity(g,type = "global")

######### Graphical Data Statistics ######### 
A<-get.adjacency(g)
g_network_pkg <- network::as.network(as.matrix(A),directed = TRUE)
mystats <- formula(g_network_pkg ~ edges)
sum_stats <- summary.statistics(mystats)
g.ergm <- formula(g_network_pkg ~ edges + gwesp(log(3),fixed = TRUE))
set.seed(42)
g.ergm.fit <- ergm(g.ergm)
anova_stat <- anova.ergm(g.ergm.fit)
sum_ergm <- summary.ergm(g.ergm.fit)
gof.g.ergm<- gof(g.ergm.fit)
par(mfrow = c(1,3))
plot(gof.g.ergm)

######### Export of Summary of Important Variables of Analysis #########
# Prompts user that their results are ready for viewing and option to export results as file
cat("\n")
cat("The cats have finished!\n")
cat("A summary of your analysis is ready for you to review. \n")
cat("Do you want your results to be automatically exported to a text file? \n")
export_approval <- readline("Please enter 1 for YES or 0 for NO: \t")

# Asks the user if they require diagnostic data about their user session
cat("Do you require diagnostic data about your session. Default is NO.\n")
diagn_on <- readline("Enter 1 for YES or 0 for NO: \t")

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
  sink(file=paste(project_name, ".txt"), append = FALSE, type = c("output"), split = FALSE)
}
#----------- SUMMARY DATA BEGINS BELOW THIS LINE FOR EXPORT -----------
cat("University of California, San Diego - Lo Lab Group\n")
cat("Social Network Analysis Script Results\n")
cat("Summary of Project\n")
cat("Current Script Engine Version Build: ", scriptversionRead, "\n")
cat("Name of Project: ", project_name, "\n")
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
cat("Network Centrality - Articulation Points List: \n")
print(artpoint)
cat("\n")
cat("Subgraphs and Modularity\n")
cat("Overview of Possible Cliques: \n")
print(overview_clique_table)
cat("\n")
cat("Maximal Cliques Possible: \n")
print(maximal_clique_table)
cat("\n")
# Does loop function for each group to output members list
# Function is under Summary of Variables for Analysis because of print function required
cat("Clique Member Lists: \n")
listgencount <- 1
while(listgencount <= maximal_clique_count)
{
  listpartcount <- cliques(g)[sapply(cliques(g),length)==listgencount]
  cat("Nodes in network size: ",listgencount, "\n")
  print(listpartcount)
  listgencount = listgencount + 1
}
cat("\n")
cat("Group Core Members: \n")
print(cores)
cat("\n")
cat("Graph Symmetry of Members: \n")
print(graph_symet)
cat("\n")
cat("Graph Connectedness Census: \n")
print(g_comps_table)
cat("\n")
cat("Neighborhood List for Each Adjacent Node: \n")
print(neigh_g)
cat("\n")
cat("RAW Cliques List: \n")
print(rawcliques)
cat("\n")
cat("Transitivity/Clustering Coefficients\n")
cat({"Measures the probability that the adjacent 
vertices of a vertex are connected (Based on the number of triangles connected to 
vertex and triplets centered around vertex\n)
  "})
cat("Local Transitivity values: \n")
print(g_trans_local)
cat("Global Transitivity values: \n")
print(g_trans_global)
cat("\n")
cat("Graphical Statistical Analysis\n")
cat("Summary Statistics: \n")
print(sum_stats)
cat("\n")
cat("Network Summary: \n")
print(g_network_pkg)
cat("\n")
cat("ANOVA Analysis\n")
print(anova_stat)
cat("\n")
cat("Summary of ergm Analysis")
print(sum_ergm)
cat("\n")
cat("**********************************************************************************\n")
cat("DISCLAIMER AND WARRANTY OF PROVIDED RESULTS AND CODE\n")
cat(
  {"The researcher(s) are primary responsible for the interpretation of the results 
    presented here with the script. The authors accept no liability for any errors that
    may result in the procesing or the interpretation of your results. However, 
    if you do encounter errors in the script that shouldn't have happened, let us know 
    on our GitHub page\n"
    })
cat("From the Cats at the Lo Lab Group\n")
cat("MIT License\n")
cat("Copyright (c) 2017 Stanley M. Lo, Albert Chai, Joshua P. Le\n")
cat("\n")
cat(
{"Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
\n"
  })
cat("\n")
cat(
  {"The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.\n"
  }
)
cat("\n")
cat({
  "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.\n"
})
#Section relates to diagnostic data and information
if(diagn_on == 1)
{
  cat("\n")
  cat("**********************************************************************************\n")
  cat("Program Diagnostic Data\n")
  cat("R Version\n")
  print(cap_version)
  cat("\n")
  cat("Session Info\n")
  print(sessionInfo())
  cat("\n")
  cat("System Information\n")
  print(Sys.info())
  cat("\n")
}

#----------- NO SUMMARY DATA BELOW THIS LINE - DATA BELOW THIS LINE WILL NOT BE EXPORTED -----------
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
  cat("Your results have been exported as ",paste(project_name,".txt"), "\n")
  cat("Check in your Current Working Directory of your console for the exported file \n")
  cat("The default directory is: ")
  print(getwd())
  cat("The cats will now go back to purrrring...\n")
}
