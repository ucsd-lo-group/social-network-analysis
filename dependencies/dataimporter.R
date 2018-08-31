# Data Importer
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# Checks if files have headers
headerinput <- readline('Does your data file have a header? [y/n]: ')
ifelse(headerinput == "y" || headerinput == "Y", headervalue <- TRUE, headervalue <- FALSE)

# Imports RAW data file into R
raw_data <- read.csv(file.choose(), header = headervalue)

# Create the edge and weight lists from raw_data file as data.frames
edge_list <- data.frame(raw_data$source, raw_data$target)

# Creates node and node weight lists
node_data <- data.frame(raw_data$nodes, raw_data$node_weight, raw_data$node_gender)
node_data_clean <- node_data[complete.cases(node_data),]


# Based on main menu option, execute auto or return to menu
datacollect <- 1
if(autoscriptrun==1){
  source('dependencies/netinitconfig.R')
}
if(autoscriptrun==0){
  source('dependencies/mainmenu.R')
}