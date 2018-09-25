# Export of Summary of Important Variables of Analysis
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Request user input
if(interactive == 1){
  # Basic Minimum Requirement in order to run summary scripts
  cat('You are required to have ran the Initial Network Configuration option to continue\n')
  invisible(readline('Press [enter] to continue\n'))
  
  # Checks if user ran initnetconfig
  if(netinitconfig == 0){
    cat('You are being returned to the main menu. Please run the Initial Network Config script\n')
    source('dependencies/mainmenu.R', echo = FALSE)
  }
  
  # Notifies user of the following scripts that have been ran before data export
  cat('You have completed the following scripts: \n')
  cat('A value of "1" means the script was completed. \n')
  cat('Data Collection: ', datacollect, '\n')
  cat('Initial Network Configuration: ', netinitconfig, '\n')
  cat('Plot Network: ', plot, '\n')
  cat('Core: ', core, '\n')
  cat('Subgroups Analysis: ', subgroups, '\n')
  cat('Network Statistics: ', stats, '\n')
  cat('\n')
  
  # Requests user approval to continue with data export
  export_approval <- readline('Do you want to continue data export? [y/n]: ')
  if(export_approval == "Y" || export_approval == "y"){
    # Requests if user wants to export results as a text file
    export_results_file <- readline('Do you want your results to be exported in a text file? [y/n]: ')
  }
  
  # If user says export is FALSE (N), script will return user to the main menu
  if(export_approval == "N" || export_approval == "n"){
    source('dependencies/mainmenu.R', echo = FALSE)
  }
}

#**** END USER INPUT REQUEST ****#

