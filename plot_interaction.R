library(plotrix)
setwd("~/Dropbox/UniWork/MappingExperiment/Scripts")

input_data <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")
attach(input_data)

# *** PLOT: world~screen interaction
interaction_plot.x_values = c(1, 2, 3, 1, 2, 3, 1, 2, 3)
offset=0.05

interaction_plot.screenX.y_values = c(
  mean(input_data[world_dimension=='x' & screen_dimension=='x',4]),
  mean(input_data[world_dimension=='y' & screen_dimension=='x',4]),
  mean(input_data[world_dimension=='z' & screen_dimension=='x',4])
  )

interaction_plot.screenY.y_values = c(
  mean(input_data[world_dimension=='x' & screen_dimension=='y',4]),
  mean(input_data[world_dimension=='y' & screen_dimension=='y',4]),
  mean(input_data[world_dimension=='z' & screen_dimension=='y',4])
  )

interaction_plot.screenZ.y_values = c(
  mean(input_data[world_dimension=='x' & screen_dimension=='z',4]),
  mean(input_data[world_dimension=='y' & screen_dimension=='z',4]),
  mean(input_data[world_dimension=='z' & screen_dimension=='z',4])
  )

interaction_plot.y_values = c(
  interaction_plot.screenX.y_values,
  interaction_plot.screenY.y_values,
  interaction_plot.screenZ.y_values
  )
number_of_subjects = length(unique(subject))
interaction_plot.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='x' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='x' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='z',4]) / sqrt(number_of_subjects)
  )

interaction_plot.screenX.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='x',4]) / sqrt(number_of_subjects)
  )
interaction_plot.screenY.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='y',4]) / sqrt(number_of_subjects) 
  )
interaction_plot.screenZ.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='z',4]) / sqrt(number_of_subjects)
  )

#png('interaction.png')
plot(interaction_plot.x_values,
     interaction_plot.y_values,
     xaxt="n", #suppress plotting of x-axis
     type="n",
     main="World ~ Screen Effect on Mean Completion Times",
     xlab="World Movement",
     ylab="Mean Completion Time (s)",
     ylim=c(min(interaction_plot.y_values)-max(interaction_plot.error_bars),
            max(interaction_plot.y_values)+max(interaction_plot.error_bars)
            )
     )
axis(1,
     at=c(1:3),
     labels=c('x', 'y', 'z')
     )
points(c(1:3) + offset,
       interaction_plot.screenX.y_values,
       pch=4,
       col=c("springgreen"),
       )
points(c(1:3) - offset,
       interaction_plot.screenY.y_values,
       pch=4,
       col=c("purple"),
       )
points(c(1:3),
       interaction_plot.screenZ.y_values,
       pch=4,
       col=c("orange"),
       )
lines(c(1,2,3)+offset, 
      interaction_plot.screenX.y_values,
      col=c("red"),
      lty=2
      )
lines(c(1,2,3)-offset, 
      interaction_plot.screenY.y_values,
      col=c("blue"),
      lty=2
      )
lines(c(1,2,3), 
      interaction_plot.screenZ.y_values,
      col=c("cyan"),
      lty=2
      )

plotCI(c(1:3)+offset,
       interaction_plot.screenX.y_values,
       interaction_plot.screenX.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=4
       )
plotCI(c(1:3)-offset,
       interaction_plot.screenY.y_values,
       interaction_plot.screenY.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=4
       )
plotCI(c(1:3),
       interaction_plot.screenZ.y_values,
       interaction_plot.screenZ.error_bars,
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
#dev.off(dev.cur())
