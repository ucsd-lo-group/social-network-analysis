#####################################################################################################################
# Clears R Environment Variables
rm(list=ls())
# Clears R Console
cat("\014")

#####################################################################################################################
# UCSD Lo Lab Group Social Network Analysis Script
# Run script as Source with Echo in RStudio for user input process, else script will fail
# MIT License
# Written by Albert Chai and Joshua Pei Le
# Principal Investigator: Stanley M. Lo

#####################################################################################################################
## Checks for Pre-requisite Libraries
# Loads the igraph library package
library(igraph)

# Loads the network library package
#library(network)
# Loads the SNA library package
#library(sna)

#####################################################################################################################
## Data Import
# Asks user for a name for the project
project_name <- readline("What is the name of your project?\t")
# Asks user to seelct the data to import
importedData <- read.csv(file.choose(), header = TRUE)
# Promopts user to state if data is directed and confirm with 1 or 0
userInputdir <- readline("Is your data directed? Please enter 1 for TRUE or 0 for FALSE\t")
ifelse(userInputdir == 1, outcomeBool <- "TRUE", outcomeBool <- "FALSE")
# Imports data based on directionality
g <- graph.data.frame(importedData, directed = outcomeBool) 
# Asks user if there is a weight for the imported data list
userInputweightaccept <- readline("Do you have a weighted list? Please enter 1 for TRUE or 0 for FALSE\t")
# Based on user prompt, script will ask user to select file for list
# If user states that there is no weighted list, then script will skip all Weighted sections
if(userInputweightaccept == 1)
{
  importedData_weight <- read.csv(file.choose())
} 
# Converts user input list to numeric value
#ifelse(userInputweightaccept == 1, g_weight, noweightlist == 0)
if(userInputweightaccept == 1)
{
  g_weight <- unlist(importedData_weight)
}
# Creates an attribute for weight
#ifelse(userInputweightaccept == 1, E(g)$weight, noweightattr == 0)
if(userInputweightaccept == 1)
{
  E(g)$weight <- g_weight
}
# Confirms that the graph is weighted
#ifelse(userInputweightaccept == 1, graph_weighted, noweightconf == 0)
if(userInputweightaccept == 1)
{
  graph_weighted <- is.weighted(g)
}
# Creates Graph Adjacency Matrix
graphadj <- get.adjacency(g)
get.diameter(g, directed = userInputdir)
ifelse(userInputdir == 1, outcome <- "directed", outcome <- "undirected")
# Gets weighted adjacency matrix
gadj <- get.adjacency(g, edges = TRUE, sparse = TRUE) 
graphedadj <- graph.adjacency(gadj, mode = outcome, weighted = TRUE)
# Creates Plot of Social Network Graph based on Fruchterman Reingold Projection
plot_raw <- plot(graphedadj, layout = layout.fruchterman.reingold, edge.width =E(g)$weight, edge.color = "black", edge.curved = FALSE)
title(project_name)
# Other Graph Projections that can be used
# Replace "layout = layout.projection" with either of the following
# layout.kamada.kawai
# layout.reingold.tilford
# layout.fruchterman.reingold
# layout.bipartite

#####################################################################################################################
## Core Basic Analysis Parameters
# Edge Count
nedge <- ecount(g)
# Node Count
nnode <- gorder(g)
# Density with self interactions allowed
den <- edge_density(g, loops=TRUE) 
# Degrees of all nodes
inoutdeg <- degree(g) 
# Average degree (both directions)
degavg.directional <- mean(degree(g)) 
# Average degree based on first occurance
degavg <- (mean(degree(g))/2) 
# Average Path Length of Graph
avg_path <- average.path.length(g)
# Diameter of graph
diam <- diameter(g, directed = userInputdir) 
# Reciprocity of Network
recip <- reciprocity(g, mode = "default")
# Finding and plotting strong/weak clusters
strwkplotchk <- clusters(g, mode = "strong")$membership 
plot_cluster <- plot(g, vertex.color = strwkplotchk, edge.curved = FALSE)
# WORK IN PROGRESS - GRAPH LABELING
title(cat("Weak/Strong Cluster Graph of", project_name)) # Titles second plot, but does not title the plot

# Creates a vector based on short walkthroughs to find communities
membershipvec <- cluster_walktrap(g) 
# Finds unrestricted modularity of graph
submod <- modularity(membershipvec) 
# Calculate modularity can be calculated based on graph directionality (must be undirected)
if(userInputdir == 0)
{
  relsubmod <- modularity(g, membership(membershipvec), weights = g_weight)
}

#####################################################################################################################
## Centrality of Network Members
central <- centr_degree(g, mode = c("all", "out", "in", "total"), loops = FALSE, normalized = TRUE)
# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)
# Centrality based on Betweenness
centbtwn <- centralization.betweenness(g, directed = userInputdir, normalized = TRUE)

#####################################################################################################################
## Summary of Important Variables of Analysis
cat("\n")
cat("Summmary of project ", project_name, "\n")
cat("Weighted Graph: ", graph_weighted, "\n")
cat("Number of Nodes: ", nnode, "\n")
cat("Number of Edges: ", nedge, "\n")
cat("Graph Directed: ", outcome, "\n")
cat("Network Density: ", den, "\n")
cat("Network Diameter: ", diam, "\n")
cat("Average Degree: ", degavg, "\n")
cat("Average Path Length: ", avg_path, "\n")