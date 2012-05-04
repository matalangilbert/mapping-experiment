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
plot(screen_plot.x_values,
     screen_plot.y_values,
     xaxt="n", #suppress plotting of x-axis
     type="n",
     main="Screen Effect on Mean Completion Times",
     xlab="Screen Dimension",
     ylab="Mean Completion Time (s)",
     ylim=c(min(screen_plot.y_values)-max(screen_plot.error_bars),
            max(screen_plot.y_values)+max(screen_plot.error_bars)
            )
     )
axis(1,
     at=c(1:3),
     labels=c('x', 'y', 'z')
     )
points(screen_plot.x_values,
       screen_plot.y_values,
       pch=4,
       col=c("blue", "green", "purple"),
       )
lines(screen_plot.x_values, 
      screen_plot.y_values,
      col="black",
      lty=2
      )
plotCI(c(1:3),
       screen_plot.y_values,
       screen_plot.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=4
       )
legend(2.65,405,
       legend=c("x","y","z"),
       lty=1,
       lwd=3,
       col=c("red","blue","cyan"),
       title="Screen"
       )
#dev.off()
