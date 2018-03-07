# Core Basic Analysis Parameters
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

# Centrality of Network Members
central <- centr_degree(g, mode = c("all", "out", "in", "total"), loops = FALSE, normalized = TRUE)

# Centrality based on Eigenvector Centrality
centeigen <- centr_eigen(g,directed = userInputdir, scale = TRUE, normalized = TRUE)

# Centrality based on Betweenness
centbtwn <- centralization.betweenness(g, directed = userInputdir, normalized = TRUE)

# Articulation Points List 
# Articuation points or cut vertices are vertices whose removal increases the number of connected components in a graph.
artpoint <- articulation.points(g)

# Based on main menu option, execute auto or return to menu
core <- 1
if(autoscriptrun==1)
{
  source('dependencies/subgroups.R')
}
if(autoscriptrun==0)
{
  source('dependencies/mainmenu.R')
}