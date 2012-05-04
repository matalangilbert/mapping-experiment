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

number_of_subjects = length(unique(subject))
screen_plot.error_bars = c(
  sd(input_data[screen_dimension=='x',4]) / sqrt(number_of_subjects),
  sd(input_data[screen_dimension=='y',4]) / sqrt(number_of_subjects),
  sd(input_data[screen_dimension=='z',4]) / sqrt(number_of_subjects)
  )

#jpeg('screen_mean.jpg')

ymax=c(0,
       max(screen_plot.y_values)+max(screen_plot.error_bars)+50
       )

barplot(screen_plot.y_values,
        space=0.5,
        names.arg=c("x","y","z"),
        main="Screen Effect on Mean Completion Times",
        xlab="Screen Dimension",
        ylab="Mean Completion Time (s)",
        ylim=ymax        
        )
plotCI(c(1,2+0.5,3+1),
       screen_plot.y_values,
       screen_plot.error_bars,
       err='y',
       add=TRUE,
       lty=1,
       pch=3
       )

# *** TODO: ADD signficance *'s when calculated
#text(x=c(1,2+0.5,3+1),
#     y=screen_plot.y_values+screen_plot.error_bars+10,
#     labels=c("","*","")
#         )
#dev.off()
