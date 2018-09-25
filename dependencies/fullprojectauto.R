# Full Automated Project Execution
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and Joshua P. Le

# This script is intended to be the launching pad for full script automation. You should use
# this option if you have a large number of data sets that you would like to process.

# Sets script version for print out
scriptversionread <- "3.0-092418"
# Capture R version system information
cap_version <- version

# Request user options for express user input for all networks
# If no options are specified in this section, program will use the default options to run the program
# Request data input from user and file selection

# Request loading MATLAB execution
matlab_execute <- readline('Execute MATLAB data preparations script? [y/n]: ')
if(tolower(matlab_execute) == "y"){
  run_matlab_script('~/Documents/dev/social-network-analysis/dataprocessing/Rautodirsearch.m', verbose = TRUE, desktop = FALSE)
}

# Print instructions to console
cat('The script will ask you questions about all of your data. \n')
cat('Once you have setup your base configuration, the script will handle it from there. \n')
cat('Please note that the settings you enter apply to ALL networks that you are processing. \n')
cat('\n')

# Checks if files have headers
headerinput <- readline('Does your data file have a header? [y/n]: ')
ifelse(headerinput == "y" || headerinput == "Y", headervalue <- TRUE, headervalue <- FALSE)

# Project Title will be automatically retrieved from the file name
cat('Project title will be retrieved from the file name\n')

# Asks user if data is directed/undirected
directioninput <- readline('Is all of your network data directed? [y/n]: ')
ifelse(directioninput == "y" || directioninput == "Y", dirvalue <- TRUE, dirvalue <- FALSE)

# Asks user if edge weights are weighted/unweighted
weightinput <- readline('Is all of your network data weighted? [y/n]: ')

# Asks user if data allows for self-interactions
selfinteractinput <- readline('Are self-interactions allowed in all networks? [y/n]: ')
ifelse(selfinteractinput == "Y" || selfinteractinput == "y", selfallowvar <- TRUE, selfallowvar <- FALSE)

# Requests if user attribute file is present
attribute_data_present <- readline('Do you have attribute data for all networks that you want to include? [y/n]: ')
if(attribute_data_present == "Y" || attribute_data_present == "y"){
  attribute_data <- read.csv(file.choose(), header = headervalue)
}

# Asks user on the type of network project to be plotted
cat('Please select the graph project you want to plot. Options include: \n')
cat('0. Fruchterman Reingold\n')
cat('1. Kamada Kawai\n')
cat('2. Reingold Tilfold\n')
cat('3. Bipartite\n')
graph_selection_input <- readline('Selection [0/1/2/3]: ')

# Requests user approval to continue with data export
export_approval <- readline('Do you want to save your results as a text file for all networks? [y/n]: ')
if(tolower(export_approval) == "y"){
  export_results_file <- "y"
}

# Asks which options that the user wants to run for all networks
cat('By default, all of the following options are run: \n')
cat('Data Collection: \n')
cat('Initial Network Configuration: \n')
cat('Plot Network: \n')
cat('Core: \n')
cat('\n')
cat('However, the following options are optional: \n')
cat('1. Subgroups Analysis: \n')
cat('2. Network Statistics: \n')
cat('\n')
runOptional <- readline('Do you want to run subgroups analysis (1), network stats (2), both (12) or none (0)? [1/2/12/0]: ')

cat('User input acquired. Starting automation processes now... You should go get some coffee...\n')

# Search for all processed files in directory
setwd('fileprocessing')
processedFiles <- list.files()
setwd('..')

# For each file in the list of files to be processed, run the following loop:
# Load the file name into memory
# Run the scripts as full automation, options will default based on the input from the express input

for (varlist in processedFiles){
  print(varlist)
  project_title <- varlist
  eval(parse(text=paste0('raw_data <- read.csv("~/Documents/dev/social-network-analysis/fileprocessing/',varlist,'", header = headervalue)')))
  source('dependencies/dataimporter.R')
  source('dependencies/netinitconfig.R')
  source('dependencies/plot.R')
  source('dependencies/core.R')
  if(runOptional == 1){
    source('dependencies/subgroups.R')
  }
  if(runOptional == 2){
    source('dependencies/stats.R')
  }
  if(runOptional == 12){
    source('dependencies/subgroups.R')
    source('dependencies/stats.R')
  }
  source('~/Documents/dev/social-network-analysis/dependencies/summary.R')
}