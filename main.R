# UCSD Lo Lab Group Social Network Analysis Script

# Loads Junk Variable
gcheckfalse = 0

# load the library
library(igraph)

# import EdgeList and prompt; run as Source with Echo to get user input
importedData <- read.csv(file.choose(), header = TRUE)
userInputdir <- readline("Is your data directed? Please enter 1 for TRUE or 0 for FALSE\t")
ifelse(userInputdir == 1, outcomeBool <- "TRUE", outcomeBool <- "FALSE")

g <- graph.data.frame(importedData, directed = outcomeBool) # Gets edgelist

# import weight list; run as Source with Echo to get user input
userInputweightaccept <- readline("Do you have a weighted list? Please enter 1 for TRUE or 0 for FALSE\t")
ifelse(userInputweightaccept ==1, g_weight <- importedData_weight <- read.csv(file.choose(), header = TRUE), gcheckfalse == 0)
E(g)$weight <- sample(seq_len(ecount(g)))

# Creates and graphs weighted adjacency matrix from edgelist
ifelse(userInputdir == 1, outcome <- "directed", outcome <- "undirected")
gadj <- get.adjacency(g, sparse=FALSE) # Gets weighted adjacency matrix
graphedadj <- graph.adjacency(gadj, mode = outcome, weighted = TRUE)
plot(graphedadj) # WORK IN PROGRESS

# plot the data using straight lines (curved algorithm causes warnings)
#plot(g, edge.curved = FALSE)

# basic analysis
nedge <- ecount(g) # Edge count
nnode <- gorder(g) # Node count
den <- edge_density(g, loops=TRUE) # Density with self interactions allowed
inoutdeg <- degree(g) # Degrees of all nodes
degavg <- mean(degree(g), weights = g_weight) # Average degree
diam <- diameter(g, weights = g_weight) # Diameter of graph

strwkplotchk <- clusters(g, mode = "strong")$membership # Finding and plotting strong/weak clusters
plot(g, vertex.color = strwkplotchk, edge.curved = FALSE)
 
membershipvec <- cluster_walktrap(g) # Creates a vector based on short walkthroughs to find communities
submod <- modularity(membershipvec) # Finds unrestricted modularity of graph
ifelse(userInputdir == 0, relsubmod, stop(userInputdir == 0)) # Checks if modularity can be calculated based on graph directionality
relsubmod <- modularity(g, membership(membershipvec), weights = NULL) # Finds modularity relative to membershipvec, a vector of communities
