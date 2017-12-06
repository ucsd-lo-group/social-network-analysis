# Install Dependencies
# Installs required packages before executing the main program

# Checks if required libraries are installed
check_igraph_install <- require('igraph')
check_ergm_install <- require('ergm')
check_sna_install <- require('sna')
check_network_install <- require('network')

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
# Check if all dependencies are installed
check_igraph_install <- require('igraph')
check_ergm_install <- require('ergm')
check_sna_install <- require('sna')
check_network_install <- require('network')

# If all installed, continue to script, else ask user and terminate
ifelse(
  {check_igraph_install== TRUE && 
      check_ergm_install == TRUE && 
      check_sna_install==TRUE && 
      check_network_install==TRUE},break,cat("Please check your system settings to install the required prerequisite libraries.\n")
  )

