#!/usr/bin/env ruby
require 'csv'

data_directory = "/home/mat/Dropbox/UniWork/MappingExperiment/RawData"
output_directory = "/home/mat/Dropbox/UniWork/MappingExperiment/RubyProcessed"

Dir.chdir data_directory # change to data directory

file_list = Dir.glob("*.csv") # array of all .csv filepaths
file_list.sort!

#file_name = file_list[0]
file_list.each do |file_name|

csv_file = CSV.open(file_name, 'r') # open raw input file
  output_file = CSV.open("#{output_directory}/#{file_name}",'w') # open output file
  
  csv_file.each_with_index do |row, index| # for each input file
    if index == 1 # if processing the first row
      output_file << row unless row[2].to_i > 100 # don't write first row -> 
    else                        # -> if has wrong timestamp (happens occasionally)
      row[1] = (29-row[1].to_i) + 1 unless index == 0 # fix target numbers
      output_file << row # write to output file
    end
  end
end

files_processed =  Dir.entries("#{output_directory}").length - 2 # -2 for .. and .
puts "Files processed: #{files_processed}"
