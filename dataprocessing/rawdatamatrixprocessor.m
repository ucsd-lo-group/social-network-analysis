%% Clean Workspace Before Starting
% Notifies user to clear their workspace before starting the script.
disp('Workspace should be cleared before any data imports!')
disp('Please note that any variables labeled q or r will be used and overwritten')
disp('Press any key to continue...')
pause

%% Introduction to SNA Script
% Welcome to the Social Network Analysis Computing Script
% The purpose of this script is to assist in automating computating groups based on a set number of
% individuals in a group. There are observed limitations that this script can do and must be considered
% with the interpretation of the final output of the data.
%
% This script is intended to be used in Mathworks MATLAB, but it may be compatible in GNU Octave. There
% is no guarantee that this script will work in other programs other than MATLAB and the author(s) make
% no such warranty to do so.
%
% This script was developed by Albert Chai and Andrew S. Lee
% Principal Investigator of Project: Stanley M. Lo
%
% You will need both the rawdatamatrixprocessor.m and importfile.m
% functions in your MATLAB Working Directory file in order to run this
% script properly without error
disp('====================================================')
disp('Social Network Analysis RAW Data Processing Script')
disp('Developed by Albert Chai, Andrew S. Lee, and et al.')
disp('MIT License')
disp('By using this software, you agree to the terms, limitations, and liability of this script.')
disp("Please ensure that 'rawdatamatrixprocessor.m' and 'importfile.m' are in your MATLAB working directory before continuing.")
disp(' ')

%% Data Import and Initial Processing
% Data in this section are being processed for MATLAB/GNU Octave Reading
% Load the file in MATLAB and right click on the data file. Import the file with each column (such as
% one column is q and one is r). Import using the option 'Create vectors from each column using column names'
% If the variables that are imported do not match 'q' or 'r', use q = {importedqname} or r = {importedrname} to 
% correct for the error.
% Output of the data in the command window is automatically surpressed. To see the output, remove the ';'
% (semicolon) from the code.
disp('Please indicate the file name with extension in single quotes in your MATLAB Workspace Working Directory')
disp("such as 'case3-raw.csv'")
disp('MATLAB will reprompt you for the file if the syntax is incorrect!')
userInput = input('File: ');
[q,r] = importfile(userInput);
disp('Data import has been completed...')

%% Question and Response Matrix Creation
% vs is one matrix containing both q and r data
vs = [q, r];
% q0 and r0 replace the NaN values with zeros for matrix addition in vall
q0 = fillmissing(q,'constant',0);
r0 = fillmissing(r,'constant',0);
% vall function will process all the question and response data into one column in order of sequence
vall = q0+r0;

%% Get number of participants
% Make a conservative estimate (may be higher than actual)
num_participants_possible = max(vall); 

%% Total number of interactions 
% intot determines the total number of interactions the members in the group has. Based on the vall matrix grid.
intot = length(vall)-1; % last row doesn't count
disp(' ')
fprintf('STATUS: The total number of interactions is %d. \n',intot)

%% Member Discussion Order
% Determines the order in which members discussed

% Create edges that show who talked to whom
% assume the person in line n talked to person in line n+1
% assume the file has >= 2 lines
% edge case: the person in last line does not talk to anyone
vallm = [vall(1:end-1), vall(2:end)];
disp('Discussion order has been created.')

%% Student Matrix Interactions
% Determines the number of times students interact with one another in a directed manner
% master_all is a n x 3 matrix, format (source, target, weight) contains all edges
% master is the same as master_all, except without edges where weight <= 0

% Make all possible edges, initialize weight to zero
disp('Script is preallocating vector size for all possible combinations...')
    master_all = zeros(num_participants_possible*num_participants_possible, 3);
disp('Preallocation is complete')

disp('Values are being populated...')
for i = 1: 1: num_participants_possible % i = 1, then 2, 3, 4, ... then lastly num_participants_possible
	for j = 1: 1: num_participants_possible % j = 1, then 2, 3, 4, ... then lastly num_participants_possible
        row_num = (i-1)*num_participants_possible + j; 
        master_all(row_num,1) = i;
        master_all(row_num,2) = j;
	end
end
disp('Combination population complete.')

%% Calculate Weight for Edges
% for each edge in vallm, find the edge in master_all that it matches
% and add 1 to the current value
for i = 1: 1: size(vallm)
   source = vallm(i,1);
   target = vallm(i,2);
   master_all((source-1)*num_participants_possible + target, 3) = master_all((source-1)*num_participants_possible + target, 3) + 1;
end

% make master
% logic: master_all(:,3) > 0 returns an array of 1's and 0's
%   only get the rows with weight greater than 0
master = master_all(master_all(:,3) > 0, :);

%% Export Final Results as .csv Files
% Exports all of the calculated data into 2 .csv files, one with edge list
% and one with weight list corresponding to the edge list.

% Writes Edges List
% parameters
edges = master(:,1:2);
edges_hdr = 'source,target';
edges_file = 'edge_list.csv';

% the actual write
dlmwrite(edges_file, edges_hdr, 'delimiter', '');
dlmwrite(edges_file,edges,'delimiter',',','-append');
disp(strcat("Edge list has been written, check under ", edges_file))

% Writes Weighted List
% parameters
weights = master(:,3);
weights_hdr = 'weight';
weights_file = 'weight_list.csv';

% the actual write
dlmwrite(weights_file, weights_hdr, 'delimiter', '');
dlmwrite(weights_file,weights,'delimiter',',','-append');
disp(strcat("Weight list has been written, check under ", weights_file))