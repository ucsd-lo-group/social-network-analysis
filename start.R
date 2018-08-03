# Script Loader
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Joshua P. Le, and Andrew S. Lee

# Welcome Message
cat('UCSD Lo Lab Group Social Network Analysis Script\n')
cat('MIT License\n')
cat('Written by Albert Chai, Joshua P. Le, and Andrew S. Lee\n')
cat('\n')
cat('Please read the man pages on GitHub for detailed instructions\n')
invisible(readline(prompt = "Press [enter] to continue\n"))

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
  # Checks Workspace Environment Variables
  checkwksp <- readline('Are you using data from a previous script session? [y/n]: ')
  if(checkwksp == "n" || checkwksp == "N"){
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
  }
  
  # Loads external script to check for package dependencies
  source('dependencies/libraries.R', echo = FALSE)
}
