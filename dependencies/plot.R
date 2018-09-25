# Plot Network
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Request user input
if(interactive == 1){
  # Asks user on the type of network project to be plotted
  cat('Please select the graph project you want to plot. Options include: \n')
  cat('0. Fruchterman Reingold\n')
  cat('1. Kamada Kawai\n')
  cat('2. Reingold Tilfold\n')
  cat('3. Bipartite\n')
  graph_selection_input <- readline('Selection [0/1/2/3]: ')
  # Asks if user has demographic/gender data
  if(tolower(attribute_data_present) == "y"){
    genderInputRequest <- readline('Do you want to load the demographic information on the plot? [y/n]: ')
  }
}

#**** END USER INPUT REQUEST ****#
# Sets graph based on user selected type
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

# Creates graph based on additional user attributes
if(tolower(attribute_data_present) == "y" ){
  if(tolower(genderInputRequest) == "y"){
    # Adds color to nodes on plot
    V(g)$color <- ifelse(attribute_data$node_gender == "male", "lightblue", "pink")
    # Plot the final network diagram
    plot(g, edge.width = E(g)$weight, edge.color = "black", edge.curved = FALSE, vertex.size=as.matrix(attribute_data$node_weight))
    title(project_title)
  }
}
  
# If user does not have any demographic data to append to graph
# Plot the final network diagram
if(tolower(attribute_data_present) == "n"){
  plot(g, edge.width = E(g)$weight, edge.color = "black", edge.curved = FALSE)
  title(project_title)
}

# Automatically Save Plot to Working Directory
# Saves file as a Portable Document Format (PDF)
dev.copy(pdf, paste0(project_title,".pdf"))
dev.off()

# Saves file as a PNG Image
dev.copy(png, paste0(project_title,".png"))
dev.off()


# Based on main menu option, execute auto or return to menu
plot <- 1
if(autoscriptrun==1){
  source('dependencies/core.R')
}
if(autoscriptrun==0){
  source('dependencies/mainmenu.R')
}
