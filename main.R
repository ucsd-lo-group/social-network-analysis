#####################################################################################################################
# UCSD Lo Lab Group Social Network Analysis Script
# Run script as Source with Echo in RStudio for user input process, else script will fail
# MIT License
# Written by Albert Chai and Joshua Pei Le
# Principal Investigator: Stanley M. Lo

#####################################################################################################################
# Loads Junk Variable
gcheckfalse = 0

#####################################################################################################################
## Checks for Pre-requisite Libraries
library(igraph)
#library(network)
#library(sna)

#####################################################################################################################
## Data Import
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
# If user states that there is no weighted list, then script will just check against junk variable
ifelse(userInputweightaccept ==1, importedData_weight <- read.csv(file.choose(), header = TRUE), gcheckfalse == 0)

# Converts user input list to numeric value
g_weight <- unlist(importedData_weight)

# Creates an attribute for weight
E(g)$weight <- g_weight

# Confirms that the graph is weighted
graph_weighted <- ifelse(userInputweightaccept == 1, is.weighted(g), gcheckfalse == 0)

# Creates Graph Adjacency Matrix
graphadj <- get.adjacency(g)
get.diameter(g, directed = userInputdir)
ifelse(userInputdir == 1, outcome <- "directed", outcome <- "undirected")

# Gets weighted adjacency matrix
gadj <- get.adjacency(g, edges = TRUE, sparse = TRUE) 
graphedadj <- graph.adjacency(gadj, mode = outcome, weighted = TRUE)

# Creates Plot of Social Network Graph
plot_raw <- plot(graphedadj) # WORK IN PROGRESS - GRAPH WITH WEIGHTS

# plot the data using straight lines (curved algorithm causes warnings)
plot_raw_straight <- plot(g, edge.curved = FALSE)

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
# Diameter of graph
diam <- diameter(g, directed = userInputdir) 
# Finding and plotting strong/weak clusters
strwkplotchk <- clusters(g, mode = "strong")$membership 
plot_cluster <- plot(g, vertex.color = strwkplotchk, edge.curved = FALSE)
 
membershipvec <- cluster_walktrap(g) # Creates a vector based on short walkthroughs to find communities
submod <- modularity(membershipvec) # Finds unrestricted modularity of graph
ifelse(userInputdir == 0, relsubmod, stop(userInputdir == 0)) # Checks if modularity can be calculated based on graph directionality
relsubmod <- modularity(g, membership(membershipvec), weights = NULL) # Finds modularity relative to membershipvec, a vector of communities

#####################################################################################################################
## Centrality of Network Members
#central <- centralize()
# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)
