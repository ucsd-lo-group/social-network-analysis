# Reinitializes the matrix for network/statnet package
A<-get.adjacency(g)
Ag <- network::as.network(as.matrix(A),directed = TRUE)

# Notes: A good Goodness of Fit model would have the trendline between the datasets

# If data direction is undirected, execute the following statistical analysis
if(userInputdir == 0)
  {
  # Generates ERGM model based on Bernoulli (Density as homogenous edge density)
  Ag.formula.01 <- formula(Ag~edges) #Base formula for the Bernoilli 
  Ag.model.01 <- ergm(Ag.formula.01) #Ergm Model calculation
  #Ag.anova.01 <- anova.ergm(Ag.formula.01) #Anova Ergm model calculation
  Ag.gof.01 <- gof(Ag.model.01~model) #Determines if there is a good goodness of fit of the data (random is good)
  plot(Ag.gof.01) #Plots the results generated from the first goodness of fit model
  Ag.gof.01.global <- gof(Ag.model.01~degree+esp+distance) #Determines model for all other patterns that may emerge in model
  plot(Ag.gof.01.global) #Plots the results from the global GOF model
  cat("MCMC Diagnostics for Ag.model.01")
  mcmc.diagnostics(Ag.model.01) #Generates the diagnostics data and plot for modeling 1
  
  # Generates ERGM model based on triads
  Ag.formula.02 <- formula(Ag~edges + triangles) #Base formula for calculating triads
  Ag.model.02 <- ergm(Ag.formula.02) #Ergm model calculation
  #Ag.anova.02 <- anova.ergm(Ag.formula.02) #Anova Ergm model calculation
  Ag.gof.02 <- gof(Ag.model.02~model) #Determines if there is a good goodness of fit
  plot(Ag.gof.02) #Plots the results generated from the second goodness of fit model
  Ag.gof.02.model <- gof(Ag.model.02~degree+esp+distance) #Determines model for all other patterns that may emerge
  plot(Ag.gof.02.model) #Plots the results from the global GOF model
  cat("MCMC Diagnostics for Ag.model.02")
  mcmc.diagnostics(Ag.model.02) #Generates the diagnostics data and plot for modeling 2
}

if(userInputdir == 1)
  {
  # Generates ERGM model based on Directed ties
  Ag.formula.03 <- formula(Ag~edges + mutual) #Base formula for calculating directed ties
  Ag.model.03 <- ergm(Ag.formula.03) #Ergm model calculation
  #Ag.anova.03 <- anova.ergm(Ag.formula.03) #Anova Ergm model calculation
  Ag.gof.03 <- gof(Ag.model.03~model) #Generates a GOF model for specification 3
  plot(Ag.gof.03) #Generates a plot for the GOF model 3
  Ag.gof.03.global <- gof(Ag.model.03~esp+distance) #Determines model for all other patterns. Degree cannot be used for directed sets
  plot(Ag.gof.03.global) #Plots the GOF model for all other potential variables besides mdoel
  cat("MCMC Diagnostics for Ag.model.03\n")
  mcmc.diagnostics(Ag.model.03) #Generates the diagnostic data and plot for modeling 3
}

# Pauses script to allow user to review Diagnostic Results (Results are not printed)
cat("Please take a moment to review the modeling data presented for each of the following situations\n")
cat("These results are not included in the final summary report\n")
cat("When you are ready to continue, follow the instructions below...\n")
invisible(readline(prompt="Press [enter] to continue\n"))

# Based on main menu option, execute auto or return to menu
stats <-1
if(autoscriptrun==1)
{
  source('dependencies/summary.R')
}
if(autoscriptrun==0)
{
  source('dependencies/mainmenu.R')
}