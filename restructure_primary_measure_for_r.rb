#!/usr/bin/env ruby
require 'csv'

input_file = "/home/mat/Dropbox/UniWork/MappingExperiment/D/primary_output_measure_d.csv"
output_file = "/home/mat/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv"

CSV.open(output_file, "w") do |csv|
  csv << [
    "subject", 
    "world_dimension", 
    "screen_dimension", 
    "completion_time_in_seconds" ]

  first_row = true # used to ignore CSV header
  
  CSV.foreach("#{input_file}") do |row|
    unless first_row
      subject = row[0]
      csv << [subject, "x", "x", (row[1].to_i/1000).to_s]
      csv << [subject, "y", "y", (row[2].to_i/1000).to_s]
      csv << [subject, "z", "z", (row[3].to_i/1000).to_s]
      csv << [subject, "x", "y", (row[4].to_i/1000).to_s]
      csv << [subject, "x", "z", (row[5].to_i/1000).to_s]
      csv << [subject, "y", "x", (row[6].to_i/1000).to_s]
      csv << [subject, "y", "z", (row[7].to_i/1000).to_s]
      csv << [subject, "z", "x", (row[8].to_i/1000).to_s]
      csv << [subject, "z", "y", (row[9].to_i/1000).to_s]
      puts "Subject #{subject} restructured"
    end
    first_row = false
  end
end

puts "Restructure complete!\nOutput file: #{output_file}"

