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
importfile(userInput);
disp('Data import has been completed...')

%% Maximum number of participants in the group
% qmax and rmax determines the highest number of participants in their respective columns.
qmax = max(q);
rmax = max(r);
% amax determines the highest number of participants in the group from each of the question and response group
amax = max(qmax,rmax);
disp('Calculated Maximum Participants...')
fprintf('STATUS: The total number of ACTIVE participants is %d. \n',amax)
% There are posssibilities that there are non-participants in the group, this section will ask user for the input
% and continue with calculations based on new value
disp(' ')
disp('Are there any non-participants in the group? Please enter the number of non-interacting participants or else enter 0.')
disp('Use zero or postive integers only, any decimal value will be rounded!!!')
nopinitial = input('Number of non-participating members: ');
nop = round(nopinitial);
% Code uses a negative while check, rather than postive condition check, to determine whether a user enters a valid value.
while nop < 0
    nop = input('Sorry, you entered an invalid value, please enter a valid value: ');
    % If user fails to enter a valid number greater than or equal to 0, the script will reprompt until a valid value has been entered.
end
% Determines new Max number of participants
gmax = amax + nop; 
% Asks user to confirm whether the new value is correct. If value is not correct, script will terminate.
fprintf('STATUS: You have entered %d, as your value. \n', nopinitial)
fprintf('STATUS: If the value was not an integer, it has been automatically rounded for you. Your new non-participant value is: %d. \n', nop)
fprintf('STATUS: Your new value is %d. Please note that this value will be used for necessary calculations. \n', gmax)
maxconfirm=input('Confirm by entering 1 if the value is correct: ');
    if maxconfirm == 1
        disp('Processing...')
    else
        disp('STATUS: The script has been paused, stop the script before continuing. It is recommended that you clear your workspace.')
        disp('STATUS: Please re-run this section and re-enter the proper value.')
        disp('STATUS: Press CTRL+C for Windows to terminate the script')
        pause      
end
% gmax is the number of total participants in the group
% amax is the number of ACTIVE participants in the group
% nop is the number of non-participants that the user will enter to the script

%% Question and Response Matrix Creation
% vs is one matrix containing both q and r data
vs = [q, r];
% q0 and r0 replace the NaN values with zeros for matrix addition in vall
q0 = fillmissing(q,'constant',0);
r0 = fillmissing(r,'constant',0);
% vall function will process all the question and response data into one column in order of sequence
vall = q0+r0;

%% Total number of interactions 
% intot determines the total number of interactions the members in the group has. Based on the vall matrix grid.
intot = length(vall);
disp(' ')
fprintf('STATUS: The total number of interactions is %d. \n',intot)

%% Member Discussion Order
% Prepares for creating order in which members of group talk to one another
vall2 = vall(2:end);
% vall3 indexes first value of vall to add to the end creating vall4
vall3 = vall(1);
vall4 = [vall2;vall3];
% vallm is the order file from source to target in which members in group talk
vallm = [vall,vall4];
disp('Discussion order has been created.')

%% Student Matrix Interactions
% Determines the number of times students interact with one another in a directed manner
% Creates a matrix of the total number of active students
serialact = 1:amax;
% Transposes serialact into a vertical matrix
serialact1 = serialact';
% Creates a matrix of the total number of students
serialtot = 1:gmax;
% Transposes serialtot into a vertical matrix
serialtot1 = serialtot';
% Begins creating first variable loop for active participants, amax is used.
    % A vector with the desired length of all possible combinations is preallocated with prealloc, values are zeros
    disp('Script is preallocating vector size for all possible combinations...')
    prealloc = zeros(amax*amax,2);
    disp('Preallocation is complete')
    
% Indexing values of matrix for statistical analysis of data
disp('Values are being populated...')
for i = 1: 1: amax % i = 1, then 2, 3, 4, ... then lastly amax
	for j = 1: 1: amax % j = 1, then 2, 3, 4, ... then lastly amax
    row_num = (i-1)*amax + j; 
    prealloc(row_num,1) = i;
    prealloc(row_num,2) = j;
	end
end
disp('Combination population complete.')

%% Calculate Total Number of Interactions with prealloc List
% Creates new matrix called 'master_all' with all corresponding combinations
% and respected weights

% Creates new matrix called 'master' with all of the combination paris with
% no weights removed

%% Export Final Results as .csv Files
% Exports all of the calculated data into 2 .csv files, one with edge list
% and one with weight list corresponding to the edge list.

% Writes Edges List
%edges = master(:,1:2);
%csvwrite('edge_list.csv',edges);
%disp('Edge list has been written, check under edge_list.csv')

% Writes Weighted List
%weight = master(:,3);
%csvwrite('weight_list.csv',weight);
%dips('Weight list has been written, check under weight_list.csv')