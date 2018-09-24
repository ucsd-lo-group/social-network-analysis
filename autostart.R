# Automated Main Menu R Script
# Controls execution flow for the automated script processing
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Welcome Message
cat('UCSD Lo Lab Group Social Network Analysis Script\n')
cat('MIT License\n')
cat('Written by Albert Chai, Andrew S. Lee, and Joshua P. Le\n')
cat('\n')
cat('You are running the automated script. To run the interactive one, use source("start.R") instead \n')

# Check User Directory
cat('Your current working directory is: \n')
print(getwd()) #Gets users current working directory
checkwdloc <- readline('Please confirm that this is the correct directory [y/n]: ')
if(checkwdloc == "n" || checkwdloc == "N"){
  # Ask user to define the current working directory of project files
  getcorrdir <- readline('Enter the directory of where the script files are located (no quotes): ')
  setwd(getcorrdir) # Sets working directory based on user input
}

# Run directory verification script
if(checkwdloc == "" || checkwdloc == "Y" || checkwdloc == "y"){
  source('setdircheck.R', echo = FALSE)
}

# Remainder of script only runs if the Set Directory Check Script has ran, based on variable set
if(dirsettrue ==1){
  # Clear environmental variables
  rm(list=ls())
  # Initialize Loader Variables
  datacollect <- 0
  core <- 0
  netinitconfig <- 0
  plot <- 0
  subgroups <- 0
  stats <- 0
  stopscripting <- 0
  automationFull <- 1
  
  # Loads external script to check for package dependencies
  source('dependencies/libraries.R', echo = FALSE)
}