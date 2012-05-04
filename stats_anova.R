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

# *** GRAPHS ***

# error bar utility function
error.bar <- function(x, y, upper, lower=upper, length=0.1,...){
  if(length(x) != length(y) | length(y) !=length(lower) | length(lower) != length(upper))
    stop("vectors must be same length")
  arrows(x,y+upper, x, y-lower, angle=90, code=3, length=length, ...)
}

# prepare standard error data
number_of_subjects = length(unique(subject))
anova_output.xx.error = sd(input_data[world_dimension=='x' & screen_dimension=='x', 4]) / sqrt(number_of_subjects) 
anova_output.yy.error = sd(input_data[world_dimension=='y' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)
anova_output.zz.error = sd(input_data[world_dimension=='z' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.xy.error = sd(input_data[world_dimension=='x' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)
anova_output.xz.error = sd(input_data[world_dimension=='x' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.yx.error = sd(input_data[world_dimension=='y' & screen_dimension=='x', 4]) / sqrt(number_of_subjects)
anova_output.yz.error = sd(input_data[world_dimension=='y' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.zx.error = sd(input_data[world_dimension=='z' & screen_dimension=='x', 4]) / sqrt(number_of_subjects)
anova_output.zy.error = sd(input_data[world_dimension=='z' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)

# *** PLOT: world~mean completion time ***
world_plot.x_values = c(1, 2, 3)
world_plot.y_values = c(
  mean(input_data[world_dimension=='x',4]),
  mean(input_data[world_dimension=='y',4]),
  mean(input_data[world_dimension=='z',4])
  )

world_plot.error_bars = c(
  sd(input_data[world_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z',4]) / sqrt(number_of_subjects)
)

jpeg('world_mean.jpg')
plot(world_plot.x_values,
     world_plot.y_values,
     xaxt="n", #suppress plotting of x-axis
     type="n",
     main="World Effect on Mean Completion Times",
     xlab="World Dimension",
     ylab="Mean Completion Time (s)",
     ylim=c(min(world_plot.y_values)-max(world_plot.error_bars),
            max(world_plot.y_values)+max(world_plot.error_bars)
            )
  )
axis(1,
     at=c(1:3),
     labels=c('x', 'y', 'z')
     )
points(world_plot.x_values,
       world_plot.y_values,
       pch=4,
       col=c("blue", "green", "purple"),
       )
lines(world_plot.x_values, 
      world_plot.y_values,
      col="black",
      lty=2
      )
error.bar(world_plot.x_values,
          world_plot.y_values,
          world_plot.error_bars
          )
dev.off()

# *** end PLOT world~mean completion time

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

jpeg('screen_mean.jpg')
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
error.bar(screen_plot.x_values,
          screen_plot.y_values,
          screen_plot.error_bars
          )
dev.off()

# *** end PLOT screen~mean completion time

# *** PLOT: world~screen interaction

interaction_plot.x_values = c(1, 2, 3, 1, 2, 3, 1, 2, 3)

interaction_plot.screenX.y_values = c(
  mean(input_data[world_dimension=='x' & screen_dimension=='x',4]),
  mean(input_data[world_dimensio interaction_plot.x_gap='y' & screen_dimension=='y',4]),
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
  sd(input_data[world_dimension=='z' & screen_dimension=='x',4]) / sqrt(number_of_subjects),  
  )
interaction_plot.screenY.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='y',4]) / sqrt(number_of_subjects),  
  )
interaction_plot.screenZ.error_bars = c(
  sd(input_data[world_dimension=='x' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='y' & screen_dimension=='z',4]) / sqrt(number_of_subjects),
  sd(input_data[world_dimension=='z' & screen_dimension=='z',4]) / sqrt(number_of_subjects),  
  )

#png('interaction.png')
plot(interaction_plot.x_values,
     interaction_plot.y_values,
     xaxt="n", #suppress plotting of x-axis
     type="n",
     main="World ~ Screen Interaction Effect on Mean Completion Times",
     xlab="World Dimension",
     ylab="Mean Completion Time (s)",
     ylim=c(min(interaction_plot.y_values)-max(interaction_plot.error_bars),
            max(interaction_plot.y_values)+max(interaction_plot.error_bars)
            )
     )
axis(1,
     at=c(1:3),
     labels=c('x', 'y', 'z')
     )
points(interaction_plot.x_values,
       interaction_plot.y_values,
       pch=4,
       col=c("blue", "green", "purple"),
       )
lines(c(1,2,3), 
      interaction_plot.screenX.y_values,
      col=c("springgreen"),
      lty=2
      )
lines(c(1,2,3), 
      interaction_plot.screenY.y_values,
      col=c("green"),
      lty=2
      )
lines(c(1,2,3), 
      interaction_plot.screenZ.y_values,
      col=c("orange"),
      lty=2
      )

offset=0.05

plotCI(interaction_plot.x_values,
       interaction_plot.y_values,
       interaction_plot.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       aes(position=position_jitter(0.05))
       )
#error.bar(interaction_plot.x_values,
#          interaction_plot.y_values,
#          interaction_plot.error_bars,
#          position=interaction_plot.x_gap
#          )
#dev.off()
