# Data Importer
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Request user input
if(interactive == 1){
  # Checks if files have headers
  headerinput <- readline('Does your data file have a header? [y/n]: ')
  ifelse(headerinput == "y" || headerinput == "Y", headervalue <- TRUE, headervalue <- FALSE)
  
  # Imports RAW data file into R
  raw_data <- read.csv(file.choose(), header = headervalue)
  
  # Requests if user attribute file is present
  attribute_data_present <- readline('Do you have attribute data that you want to include? [y/n]: ')
  if(attribute_data_present == "Y" || attribute_data_present == "y"){
    attribute_data <- read.csv(file.choose(), header = headervalue)
  }
}

#**** END USER INPUT REQUEST ****#

# Create the edge and weight lists from raw_data file as data.frames
edge_list <- data.frame(raw_data$source, raw_data$target)

# Imports attributes file into R if present
if(attribute_data_present == "Y" || attribute_data_present == "y"){
  # Creates node and node weight lists for attribute data
  attribute_data <- attribute_data[complete.cases(attribute_data),]
}


# Based on main menu option, execute auto or return to menu
datacollect <- 1
if(autoscriptrun==1){
  source('dependencies/netinitconfig.R')
}
if(autoscriptrun==0){
  source('dependencies/mainmenu.R')
}