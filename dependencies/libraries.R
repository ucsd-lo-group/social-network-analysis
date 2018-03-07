# Install Dependencies
# Installs required packages before executing the main program

# Notifies user the dependency script is running
cat("Loading dependencies script... The cats are working... \n")

# Checks if required libraries are installed
check_sna_install <- require('sna')
check_network_install <- require('network')
check_ergm_install <- require('ergm')
check_statnet_install <- require('statnet')
check_coda_install <- require('coda')
check_latticeExtra_install <- require('latticeExtra')
check_igraph_install <- require('igraph')

# If not installed, install packages
if(check_igraph_install == FALSE)
{
  install.packages('igraph')
}
if(check_ergm_install == FALSE)
{
  install.packages('ergm')
}
if(check_sna_install == FALSE)
{
  install.packages('sna')
}
if(check_network_install == FALSE)
{
  install.packages('network')
}
if(check_statnet_install == FALSE)
{
  install.packages('statnet')
}
if(check_coda_install == FALSE)
{
  install.packages('coda')
}
if(check_latticeExtra_install == FALSE)
{
  install.packages('latticeExtra')
}
# Check if all dependencies are installed after post-install of missing packages
check_sna_install <- require('sna')
check_network_install <- require('network')
check_ergm_install <- require('ergm')
check_statnet_install <- require('statnet')
check_coda_install <- require('coda')
check_latticeExtra_install <- require('latticeExtra')
check_igraph_install <- require('igraph')

# If all installed, continue to script, else ask user and terminate
stopifnot(check_igraph_install==TRUE && check_ergm_install == TRUE && check_sna_install == TRUE && check_network_install == TRUE && check_statnet_install == TRUE && check_coda_install == TRUE && check_latticeExtra_install == TRUE)
{
  cat("We will attempt to update your packages to the latest version\n")
  # Runs updates on packages if already installed before
  update.packages(c('igraph','statnet','ergm','network','coda','sna','latticeExtra'))
  cat("The necessary libraries have been installed and updated... Loading the main menu...\n")
  cat("\n")
  # Loads the main menu script
  source('dependencies/mainmenu.R')
}
if(check_igraph_install==FALSE || check_ergm_install == FALSE || check_sna_install == FALSE || check_network_install == FALSE || check_statnet_install == FALSE || check_coda_install == FALSE || check_latticeExtra_install == FALSE)
{
  stop("The script will run into an error if one of these dependencies failed to install.\n,
       Please check your system settings and try running the dependencies installer again. \n")
}