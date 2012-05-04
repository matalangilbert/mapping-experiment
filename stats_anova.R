library(ez)
setwd("~/Dropbox/UniWork/MappingExperiment/Scripts")

input_data <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")
attach(input_data)

#run ANOVA 
anova_output = ezANOVA(data = input_data,
        dv = .(completion_time_in_seconds), 
        wid = .(subject),
        within = .(world_dimension, screen_dimension),
        return_aov = TRUE)
print(anova_output)

