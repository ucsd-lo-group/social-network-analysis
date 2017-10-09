%% Clean Workspace Before Starting
% Clear the workspace of any variables before starting with the SNA Script.
%disp('Script will now attempt clear the command window. Press any key to continue...')
%pause
%clc
%disp('WARNING: Workspace should be cleared before any data imports!!!!!')
%disp('====================================================')
%disp(' ')

%% Introduction to SNA Script
disp('====================================================')
disp('Welcome to the Social Network Analysis Computing Script')
disp('Developed by Albert Chai, Andrew S. Lee, and et al.')
disp(' ')
disp('THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT ')
disp('LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. ')
disp('IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, ')
disp('WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE ')
disp('SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.')
disp(' ')
% Welcome to the Social Network Analysis Computing Script
% The purpose of this script is to assist in automating computating groups based on a set number of
% individuals in a group. There are observed limitations that this script can do and must be considered
% with the interpretation of the final output of the data.
%
% This script is intended to be used in Mathworks MATLAB, but it may be compatible in GNU Octave. There
% is no guarantee that this script will work in other programs other than MATLAB and the author(s) make
% no such warranty to do so.
%
% Help dialogues will be available throughout the script if needed. If you see any errors, please contact
% Albert Chai at a1chai[at]ucsd[dot]edu (a1chai@ucsd.edu), Andrew S. Lee, or 
% Stanley M. Lo at smlo[at]ucsd[dot]edu (smlo@ucsd.edu).
% 
% MIT Software License (OSS)
% Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
% and associated documentation files (the "Software"), to deal in the Software without restriction, 
% including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
% subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all copies or substantial 
% portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
% LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
% IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
% WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

%% Data Import and Initial Processing
% Data in this section are being processed for MATLAB/GNU Octave Reading
% Load the file in MATLAB and right click on the data file. Import the file with each column (such as
% one column is q and one is r). Import using the option 'Create vectors from each column using column names'
% If the variables that are imported do not match 'q' or 'r', use q = {importedqname} or r = {importedrname} to 
% correct for the error.
% Output of the data in the command window is automatically surpressed. To see the output, remove the ';'
% (semicolon) from the code.
disp('Please check that your data has been properly imported as q and r.')
disp('The script will not run properly if this has not been done.')
disp('Press any key to continue')
disp(' ')
pause

%% Maximum number of participants in the group
% qmax and rmax determines the highest number of participants in their respective columns.
qmax = max(q);
rmax = max(r);
% amax determines the highest number of participants in the group from each of the question and response group
amax = max(qmax,rmax);
disp('STATUS: Maximum number of ACTIVE participants have been determined.')
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
        disp('STATUS: The script will now proceed.')
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
disp('STATUS: Discussion order has been created. Check in the workspace under name "vallm"')

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
    disp('STATUS: Script is preallocating vector size for all possible combinations...')
    prealloc = zeros(amax*amax,2);
    disp('STATUS: Preallocation is complete')
    
% Indexing values of matrix for statistical analysis of data
disp('STATUS: Values are being populated...')
for i = 1: 1: amax % i = 1, then 2, 3, 4, ... then lastly amax
	for j = 1: 1: amax % j = 1, then 2, 3, 4, ... then lastly amax
    row_num = (i-1)*amax + j; 
    prealloc(row_num,1) = i;
    prealloc(row_num,2) = j;
	end
end
disp('STATUS: Combination population complete. Check in workspace under "prealloc"')

%% Statistical Analysis
% Calculates the number of times students has asked a question or said a response.
analysis = struct('order',vallm, 'combinations',prealloc);
% Using prealloc as a template to determine number of occurances in vallm variable

%% Final Results
% Tells the user which variables in the workspace are necessary for output in the research as other variables are 
% "byproducts" to the final result
% All unneeded variables are removed.
%clearvars
%disp('This script has completed its operations.')
%disp('You will need the following variables and export them to a .csv file in a spreadsheet editor:')
%disp('vallm - Discussion order of participants (for use in GEPHI)')
