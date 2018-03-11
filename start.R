# Start R script
# Set working directory and execute based on dependencies file
# Check user directory
cat('Your current working directory is:\n')
getwd() # Gets current working directory
checkwdloc <- readline('Please confirm this is the root directory of the script [1 for yes or [ENTER]/0 for no]: \t')
if(checkwdloc == 0)
{
  # Asks user to define current directory of files
  getscriptdir <- readline('Enter your directory of the script files (No quotes): \t')
  setwd(getscriptdir) #Sets working directory based on user input
}

# Executes Directory Verification Script
source('setdircheck.R',echo = FALSE)

# Code Version Check
# Sets current script version for Info Print Out
scriptversionRead <- "2.0-030618"
# Capture R version system information
cap_version <- version

# Introduction
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Joshua P. Le, and Andrew S. Lee
# Principal Investigator: Stanley M. Lo
cat("UCSD Lo Lab Group Social Network Analysis Script\n")
cat("Written by Albert Chai, Joshua P.Le, and Andrew S. Lee\n")
cat("MIT License\n")
cat("Current Script Engine Version Build: ", scriptversionRead)
cat("\n")
cat("Please read the man pages on the GitHub Repository for more instructions\n")
invisible(readline(prompt="Press [enter] to continue\n"))

# Check Workspace if used before
checkwksp <- readline('Are you using data from a previous script session? [1 for yes/0 for no]\t')
if(checkwksp == 0)
{
  # Initialize Loader Variables
  datacollect <- 0
  core <- 0
  subgroups <- 0
  stats <- 0
}

# Checks for Pre-requisite Libraries
# Loads external script to check for package dependencies
source('dependencies/libraries.R',echo = FALSE)