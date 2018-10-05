#' ---
#' title: "Project Summary"
#' output: html_document
#' ---

#' UC San Diego, Lo Lab Group  
#' Graph Theory for Education Script Results  
#' Current Script Engine Version Build, `r scriptversionread`
#' 
#' ## Project Details
#' * Name of project: `r project_title`
#' * Summary resutls generated on: `r Sys.time()`
#' 
#' ## Network Configuration
#' * Weighted Graph: `r graph_weighted`
#' * Self-Interactions Allowed: `r selfallowvar`
#' * Graph Directed: `r dirvalue`
#' * Graph Projection: `r graph_layout_select`
#' * Graph Image:  
#' ![`r project_title`](`r paste0(project_title, ".png")`)
#' 
#' ## Core Parameters Analysis
#' * Number of Edges: `r nedge`
#' * Number of Nodes: `r nnode`
#' * Weighted Edges: `r nedge_weighted`
#' * Graph Adjacency Matrix:  
#' ```{r echo = FALSE} 
#' print(graphmatrix)
#' ````
#' * Network Density: `r den`
#' * Average Degree: `r degavg`
#' * Average Path Length: `r avg_path`
#' * Strong/Weak Interactions:  
#' ```{r echo = FALSE}
#' print(get_graph_diameter)
#' ```
#' * Unrestricted Modularity: `r submod`
#' 
#' ## Network Centrality
#' * Degree Centrality: 
#' ```{r echo = FALSE}
#' print(central)
#' ```
#' * Articulation Points List:  
#' ```{r echo = FALSE}
#' print(artpoint)
#' ```
#' 
#' ## Subgroups and Modularity
#' * Overview of Possible Cliques:  
#' ```{r echo = FALSE}
#' print(overview_clique_table)
#' ```
#' * Maximal Cliques Possible: 
#' ```{r echo = FALSE} 
#' print(maximal_clique_table)
#' ```
#' * Clique Member Lists:  
#' ```{r echo = FALSE} 
#' # Does loop function for each group to output members list
#' # Function is under Summary of Variables for Analysis because of print function required
#' listgencount <- 1
#' while(listgencount <= maximal_clique_count){
#'   listpartcount <- cliques(g)[sapply(cliques(g),length)==listgencount]
#'   cat("Nodes in network size: ",listgencount, "\n")
#'   print(listpartcount)
#'   listgencount = listgencount + 1
#' }
#' ```
#' * Group Core Members:  
#' ```{r echo = FALSE} 
#' print(cores)
#' ```
#' * Graph Symmetry of Members:  
#' ```{r echo = FALSE}
#' print(graph_symet)
#' ```
#' * Graph Connectedness Census:  
#' ```{r echo = FALSE}
#' print(g_comps_table)
#' ```
#' * Neighborhood List for Each Adjacent Node:  
#' ```{r echo = FALSE}
#' print(neigh_g)
#' ```
#' * Transitivity/Clustering Coefficients:  
#' * Measures the probability that the adjacent vertices of a vertex are connected (Based on the number of triangles connected to vertex and triplets centered around vertex\n)
#'     + Local Transitivity values:  
#'     ```{r echo = FALSE}
#'     print(g_trans_local)
#'     ```
#'     + Global Transitivity values:  
#'     ```{r echo = FALSE}
#'     print(g_trans_global)
#'     ```
#' 
#' ## Disclaimer and Warranty of Provided Results and Code
#' The researcher(s) are primary responsible for the interpretation of the results presented here with the script. 
#' The authors accept no liability for any errors that may result in the procesing or the interpretation of your results. 
#' However, if you do encounter errors in the script that shouldn't have happened, let us know on our GitHub page.  
#'   
#' From the Cats at the Lo Lab Group  
#' MIT License  
#' Copyright (c) 2018 Albert Chai, Andrew S. Lee, Joshua P. Le, and Stanley M. Lo  
#'   
#' Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
#' associated documentation files (the 'Software'), to deal in the Software without restriction, 
#' including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
#' and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
#' subject to the following conditions:
#'   
#' The above copyright notice and this permission notice shall be included in all 
#' copies or substantial portions of the Software
#'   
#' THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#' SOFTWARE.
