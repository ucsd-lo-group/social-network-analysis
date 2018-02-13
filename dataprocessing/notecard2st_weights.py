# notecard2st.py
# turns notecard format csv to source,target format csv

import sys
import re
from itertools import groupby

# distribute lines into source,target format
# takes lines from stdin (format n1,n2,n3,...nm)
# returns formatted lines to stdout 
# (format n1,n2 <line break> n1,n3 <line break> ... n1,nm <line break>)
def distribute_st(lines):
  ret = []
  for line in lines:
    tokens = line.strip().split(',')
    for num in range(1,len(tokens)):
      ret.append(tokens[0]+','+tokens[num]+'\n')
  return ret

# replace consecutive commas with a single comma
def rm_multi_comma(lines):
  mcomma_patt = re.compile(r',+')
  ret = []
  for line in lines:
    ret.append(mcomma_patt.sub(',', line))
  return ret

# remove characters "," " " and "\t" from the end of each line
def rm_ending_chars(lines):
  char_patt = re.compile(r'[, \t]+$')
  ret = []
  for line in lines:
    ret.append(char_patt.sub('', line))
  return ret

def main(fin, fout_st, fout_weight):
  try: 
    file_in = open(fin, 'r')
  except OSError:
    print('Could not open file '+fin)
  try: 
    file_out_st = open(fout_st, 'w')
  except OSError:
    print('Could not open file '+fout_st)
  try: 
    file_out_weight = open(fout_weight, 'w')
  except OSError:
    print('Could not open file '+fout_weight)


  # FORMATTING
  # remove header
  file_in.readline()
  
  # get the lines of the file coming in
  lines = file_in.readlines()
  file_in.close()

  # remove multiple commas, then remove ending chars ", \t"
  # then distribute to source,target format
  formatted_lines = distribute_st(rm_ending_chars(
    rm_multi_comma(lines)))
  

  # Analyze lines
  
  # sort first, need ints
  int_lines = []
  for line in formatted_lines:
    left,right = line.strip('\n').split(',')
    int_lines.append([int(left), int(right)])
  int_lines.sort()


  print_lines = []
  for int_line in int_lines:
    print_lines.append(str(int_line)[1:-1].replace(' ', '')+'\n')

  # get weight, the number of times an edge appears
  weights = []
  idx = 0
  while (idx < len(print_lines)):
    curr = print_lines[idx]
    count = 0
    while ((idx < len(print_lines)) and (curr == print_lines[idx])):
      count += 1
      idx += 1
    weights.append(count)
  
  # keep only unique values
  unique_edges = []
  for e in print_lines:
    if e not in unique_edges:
      unique_edges.append(e)


  # write to csv (source,target and weights)
  unique_edges.insert(0, 'Source,Target\n')
  for line in unique_edges:
    file_out_st.write(line)
  file_out_st.close()

  weights.insert(0, 'weight')
  for line in weights:
    file_out_weight.write(str(line)+'\n')
  file_out_weight.close()
  

if __name__ == '__main__':
  fin = input('Input filename (notecard csv): ')
  fout_st = input('Output filename (source,target csv; duplicates will be overwritten): ')
  fout_weight = input('Output filename (weight csv; duplicates will be overwritten): ')
  main(fin, fout_st, fout_weight)