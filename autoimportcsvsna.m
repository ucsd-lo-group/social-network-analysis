%% Import data from text file.
% Script for importing data from the following text file:
%
%    C:\Research\ImportCSVProcessing\import.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.
disp('Running data importer, please be patient...')

%% Initialize variables.
filename = 'C:\Research\ImportCSVProcessing\import.csv';
delimiter = ',';
startRow = 2;

%% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r','n','UTF-8');
% Skip the BOM (Byte Order Mark).
fseek(fileID, 3, 'bof');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
q = dataArray{:, 1};
r = dataArray{:, 2};


%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;