# If user continues with the export process, request user interaction data
if(export_approval == "Y" || export_approval == "y"){
  # Console begins printing results to the file directly
  if(export_results_file == "y" || export_results_file == "Y"){
    sink(file=paste(project_title,".txt",sep=""), append = FALSE, type = c("output"), split = FALSE)
  }
  #------------------- SUMMARY DATA BEGINS BELOW THIS LINE FOR EXPORT -------------------
  cat('UC San Diego, Lo Lab Group\n')
  cat('Social Network Analysis for Education Script Results\n')
  cat('Project Summary\n')
  cat('Current Script Engine Version Build: ', scriptversionread, '\n')
  cat('\n')
  cat('-----------------------------PROJECT DETAILS-----------------------------\n')
  cat('Name of Project: ', project_title, '\n')
  cat("Summary Results Generated On: ")
  print(Sys.time())
  cat('\n')
  if(netinitconfig == 1){
    cat('-----------------------------NETWORK CONFIGURATION-----------------------------\n')
    cat('Weighted Graph: ',graph_weighted, '\n')
    cat('Self-Interactions Allowed: ', selfallowvar, '\n')
    cat('Graph Directed: ', dirvalue, '\n')
    if(plot == 1){
      cat('Graph Projection: ', graph_layout_select, '\n')
    }
    cat('\n')
  }
  if(core == 1){
    cat('-----------------------------CORE PARAMETERS ANALYSIS-----------------------------\n')
    cat('Number of Edges: ', nedge, '\n')
    cat('Number of Nodes: ', nnode, '\n')
    if(weightinput == "y" || weightinput == "Y"){
      cat("Weighted Edges: ", nedge_weighted, "\n")
    }
    cat('Graph Adjacency Matrix: \n')
    print(graphmatrix)
    cat('\n')
    cat('Network Density:', den, '\n')
    cat('Average Degree: ', degavg, '\n')
    cat('Average Path Length: ', avg_path, '\n')
    cat('Strong/Weak Interactions: \n')
    print(strwkplotchk)
    cat('\n')
    cat('Network Diameter')
    print(get_graph_diameter)
    cat('\n')
    cat('Unrestricted Modularity: ', submod, '\n')
    cat('-----------------NETWORK CENTRALITY-----------------\n')
    cat('Degree Centrality: \n')
    print(central)
    cat('\n')
    cat('Articulation Points List: \n')
    print(artpoint)
    cat('\n')
    cat('\n')
  }
  if(subgroups == 1){
    if(pre_check_clique_pres >=2){
      cat('-----------------------------SUBGROUPS AND MODULARITY-----------------------------\n')
      cat("Overview of Possible Cliques: \n")
      print(overview_clique_table)
      cat("\n")
      cat("Maximal Cliques Possible: \n")
      print(maximal_clique_table)
      cat("\n")
      # Does loop function for each group to output members list
      # Function is under Summary of Variables for Analysis because of print function required
      cat("Clique Member Lists: \n")
      listgencount <- 1
      while(listgencount <= maximal_clique_count)
      {
        listpartcount <- cliques(g)[sapply(cliques(g),length)==listgencount]
        cat("Nodes in network size: ",listgencount, "\n")
        print(listpartcount)
        listgencount = listgencount + 1
      }
      cat("\n")
      cat("Group Core Members: \n")
      print(cores)
      cat("\n")
      cat("Graph Symmetry of Members: \n")
      print(graph_symet)
      cat("\n")
      cat("Graph Connectedness Census: \n")
      print(g_comps_table)
      cat("\n")
      cat("Neighborhood List for Each Adjacent Node: \n")
      print(neigh_g)
      cat("\n")
      cat("Transitivity/Clustering Coefficients\n")
      cat({"Measures the probability that the adjacent 
      vertices of a vertex are connected (Based on the number of triangles connected to 
      vertex and triplets centered around vertex\n)
      "})
      cat("Local Transitivity values: \n")
      print(g_trans_local)
      cat("Global Transitivity values: \n")
      print(g_trans_global)
      cat("\n")
      cat('\n')
  }
  if(stats == 1){
    cat('-----------------------------NETWORK STATISTICS-----------------------------\n')
    if(stats ==1){
      if(userInputdir == 0){
        cat('formula(Ag~edges)')
        print(summary(Ag.formula.01))
        print(summary(Ag.model.01))
        print(summary(Ag.gof.01))
        print(summary(Ag.gof.01.global))
        cat('\n')
        cat('formula(Ag~edges + triangles)')
        print(summary(Ag.formula.02))
        print(summary(Ag.model.02))
        print(summary(Ag.gof.02))
        print(summary(Ag.gof.02.global))
        cat('\n')
      }
      if(userInputdir == 1){
        cat('formula(Ag~edges + mutual)')
        print(summary(Ag.formula.03))
        print(summary(Ag.model.03))
        print(summary(Ag.gof.03))
        print(summary(Ag.gof.03.global))
        cat('\n')
      }
      cat('\n')
    }
  }
    cat("----------------DISCLAIMER AND WARRANTY OF PROVIDED RESULTS AND CODE----------------\n")
    cat(
      {"The researcher(s) are primary responsible for the interpretation of the results 
        presented here with the script. The authors accept no liability for any errors that
        may result in the procesing or the interpretation of your results. However, 
        if you do encounter errors in the script that shouldn't have happened, let us know 
        on our GitHub page\n"
      })
    cat("From the Cats at the Lo Lab Group\n")
    cat("MIT License\n")
    cat("Copyright (c) 2018 Albert Chai, Andrew S. Lee, Joshua P. Le, and Stanley M. Lo\n")
    cat("\n")
    cat(
      {"Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the 'Software'), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:
        \n"
      })
    cat("\n")
    cat(
      {"The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.\n"
      }
    )
    cat("\n")
    cat({
      "THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.\n"
    })
  }
}
if(export_results_file == "y" || export_results_file == "Y"){
  # Stops Writing to file from console
  sink()
  # Notifies suer that requested export job has been completed
  cat('Your results have been exported as ',paste(project_title,".txt"), '\n')
  cat('It will be in your current working directory\n')
  cat('Your current working directory is: ')
  print(getwd())
}

# **** BEGIN USER INPUT REQUESTS ****#
# Request User Inputs
if(interactive == 1){
  # Asks user options after summary generation
  cat('------------------------------------------------------------------------------------------------------------\n')
  cat('Please select from the following options: \n')
  cat('0. Quit Script\n')
  cat('1. Return to the Main Menu\n')
  sum_opt_sel <- readline('Selection: ')
  if(sum_opt_sel == 0){
    cat('The cats will now go back to purring... Thank you for using the script\n')
    stopscripting <- 1
    stopifnot(stopscripting == 0)
  }
  if(sum_opt_sel == 1){
    source('dependencies/mainmenu.R', echo = FALSE)
  }
  # **** END USER INPUT REQUESTS ****#
}
