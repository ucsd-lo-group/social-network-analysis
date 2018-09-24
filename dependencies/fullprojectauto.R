# Full Automated Project Execution
# UCSD Lo Lab Group Social Network Analysis Script
# MIT License
# Written by Albert Chai, Andrew S. Lee, and, Joshua P. Le

# This script is intended to be the launching pad for full script automation. You should use
# this option if you have a large number of data sets that you would like to process.

# Request user options for express user input for all networks
# If no options are specified in this section, program will use the default options to run the program


# Change working directory to the fileprocessing directory
setwd('fileprocessing')

# Search for all processed files in directory
processedFiles <- list.files()

# For each file in the list of files to be processed, run the following loop:
# Load the file name into memory
# Run the scripts as full automation, options will default based on the input from the express input


for (var in processedFiles){
  print(var)
}