# Data exploration
library(ggplot2)




ggplot(data=combined.df,aes(x=time, y=fridge))+
  geom_point()

ggplot(app3, aes(x=timestamp, y=W))+
  geom_area(stat="bin")

min(app3$timestamp)
max(app3$timestamp)

individual_app_graph <- function(label){
  label <- noquote(paste(label, '.W',sep=""))
  ggplot(data=df$label, aes(x=time,y = label))+
    geom_histogram
}

agg_hist_graph <- function(agg.df){
  # reformat aggregated data to melted data frame
  melted.joins.by.time <- melt(agg.df, id='time')
  ggplot(data = melted.joins.by.time, aes(x=time, y=value, colour = variable))
}

