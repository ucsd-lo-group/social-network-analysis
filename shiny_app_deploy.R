####### Shiny App Development #######
# When finished development, name file 'app.R'
# Shiny App to allow running R code on web browser

####### Loads the Shiny App Library #######
library(shiny)

####### Loads other required libraries #######
# Loads the igraph Library Package
require(igraph)

## Only while session is Intereactive R
#if (interactive()) {

####### Sets up web-end GUI for the shiny app #######
ui <- fluidPage(
  #shinyapp syntax
  #functionInputname(inputId = "nameofID",label = "Import File or some description")
  #Use ?inputFunct for additional commands (Help Command))
  # Don't forget comma's between each of these Input commands
  titlePanel("Social Network Analysis Online Script"),
  sidebarLayout(
    sidebarPanel(
      h3("Instructions"),
      p("UCSD Lo Lab Group Social Network Analysis Script"), 
      p("MIT License"),
      p("Shinny App for R written by Albert Chai\n"),
      p("Core Script Engine written by Albert Chai and Joshua Pei Le\n"),
      p("View the source code at"), a("https://github.com/ucsd-lo-group/social-network-analysis",URL = "https://github.com/ucsd-lo-group/social-network-analysis"),
      p(""),
      br(),
      h4("User Inputs"),
      textInput(inputId = "projName",label = "Name of the Project"),
      p("Edge List Import"),
      fileInput(inputId = "edgelistImportraw", label = "Edge List File Import"),
      helpText("Import the edge list file that you want to be analyzed.",
               "Please read the documentation hosted at https://site.com",
               "for the proper format."),
      radioButtons(inputId = "graphWeighted",label = "Graph Weighted",choiceNames = c("Yes", "No"),choiceValues = c(1,0)),
      conditionalPanel(
        condition = "input.graphWeighted == 1",
        fileInput(inputId = "weightlistImportraw", label = "Weighted List File Import")
      ),
      helpText("If your data is weighted, you will be asked to import",
               "a corresponding weight list with your edge list."),
      radioButtons(inputId = "dataHeader",label = "Does your data file(s) have a header?",choiceNames = c("Yes", "No"),choiceValues = c("TRUE","FALSE")),
      radioButtons(inputId = "graphDirection",label = "Graph Directed/Undirected",choiceNames = c("Directed", "Undirected"),choiceValues = c("TRUE","FALSE")),
      radioButtons(inputId = "selfInteractallowed",label = "Self-Interactions Permitted",choiceNames = c("Yes", "No"),choiceValues = c("TRUE","FALSE")),
      radioButtons(inputId = "graphRequest",label = "Plot Data in Graph",choiceNames = c("Yes","No"),choiceValues = c(1,0)),
      conditionalPanel(
        condition = "input.graphRequest == 1",
        radioButtons(inputId = "graphType", label = "Graph Projection Types", choiceNames = c("Fruchterman Reingold","Kamada Kawai","Reingold Tilfold","Bipartite"),choiceValues = c(layout.fruchterman.reingold,layout.kamada.kawai,layout.reingold.tilford,layout.bipartite))
      ),
      actionButton(inputId = "startAnalysis", "Begin Analysis")
    ),
    mainPanel(
      "Output Functions")
  )
  
)

####### Sets up the code that the web app will R #######
# Aka the code that is executed in the R script
server <- function(input,output)
{
  ### Notes on code for executed and for output to user
  #$output$testgraph <- renderPlot({
  #  plot(g)
  #})
  #output code must be saved as the following:
  #output$name <- #code where name is the name of func and code is code
  #use render() to generate R objects as html
  #renderPrint()
  #renderImage()
  #renderText()
  
  # Start Executing the R Backend Code
  ## PROBLEM: CURRENLY DOESN'T ACCEPT USER INPUTS FOR R CODE
  observeEvent(input$startAnalysis,
               {
                 ### Start R Backend Code ###
                 # Importing all data files to masters
                 # Imports Edge List
                 output$edgelistimp <- renderTable({
                   # input$file1 will be NULL initially. After the user selects
                   # and uploads a file, it will be a data frame with 'name',
                   # 'size', 'type', and 'datapath' columns. The 'datapath'
                   # column will contain the local filenames where the data can
                   # be found.
                   inFile <- input$edgelistImportraw
                   read.csv(inFile$datapath, header = input$globalHeader)
                 })
                 # Imports Weight List
                 output$weightlistimp <- renderTable({
                   if (graphWeightedset == 1){
                     inFile <- input$weightlistImportraw
                     read.csv(inFile$datapath, header = input$globalHeader)
                   }
                 })
                 
                 # Imports data based on directionality
                 # For no non-participants in network (Normal)
                 g <- graph.data.frame(edgelistimp,directed = graphDirection)
                 
                 # Converts user input list to numeric value
                 # Creates an attribute for weight
                 #if(graphWeighted == 1)
                 {
                   g_weight <- unlist(weightlistimp)
                   E(g)$weight <- g_weight
                 }
                 # Creates Graph Adjacency Matrix
                 ifelse(graphWeighted ==1, graphadj <- as_adjacency_matrix(g, attr = "weight"), graphadj <- as_adjacency_matrix(g))
                 ifelse(graphWeighted == 1, outcome_weight <- "TRUE", outcome_weight <- "FALSE")
                 graphedadj <- graph.adjacency(graphadj, mode = graphDirection, weighted = outcome_weight)
                 
                 
                 
                 
                 output$summary <- {
                 renderPrint(g)
                 }
               })
}

####### Links the ShinyApp components together to execute app #######
shinyApp(ui = ui, server = server)