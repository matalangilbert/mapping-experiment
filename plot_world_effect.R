library(plotrix)
setwd("~/Dropbox/UniWork/MappingExperiment/Graphs")

input_data <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")
attach(input_data)

world_plot.x_values = c(1, 2, 3)
world_plot.y_values = c(
  mean(input_data[world_dimension=='x',4]),
  mean(input_data[world_dimension=='y',4]),
  mean(input_data[world_dimension=='z',4])
  )

number_of_subjects = length(unique(subject))
world_plot.error_bars = c(
  sd(input_data[world_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z',4]) / sqrt(number_of_subjects)
  )
ymax=c(0,
       max(world_plot.y_values)+max(world_plot.error_bars)+50
       )

#jpeg('world_mean.jpg')
barplot(world_plot.y_values,
        space=0.5,
        names.arg=c("x","y","z"),
        main="World Effect on Mean Completion Times",
        xlab="World Dimension",
        ylab="Mean Completion Time (s)",
        ylim=ymax        
        )
plotCI(c(1,2+0.5,3+1),
       world_plot.y_values,
       world_plot.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=3
       )

#dev.off()