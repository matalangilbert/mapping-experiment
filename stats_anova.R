library(ez)

anova_data <- read.csv("~/Dropbox/UniWork/MappingExperiment/D/r_primary_output_measure_d.csv")

attach(anova_data)

anova_output = ezANOVA(data = anova_data,
        dv = .(completion_time_in_seconds), 
        wid = .(subject),
        within = .(world_dimension, screen_dimension),
        return_aov = TRUE)

print(anova_output)

number_of_subjects = length(unique(subject))

anova_output.xx.error = sd(anova_data[world_dimension=='x' & screen_dimension=='x', 4]) / sqrt(number_of_subjects) 
anova_output.yy.error = sd(anova_data[world_dimension=='y' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)
anova_output.zz.error = sd(anova_data[world_dimension=='z' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.xy.error = sd(anova_data[world_dimension=='x' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)
anova_output.xz.error = sd(anova_data[world_dimension=='x' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.yx.error = sd(anova_data[world_dimension=='y' & screen_dimension=='x', 4]) / sqrt(number_of_subjects)
anova_output.yz.error = sd(anova_data[world_dimension=='y' & screen_dimension=='z', 4]) / sqrt(number_of_subjects)
anova_output.zx.error = sd(anova_data[world_dimension=='z' & screen_dimension=='x', 4]) / sqrt(number_of_subjects)
anova_output.zy.error = sd(anova_data[world_dimension=='z' & screen_dimension=='y', 4]) / sqrt(number_of_subjects)

interaction_error_bars = c(
  anova_output.xx.error,
  anova_output.xy.error,
  anova_output.xz.error,
  anova_output.yx.error,
  anova_output.yy.error,
  anova_output.yz.error,
  anova_output.zx.error,
  anova_output.zy.error,
  anova_output.zz.error
  )

interaction_error_bars


group_plot = ezPlot(
  data = anova_data,
  dv = .(completion_time_in_seconds),
  wid = .(subject),
  within = .(world_dimension, screen_dimension),
  x = .(world_dimension),
  split = .(screen_dimension),
  split_lab = 'Screen Dimension',
  do_lines = TRUE,
  bar_size = interaction_error_bars,
  x_lab = 'World Dimension',
  y_lab = 'Completion Time (s)')
print(group_plot)