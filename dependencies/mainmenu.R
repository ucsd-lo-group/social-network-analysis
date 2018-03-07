# Main Menu R Script
# Allows for user to select options without having to entirely reload or restart the analysis process

# Loads Introduction Prompt
# Prompts user to make a selection
cat('Social Network Analysis Script for Education v2.0\n')
cat('Please select an option from the following:\n')
cat("Any incorrect input will result in termination of the script. It is case sensitive! (we're trying to fix this!!)\n")
cat('0. Quit Script\n')
cat('1. Data Entry\n')
cat('2. Basic Parameters Analysis\n')
cat('3. Subgroups Analysis\n')
cat('4. Statistical Analysis\n')
cat('5. Summary Report Print\n')
cat('6. Clear Environmental Variables\n')
cat('7. Automatic Script Run\n')
menuselect <- readline('Selection: \t')

# Switch Options
# Terminates script based on false statement
if (menuselect == 0 || menuselect == 1 || menuselect == 2 || menuselect == 3 || menuselect == 4 || menuselect == 5 || menuselect == 6 || menuselect == 7)
{
if(menuselect==0){
  cat("Thank you for using the script\n")
  }
# Loads Data Entry option
if(menuselect==1){
  autoscriptrun <- 0
  source('dependencies/datacollect.R')
}
# Loads Core Analysis option
if(menuselect==2){
  autoscriptrun <- 0
  source('dependencies/core.R')
}
# Loads Subgroups Analysis Option
if(menuselect==3){
  autoscriptrun <- 0
  source('dependencies/subgroups.R')
}
# Loads Statistical Analysis Section
if(menuselect==4){
  autoscriptrun <- 0
  source('dependencies/stats.R')
}
# Loads Summary and Print Options Statistics
if(menuselect==5){
  autoscriptrun <- 0
  source('dependencies/summary.R')
}
# Clears environmental variables upon user request
if(menuselect==6){
  rm(list=ls())
  source('dependencies/mainmenu.R')
}
# Runs all scripts automatically based on user input conditions
if(menuselect==7){
  # Sets Universal variable for all scripts to run automatically (as in version 1.0) based on input
  autoscriptrun <- 1
  # Begins launching the first script process
  source('dependencies/datacollect.R')
}
}