# Install Dependencies
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Installs required packages before executing the main program

# Notifies user the dependency script is running
cat("Loading dependencies script... The cats are working... \n")

# Load the required libraries list
requireinstall_list <- c('matlabr', 'R.matlab', 'rmarkdown', 'sna', 
                         'network', 'ergm', 'statnet', 'coda', 
                         'latticeExtra','igraph')

# Runs the necessary commands for checking library installs
for (list in requireinstall_list){
  # Checks if required libraries are installed
  eval(parse(text=paste0('check_',list,'_install <- require("',list,'")')))
  # If not installed, install packages
  currentpackagecheck <- eval(parse(text=paste0('check_',list,'_install')))
  if(currentpackagecheck == FALSE){
    eval(parse(text=paste0('install.packages("',list,'")')))
  }
  # Check if all dependencies are installed after post-install of missing packages
  eval(parse(text=paste0('check_',list,'_install <- require("',list,'")')))
  
}

# Generate initial total package indicator
packageinstall_indicator <- 0
# If the proper package is installed on the system, the function will increase the length of
# the packageinstall_indicator, which serves as a proxy to check that all necessary requirements
# are met in lieu of listing out each package separately.
for (list in requireinstall_list){
  currentpackagecheck <- eval(parse(text=paste0('check_',list,'_install')))
  if(currentpackagecheck == TRUE){
    packageinstall_indicator <- packageinstall_indicator + 1
  }
}

# If all installed, continue to script, else terminate script
stopifnot(packageinstall_indicator == length(requireinstall_list))
{
  cat("We will attempt to update your packages to the latest version\n")
  
  # Runs updates on packages if already installed before
  for(pack in requireinstall_list){
    eval(parse(text=paste0('update.packages("', pack,'")')))
  }
  
  cat("The necessary libraries have been installed and updated...\n")
  cat("Loading the main menu...\n")
  cat("\n")
  # Loads the main menu script for Interactive Mode
  if(automationFull == 0){
    source('dependencies/mainmenu.R')
  }
  # Loads the main menu script for Automation Mode
  if(automationFull == 1){
    source('dependencies/fullprojectauto.R')
  }
}

if(packageinstall_indicator != length(requireinstall_list)){
  stop("The script will run into an error if one of these dependencies failed to install.\n,
       Please check your system settings and try running the dependencies installer again. \n")
}