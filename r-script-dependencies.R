# Install Dependencies
# Installs required packages before executing the main program

# Checks if required libraries are installed
check_sna_install <- require('sna')
check_network_install <- require('network')
check_ergm_install <- require('ergm')
check_statnet_install <- require('statnet')
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
# Check if all dependencies are installed
check_sna_install <- require('sna')
check_network_install <- require('network')
check_ergm_install <- require('ergm')
check_statnet_install <- require('statnet')
check_igraph_install <- require('igraph')

# If all installed, continue to script, else ask user and terminate
if(check_igraph_install==FALSE || check_ergm_install == FALSE || check_sna_install == FALSE || check_network_install == FALSE || check_statnet_install == FALSE)
{
  cat("The script will run into an error if one of these dependencies failed to install.\n")
  cat("Please check your system settings and try running the dependencies installer again. \n")
}
