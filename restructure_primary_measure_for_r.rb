#!/usr/bin/env ruby
require 'csv'

data_directory = "/home/mat/Dropbox/UniWork/MappingExperiment/D"
output_file = "/home/mat/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv"

CSV.open(output_file, "w") do |csv|
  csv << ["subject", "world_dimension", "screen_dimension", "completion_time_in_seconds"]
  conditions = Array.new
  first_row = true
  
  CSV.foreach("#{data_directory}/primary_output_measure_d.csv") do |row|
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
    end
    first_row = false
  end
end


