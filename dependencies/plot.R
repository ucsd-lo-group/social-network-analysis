# Plot Network
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Joshua P. Le, and Andrew S. Lee

# Asks user on the type of network project to be plotted
cat('Please select the graph project you want to plot. Options include: \n')
cat('0. Fruchterman Reingold\n')
cat('1. Kamada Kawai\n')
cat('2. Reingold Tilfold\n')
cat('3. Bipartite\n')
graph_selection_input <- readline('Selection: ')
if(graph_selection_input == 0){
  g$layout <- layout.fruchterman.reingold
  graph_layout_select <- "Fruchterman Reingold"
}
if(graph_selection_input == 1){
  g$layout <- layout.kamada.kawai
  graph_layout_select <- "Kamada Kawai"
}
if(graph_selection_input == 2){
  g$layout <- layout.reingold.tilford
  graph_layout_select <- "Reingold Tilfold"
}
if(graph_selection_input == 3){
  g$layout <- layout.bipartite
  graph_layout_select <- "Bipartite"
}

# Adds color to nodes on plot
V(g)$color <- ifelse(node_data_clean$raw_data.node_gender == "male", "lightblue", "pink")

# Plot the final network diagram
plot(g, edge.width = E(g)$weight, edge.color = "black", edge.curved = FALSE, vertex.size=as.matrix(node_data_clean$raw_data.node_weight))
title(project_title)

# Based on main menu option, execute auto or return to menu
plot <- 1
if(autoscriptrun==1){
  source('dependencies/core.R')
}
if(autoscriptrun==0){
  source('dependencies/mainmenu.R')
}
