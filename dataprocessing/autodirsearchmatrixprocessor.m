%% Automated directory file search and data processing
% The purpose of this script is to search for files that need to be
% processed in R and prepare the necessary 
% 
% The script will search for all files that are currently present in the
% directory and will process each file producing the edge/weight lists as
% necessary
%
% Written by Albert Chai and Andrew S. Lee
% MIT License
%
% All files need to be placed in the fileprocessing folder in order for
% this script to properly function. The dependency scripts must also be in
% the same working directory: autodirsearchmatrixprocessor.m and
% autodirsearchcoredepend.m else the script will fail.

% Change directory to fileprocessing folder to search for files
cd fileprocessing

listprocessingraw = ls; %Calls list of items to be processed
listprocessing = strsplit(listprocessingraw, ' ');
listprocessing = strtrim(listprocessing); %Removes trailing spaces
for var = listprocessing
   %Set the file name to be entered into the script
   userInput = var{1};
   project_name = var{1};
   %Call the autodirsearchcoredepend script
   autodirsearchcoredepend
end

% Change directory back to the main source code
cd ..
