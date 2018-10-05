%% Introduction to the Automated Matrix Processor for the SNA Script
% The purpose of this script is to allow full automation of the the Graph
% Theory processing script from within R by calling the matlabr and
% R.matlab packages. 
% 
% Written by Albert Chai and Andrew S. Lee
%
% You can also use the rawdatamatrixprocessor.m (requires importfile.m)
% which will run the matrix configuration file in interactive mode
%
%
% Welcome to the Social Network Analysis Computing Script
% The purpose of this script is to assist in automating computating groups 
% based on a set number of individuals in a group. There are observed 
% limitations that this script can do and must be considered with the 
% interpretation of the final output of the data.
%
% This script is intended to be used in Mathworks MATLAB, but it may be 
% compatible in GNU Octave. There is no guarantee that this script will 
% work in other programs other than MATLAB and the author(s) make
% no such warranty to do so.
%
% This script was developed by Albert Chai and Andrew S. Lee
% Principal Investigator of Project: Stanley M. Lo
%
% You will need both the automatedmatrixprocessor.m and importfile.m
% functions in your MATLAB Working Directory file in order to run this
% script properly without error


%% Data Import and Initial Processing
% Data in this section are being processed for MATLAB/GNU Octave Reading
% Load the file in MATLAB and right click on the data file. Import the 
% file with each column (such as one column is q and one is r). Import 
% using the option 'Create vectors from each column using column names'
% If the variables that are imported do not match 'q' or 'r', use 
% q = {importedqname} or r = {importedrname} to correct for the error.
% Output of the data in the command window is automatically surpressed. 
% To see the output, remove the ';' (semicolon) from the code.

disp('Reading file...\n')
userInput = "tempAutomated.csv";
[q,r] = importfile(userInput);
project_name = '';

%% Question and Response Matrix Creation
disp('Pre-processing matrix data\n')
% vs is one matrix containing both q and r data
vs = [q, r];
% q0 and r0 replace the NaN values with zeros for matrix addition in vall
q0 = fillmissing(q,'constant',0);
r0 = fillmissing(r,'constant',0);
% vall function will process all the question and response data into one 
% column in order of sequence
vall = q0+r0;

%% Get number of participants
% Make a conservative estimate (may be higher than actual)
disp('Calculating total participants...\n')
num_participants_possible = max(vall); 

%% Total number of interactions 
% intot determines the total number of interactions the members in the 
% group has. Based on the vall matrix grid.
disp('Calculating total interactions...\n')
intot = length(vall)-1; % last row doesn't count

%% Member Discussion Order
% Determines the order in which members discussed
disp('Creating discussion order...\n')
% Create edges that show who talked to whom
% assume the person in line n talked to person in line n+1
% assume the file has >= 2 lines
% edge case: the person in last line does not talk to anyone
vallm = [vall(1:end-1), vall(2:end)];

%% Student Matrix Interactions
% Determines the number of times students interact with one another in a 
% directed manner
% master_all is a n x 3 matrix, format (source, target, weight) contains 
% all edges
% master is the same as master_all, except without edges where weight <= 0

% Make all possible edges, initialize weight to zero
master_all = zeros(num_participants_possible*num_participants_possible, 3);

for i = 1: 1: num_participants_possible % i = 1, then 2, 3, 4, ... then lastly num_participants_possible
	for j = 1: 1: num_participants_possible % j = 1, then 2, 3, 4, ... then lastly num_participants_possible
        row_num = (i-1)*num_participants_possible + j; 
        master_all(row_num,1) = i;
        master_all(row_num,2) = j;
	end
end

disp('Base matrix created...\n')

%% Calculate Weight for Edges
% for each edge in vallm, find the edge in master_all that it matches
% and add 1 to the current value
disp('Calculating edge weights...\n')
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
disp('Exporting temporary files...\n')

% Writes Edges List
% config parameters
edges = master(:,1:2);
edges_hdr = 'source,target';
edges_file = 'edge.csv';
if not(strcmp(project_name, ''))
    edges_file = strcat(project_name, '-', edges_file);
end

% the actual write
dlmwrite(edges_file, edges_hdr, 'delimiter', '');
dlmwrite(edges_file,edges, 'delimiter', ',', '-append');

% Writes Weighted List
% config parameters
weights = master(:,3);
weights_hdr = 'weight';
weights_file = 'weight.csv';
if not(strcmp(project_name, ''))
    weights_file = strcat(project_name, '-', weights_file);
end

% the actual write
dlmwrite(weights_file, weights_hdr, 'delimiter', '');
dlmwrite(weights_file,weights, 'delimiter', ',', '-append');

% Writes Edges and Weighted List
% config parameters
master_hdr = 'source,target,weight';
master_file = 'master-edge-weight.csv';
if not(strcmp(project_name, ''))
    master_file = strcat(project_name, '-', master_file);
end

% the actual write
dlmwrite(master_file, master_hdr, 'delimiter', '');
dlmwrite(master_file, master, 'delimiter', ',', '-append');

disp('Automated Matlab Matrix Processor Script has completed...\n')