######### Subgraphs and Modularity #########
# Section only executes if there is a subgroup present detected by max_clique check
pre_check_clique_pres <- count_max_cliques(g)
if(pre_check_clique_pres >=2)
{
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
  
}
# Based on main menu option, execute auto or return to menu
subgroups <-1
if(autoscriptrun==1)
{
  source('dependencies/stats.R')
}
if(autoscriptrun==0)
{
  source('dependencies/mainmenu.R')
}