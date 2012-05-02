library(ez)

primary_output_measure_d <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")

attach(primary_output_measure_d)

dm_anova = ezANOVA(data = primary_output_measure_d,
        dv = .(completion_time_in_seconds), 
        wid = .(subject),
        within = .(world_dimension, screen_dimension),
        return_aov = TRUE)

print(dm_anova)