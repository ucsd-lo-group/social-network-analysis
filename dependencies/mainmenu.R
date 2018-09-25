# Main Menu R Script
# Allows for user to select options without having to entirely reload or restart the analysis process
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Sets script version for print out
scriptversionread <- "3.0-092418"
# Capture R version system information
cap_version <- version

# Loads Introduction Prompt
# Prompts user to make a selection
cat('Social Network Analysis Script for Education v2.1\n')
cat('Please select an option from the following:\n')
cat('0. Quit Script\n')
cat('1. Automatic Script Run\n')
cat('2. Clear Environmental Variables\n')
cat('3. Data Entry\n')
cat('4. Network Initial Configuration\n')
cat('5. Plot Network\n')
cat('6. Parameters Analysis\n')
cat('7. Subgroups Analysis\n')
cat('8. Statistical Analysis\n')
cat('9. Summary Report Print\n')
cat('10. Text Counter Analyzer\n')
cat('11. Restore Last Known g_original Graph Adj Matrix\n')
cat('99. MATLAB Automation Script from R - Data Entry')
menuselect <- readline('Selection: \t')

# Switch Options
# Terminates script based on false statement
if(menuselect == 0 || menuselect == 1 || menuselect == 2 || menuselect == 3 || 
   menuselect == 4 || menuselect == 5 || menuselect == 6 || menuselect == 7 || 
   menuselect == 8 || menuselect == 9 || menuselect == 10 || menuselect == 11 ||
   menuselect == 99
   )
{
if(menuselect==0){
  cat("Thank you for using the script\n")
  stopscripting <- 1
  stopifnot(stopscripting == 0)
}
# Runs all scripts automatically based on user input conditions
if(menuselect==1){
  # Sets Universal variable for all scripts to run automatically (as in version 1.0) based on input
  autoscriptrun <- 1
  # Begins launching the first script process
  source('dependencies/dataimporter.R')
}
# Clears environmental variables upon user request
if(menuselect==2){
  rm(list=ls())
  # Initialize Loader Variables
  source('dependencies/varloader.R')
  source('dependencies/mainmenu.R')
}
# Loads Data Entry option
if(menuselect==3){
  autoscriptrun <- 0
  source('dependencies/dataimporter.R')
}
# Loads Network Initial Configuration option
if(menuselect==4){
  autoscriptrun <- 0
  source('dependencies/netinitconfig.R')
}
# Loads Network Plot option
if(menuselect==5){
    autoscriptrun <- 0
    source('dependencies/plot.R')
}
# Loads Core Analysis option
if(menuselect==6){
  autoscriptrun <- 0
  source('dependencies/core.R')
}
# Loads Subgroups Analysis Option
if(menuselect==7){
  autoscriptrun <- 0
  source('dependencies/subgroups.R')
}
# Loads Statistical Analysis Section
if(menuselect==8){
  autoscriptrun <- 0
  source('dependencies/stats.R')
}
# Loads Summary and Print Options Statistics
if(menuselect==9){
  autoscriptrun <- 0
  source('dependencies/summary.R')
}# Returns the working directory back to the main

# Loads the Text Counter Analyzer
if(menuselect == 10){
  autoscriptrun <- 0
  source('dependencies/textcounter.R')
}
# Restores g_original variable
if(menuselect == 11){
  autoscriptrun <- 0
  g <- g_original
  source('dependencies/mainmenu.R')
}
# Loads the MATLAB Automation Script
if(menuselect == 99){
  autoscriptrun <- 0
  source('dependencies/matlabautomation.R')
}
}