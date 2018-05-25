# Data Import and User Input (Information Collection)
# Asks user for a name for the project
project_name <- readline("What is the name of your project?\t")

# Asks user if data has header in imported data set
headerprocess <- readline("Does your data have a header? [1 for Yes/0 for No] \t")

if(headerprocess== 1 || headerprocess == 0)
  {
    ifelse(headerprocess == 1, outcomeHeader <- TRUE, outcomeHeader <- FALSE)
  }

# Asks user to select the data to import
cat("Please import your edge list \n")
cat("Awaiting for user selection... \n")
importedData <- read.csv(file.choose(), header = outcomeHeader)

# Prompts user to state if data is directed and confirm with 1 or 0
userInputdir <- readline("Is your data directed? [1 for Yes/0 for No] \t")

  if(userInputdir == 1 || userInputdir == 0)
  {
    ifelse(userInputdir == 1, outcomeBool <- "TRUE", outcomeBool <- "FALSE")
  }

# Imports data based on directionality
# For no non-participants in network (Normal)
g <- graph.data.frame(importedData, directed = outcomeBool)

# Asks user if there is a weight for the imported data list
# Based on user prompt, script will ask user to select file for list
userInputweightaccept <- readline("Do you have a weighted list? [1 for Yes/0 for No] \t")

if(userInputweightaccept == 1 || userInputweightaccept == 0)
  {
  # If user states that there is no weighted list, then script will skip all Weighted sections
  if(userInputweightaccept == 1)
  {
    # Imports weighted list
    cat("Please import your weight list \n")
    cat("Awaiting for user selection... \n")
    importedData_weight <- read.csv(file.choose(), header = outcomeHeader)
    # Converts user input list to numeric value
    g_weight <- unlist(importedData_weight)
    # Creates an attribute for weight
    E(g)$weight <- g_weight
  }
  }

# Checks if the graph is weighted
graph_weighted <- is.weighted(g)

# Checks if self-interactions in the network are allowed
cat("Are self-interactions allowed in your network diagram? \n")
userInputselfinteract <- readline("[1 for Yes/0 for No]: \t")

if(userInputselfinteract == 1 || userInputselfinteract == 0){
  ifelse(userInputselfinteract == 1, self_interact_permission <- "TRUE", self_interact_permission <- "FALSE")
  g <- simplify(g, remove.loops = TRUE)
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
# Requests user to plot the network
graphrequest_approval <- readline("Do you want to plot your network? [1 for Yes/0 for No]\t")


if(graphrequest_approval== 0 || graphrequest_approval== 1)
  {
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
  }

# Based on main menu option, execute auto or return to menu
datacollect <- 1
if(autoscriptrun==1)
  {
  source('dependencies/core.R')
  }
if(autoscriptrun==0)
  {
  source('dependencies/mainmenu.R')
  }