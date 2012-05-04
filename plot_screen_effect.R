library(ez)
library(plotrix)
setwd("~/Dropbox/UniWork/MappingExperiment/Scripts")

input_data <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")
attach(input_data)

# *** PLOT: screen~mean completion time ***
screen_plot.x_values = c(1, 2, 3)
screen_plot.y_values = c(
  mean(input_data[screen_dimension=='x',4]),
  mean(input_data[screen_dimension=='y',4]),
  mean(input_data[screen_dimension=='z',4])
  )

screen_plot.error_bars = c(
  sd(input_data[screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[screen_dimension=='z',4]) / sqrt(number_of_subjects)
  )

#jpeg('screen_mean.jpg')

barplot(screen_plot.y_values,
        space=0.5,
        names.arg=c("x","y","z"),
        main="Screen Effect on Mean Completion Times",
        xlab="Screen Dimension",
        ylab="Mean Completion Time (s)",
        ylim=c(0,
               max(screen_plot.y_values)+max(screen_plot.error_bars)+50
               ),
        
        )
plotCI(c(1,2+0.5,3+1),
       screen_plot.y_values,
       screen_plot.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=3,
       )
#dev.off()
