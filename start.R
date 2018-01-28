######### Set Workspace Working Directory #########
checkwdset <- readline('Is your working directory set to the correct directory with all dependent files? 1 for YES or 0 for NO: ')
if(checkwdset == 0) #If user indicates setwd is not correct, prompts user to change wd to correct location
{
  cat('Please indicate the working directory of the social network analysis files')
  cat("Format: ~/path/to/social-network-analysis\n")
  setwdvar <- readline('Working Directory of Script files: ')
  setwd(setwdvar)
}

######### Disables ECHO for all scripts, run for clean interface #########
source('dependencies/source.R',echo = FALSE)