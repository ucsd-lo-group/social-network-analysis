# UCSD Lo Lab Group Social Network Analysis Script
# Run script as Source with Echo in RStudio for user input process, else script will fail

# Loads Junk Variable
gcheckfalse = 0

## Checks for Pre-requisite Libraries
library(igraph)
#library(network)
#library(sna)

## Data Import
# Asks user to seelct the data to import
#importedData_mod <- read.csv(file.choose(), header = TRUE)
importedData <- read.csv(file.choose(), header = TRUE)

# Promopts user to state if data is directed and confirm with 1 or 0
userInputdir <- readline("Is your data directed? Please enter 1 for TRUE or 0 for FALSE\t")
ifelse(userInputdir == 1, outcomeBool <- "TRUE", outcomeBool <- "FALSE")

# Converts user input list to numeric value
#importedData <- lapply(importedData_mod, as.numeric)

# Imports data based on directionality
g <- graph.data.frame(importedData, directed = outcomeBool) 


# Asks user if there is a weight for the imported data list
userInputweightaccept <- readline("Do you have a weighted list? Please enter 1 for TRUE or 0 for FALSE\t")

# Based on user prompt, script will ask user to select file for list
# If user states that there is no weighted list, then script will just check against junk variable
ifelse(userInputweightaccept ==1, importedData_weight <- read.csv(file.choose(), header = TRUE), gcheckfalse == 0)

# Converts user input list to numeric value
g_weight <- lapply(importedData_weight, as.numeric)

# Creates an attribute for weight
E(g)$weight <- g_weight
#E(g)$weight <- g

# Creates Graph Adjacency Matrix
graphadj <- get.adjacency(g)
get.diameter(g, directed = userInputdir)
ifelse(userInputdir == 1, outcome <- "directed", outcome <- "undirected")
gadj <- get.adjacency(g, sparse=FALSE) # Gets weighted adjacency matrix
graphedadj <- graph.adjacency(gadj, mode = outcome, weighted = TRUE)

# Creates Plot of Social Network Graph
plot(graphedadj) # WORK IN PROGRESS

# plot the data using straight lines (curved algorithm causes warnings)
#plot(g, edge.curved = FALSE)

## Core Basic Analysis Parameters
nedge <- ecount(g) # Edge count
nnode <- gorder(g) # Node count
den <- edge_density(g, loops=TRUE) # Density with self interactions allowed
inoutdeg <- degree(g) # Degrees of all nodes
degavg.directional <- mean(degree(g)) # Average degree (both directions)
degavg <- (mean(degree(g))/2) # Average degree based on first occurance

## WORK IN PROGESS, ERROR RESULTS IN WEIGHT LIST CANNOT BE COERCED TO TYPE 'DOUBLE'
diam <- diameter(g, directed = userInputdir) # Diameter of graph

strwkplotchk <- clusters(g, mode = "strong")$membership # Finding and plotting strong/weak clusters
plot(g, vertex.color = strwkplotchk, edge.curved = FALSE)
 
membershipvec <- cluster_walktrap(g) # Creates a vector based on short walkthroughs to find communities
submod <- modularity(membershipvec) # Finds unrestricted modularity of graph
ifelse(userInputdir == 0, relsubmod, stop(userInputdir == 0)) # Checks if modularity can be calculated based on graph directionality
relsubmod <- modularity(g, membership(membershipvec), weights = NULL) # Finds modularity relative to membershipvec, a vector of communities

## Centrality of Network Members
#central <- centralize()
# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)
