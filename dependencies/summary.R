######### Export of Summary of Important Variables of Analysis #########
if(datacollect == 0 || core == 0 || subgroups == 0 || stats == 0)
{
  cat("You did not run all of the required processes to get to this step.\n")
  cat("You will be returned to the main menu to correct the missing steps\n")
  source('dependencies/mainmenu.R')
}
if(datacollect == 1 && core == 1 && subgroups == 1 && stats == 1)
{
# Prompts user that their results are ready for viewing and option to export results as file
cat("A summary of your analysis is ready for you to review. \n")
cat("Do you want your results to be automatically exported to a text file? \n")
export_approval <- readline("Please enter 1 for YES or 0 for NO: \t")

# Asks the user if they require diagnostic data about their user session
cat("Do you require diagnostic data about your session. Default is NO.\n")
diagn_on <- readline("Enter 1 for YES or 0 for NO: \t")

# Prompts the user if they want to clear their console before viewing results
cat("Do you want your console cleared before showing your results?\n")
cat("This option is STRONGLY recommended if you want your results exported as a text file.\n")
summary_clear <-readline("Please enter 1 for YES or 0 for NO: \t")

# Clears R Console if user requests
if(summary_clear ==1)
{
  cat("\014")
}

# Begin Summary Presentation
cat("********************************************************************************************\n")
# Based on user option for export, console begins printing results to file directly. 
if(export_approval ==1)
{
  sink(file=paste(project_name, ".txt"), append = FALSE, type = c("output"), split = FALSE)
}
#----------- SUMMARY DATA BEGINS BELOW THIS LINE FOR EXPORT -----------#
cat("University of California, San Diego - Lo Lab Group\n")
cat("Social Network Analysis Script Results\n")
cat("Summary of Project\n")
cat("Current Script Engine Version Build: ", scriptversionRead, "\n")
cat("Name of Project: ", project_name, "\n")
cat("Current Date and Time: ")
print(Sys.time())
cat("\n")
cat("Weighted Graph: ", graph_weighted, "\n")
cat("Self-Interactions Allowed: ", self_interact_permission, "\n")
cat("Number of Nodes: ", nnode, "\n")
cat("Number of Edges: ", nedge, "\n")
if(userInputweightaccept==1)
{
  cat("Weighted Edges: ",nedge_weighted, "\n")
}
cat("Graph Directed: ", outcome, "\n")
cat("Network Density: ", den, "\n")
cat("Network Diameter (Longest): ", diam_longest, "\n")
cat("Network Diameter (All Short Possible): \n")
print(get_graph_diameter)
cat("***Please note that this result returns a path with the actual diameter.\n")
cat("***If there are many shortest paths of the length of the diameter, then it returns the first one found.\n")
cat("Average Degree: ", degavg, "\n")
cat("Average Path Length: ", avg_path, "\n")
cat("Unrestricted Modularity: ", submod, "\n")
if(graphrequest_approval == 1)
{
  cat("Graph Projection Used: ", graph_layout_select, "\n")
}
cat("Graph Adjacency Matrix: \n")
print(graphadj)
cat("\n")
cat("Strong/Weak Interactions: \n")
print(strwkplotchk)
cat("\n")
cat("Network Centrality: \n")
print(central)
cat("\n")
cat("Network Centrality - Eigenvector: \n")
print(centeigen)
cat("\n")
cat("Network Centrality - Betweeness: \n")
print(centbtwn)
cat("\n")
cat("Network Centrality - Articulation Points List: \n")
print(artpoint)
cat("\n")
if(pre_check_clique_pres >=2)
{
  cat("Subgraphs and Modularity\n")
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
#  cat("Graphical Statistical Analysis\n")
# to be revised
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
  }
cat("**********************************************************************************\n")
cat("DISCLAIMER AND WARRANTY OF PROVIDED RESULTS AND CODE\n")
cat(
  {"The researcher(s) are primary responsible for the interpretation of the results 
    presented here with the script. The authors accept no liability for any errors that
    may result in the procesing or the interpretation of your results. However, 
    if you do encounter errors in the script that shouldn't have happened, let us know 
    on our GitHub page\n"
  })
cat("From the Cats at the Lo Lab Group\n")
cat("MIT License\n")
cat("Copyright (c) 2018 Albert Chai, Joshua P. Le, Andrew S. Lee, and Stanley M. Lo\n")
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
#Section relates to diagnostic data and information
if(diagn_on == 1)
{
  cat("\n")
  cat("**********************************************************************************\n")
  cat("Program Diagnostic Data\n")
  cat("R Version\n")
  print(cap_version)
  cat("\n")
  cat("Session Info\n")
  print(sessionInfo())
  cat("\n")
  cat("System Information\n")
  print(Sys.info())
  cat("\n")
}

#----------- NO SUMMARY DATA BELOW THIS LINE - DATA BELOW THIS LINE WILL NOT BE EXPORTED -----------#
# Turns off console export and returns normal echo back to console
if(export_approval ==1)
{
  sink()
}
#if(export_approval_nameproj == 1)
#{
#  sink()
#}
# Notifies user that the requested export job has been completed.
if(export_approval == 1)
{
  cat("Your results have been exported as ",paste(project_name,".txt"), "\n")
  cat("Check in your Current Working Directory of your console for the exported file \n")
  cat("The default directory is: ")
  print(getwd())
  cat("The cats will now go back to purrrring...\n")
}
}