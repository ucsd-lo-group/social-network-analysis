# Network Initial Configuration
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Requests user input
if(interactive == 1){
  # Request data input from user and file selection
  # Request project name
  project_title <- readline('Enter Project Title: ')
  
  # Asks user if data is directed/undirected
  directioninput <- readline('Is your network data directed? [y/n]: ')
  
  # Sets the direction variable from user input
  ifelse(directioninput == "y" || directioninput == "Y", dirvalue <- TRUE, dirvalue <- FALSE)
  
  # Asks user if data allows for self-interactions
  selfinteractinput <- readline('Are self-interactions allowed? [y/n]: ')
  
  # Asks user if edge weights are weighted/unweighted
  weightinput <- readline('Is your network data weighted? [y/n]: ')
}



#**** END USER INPUT REQUEST ****#

# Creates a graph data frame 
g_original <- graph.data.frame(edge_list, directed = dirvalue)
g <- graph.data.frame(edge_list, directed = dirvalue)

# Adjusts for weights for the network
if(weightinput == "y" || weightinput == "Y"){
  weight_list <- data.frame(raw_data$weight)
  # Converts user input list into numeric value
  g_weight <- unlist(weight_list)
  # Creates an attribute for weight
  E(g)$weight <- g_weight
  # Checks if the graph is weighted 
  graph_weighted <- is.weighted(g)
}

# Adjusts for self-interactions in the network
if(selfinteractinput == "n" || selfinteractinput == "N"){
  g <- simplify(g, remove.loops = TRUE)
}
ifelse(selfinteractinput == "Y" || selfinteractinput == "y", selfallowvar <- TRUE, selfallowvar <- FALSE)

# Creates Graph Adjacency Matrix
if(weightinput == "y"|| weightinput == "Y"){
  graphmatrix <- as_adjacency_matrix(g, attr = "weight")
  outcome_weight <- "TRUE"
} 
if(weightinput == "n" || weightinput == "N"){
  graphmatrix <- as_adjacency_matrix(g)
  outcome_weight <- "FALSE"
}

# Based on main menu option, execute auto or return to menu
netinitconfig <- 1
if(autoscriptrun==1){
  source('dependencies/plot.R')
}
if(autoscriptrun==0){
  source('dependencies/mainmenu.R')
}