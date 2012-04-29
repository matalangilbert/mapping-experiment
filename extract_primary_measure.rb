#!/usr/bin/env ruby
require 'csv'

data_directory = "/home/mat/Dropbox/UniWork/MappingExperiment/RubyProcessed"
output_directory = "/home/mat/Dropbox/UniWork/MappingExperiment/OutputMeasures"

Dir.chdir data_directory # change to data directory

# open output file:
output_file = CSV.open("#{output_directory}/output_measures_per_subject.csv",'w')

mapping_position = { "x" => 1, "y" => 2, "z" => 3, "xy" => 4, "xz" => 5, "yx" => 6,
  "yz" => 7, "zx" => 8, "zy" => 9 } # maps mapping name to position in output array

output_file << ["Subject", "xx", "yy", "zz", "xy", "xz", "yx", "yz", "zx", "zy"]

results_array = Array.new
subjects = Array.new

Dir.glob("*.csv").each do |file_name| # for each .csv file in the data directory
  input_file = CSV.read(file_name) # open raw input file
  
  subject_number = file_name.scan(/[\d]/).join # get subject number from filename
  mapping = file_name.scan(/[x-z]/).join # get mapping from filename
  elapsed_time = input_file.last[2].to_i - input_file[1][2].to_i 
  
  subjects << subject_number # collect array of all subject numbers
  results_array << [subject_number, mapping, elapsed_time]
end

subjects.uniq.each do |subject| # for each unique subject
  mapping_results = Array.new 
  # select all subject results:
  subject_results = results_array.select do |subject_result| 
    subject_result[0] == subject
  end.collect do |result|
    # put each result into correct position in output array:
    mapping_results[mapping_position[result[1]]] = result[2] unless result[2].nil?
  end
  # write subject's results to output file:
  output_file << [subject,mapping_results[1],mapping_results[2],mapping_results[3],
    mapping_results[4],mapping_results[5],mapping_results[6],mapping_results[7],
    mapping_results[8],mapping_results[9]]
end

