# Visualize Disaggregation results
library(dplyr)
library(reshape2)
library(ggplot2)

predictions <- read.csv("prediction.csv")

air.cond1 <- data.frame(test$time,test$`air conditioner1`, predictions$air.conditioner1)
colnames(air.cond1) <- c('time','air conditioner1 act',"air conditioner1 pred")
head(air.cond1)



#downsample to 15min 
class(air.cond1$time)
air.cond1$by15 <- cut(as.POSIXct(as.character(air.cond1$time)), breaks = "15 min")

result.df.names <- c('air.conditioner1.results','air.conditioner2.results','washing.machine.results',
                     'laptop.computer.results','television.results')


test <- read.csv("test.csv")
colnames(test)
train <- read.csv("train.csv")
colnames(train)
short.df <- read.csv("short.df.0713-0804.csv")

for(i in 1:5){
  df <- data.frame(test[,1],test[,i+1],predictions[,i+1])
  colnames(df) <- c("time",paste(colnames(short.df)[i+1],".act",sep=""),
                    paste(colnames(short.df)[i+1],".pred",sep = ""))
  assign(result.df.names[i],df)
}
# 
# for(i in list(result.df.names)){
#   assign(i$by15,cut(as.POSIXct(as.character(i$time)), breaks = "15 min") )
#   #get(i)$by15 <-cut(as.POSIXct(as.character(get(i)$time)), breaks = "15 min")
# }
# 






ggplot(data = air.conditioner1.results[1:day.29.end.row,])+
  geom_line(aes(x=time, y=air.conditioner1.act,group = 1),colour = 1,size=0.5)+
  geom_line(aes(x=time, y=air.conditioner1.pred,group = 1),colour = 2,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Air Conditioner1 Usage for 24hr")


## 24hr results plots
day.29.end.row <-which(as.character(air.conditioner1.results$time) == "7/29/2013 23:59")
result_graph_24hr <- function(result.df,name){
  # reformat aggregated data to melted data frame
  melted.joins.by.time <- melt(result.df[1:day.29.end.row,], id='time')
  g <- ggplot(data = melted.joins.by.time, aes(x=time, y=value,group=variable, colour = variable,linetype=variable))+
    geom_line()+
    xlab("Time")+
    ylab("Power (W)")+
    labs(title = paste(name," - Usage for 24hr",sep = ""))
  return(g)
}

result_graph_24hr(air.conditioner1.results,name = "Air Conditioner1")
result_graph_24hr(air.conditioner2.results,name = "Air Conditioner2")
result_graph_24hr(laptop.computer.results, name = "Laptop Computer")
result_graph_24hr(washing.machine.results,name = "Washing Machine")
result_graph_24hr(television.results, name="Television")


## 12hr results plots
day.half.29.end.row <-which(as.character(air.conditioner1.results$time) == "7/29/2013 12:00")



result_graph_12hr <- function(result.df,name){
  
  # reformat aggregated data to melted data frame
  melted.joins.by.time <- melt(result.df[1:day.half.29.end.row,], id='time')
  g <- ggplot(data = melted.joins.by.time, aes(x=time, y=value,group=variable, colour = variable,linetype=variable))+
    geom_line()+
    xlab("Time")+
    ylab("Power (W)")+
    labs(title = paste(name," - Usage for 12hr",sep = ""))
  return(g)
}


result_graph_12hr(air.conditioner1.results,name = "Air Conditioner1")
result_graph_12hr(air.conditioner2.results,name = "Air Conditioner2")
result_graph_12hr(laptop.computer.results, name = "Laptop Computer")
result_graph_12hr(washing.machine.results,name = "Washing Machine")
result_graph_12hr(television.results, name="Television")




## Aggregate graph

#Actual
melt.test <- melt(test[1:day.half.29.end.row,],id='time')
g1 <- ggplot(data = melt.test, aes(x=time, y=value,group=variable, colour = variable))+
  geom_line()+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Actual Usage for 12hr")
g1


## Pridiction
colnames(predictions)
predictions$total <- rowSums(predictions[,-1])

melt.pred <- melt(predictions[1:day.half.29.end.row,],id='time')
g2 <- ggplot(data = melt.pred, aes(x=time, y=value,group=variable, colour = variable))+
  geom_line()+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Predicted Disaggregated Usage for 12hr")
g2

















##Group every 15 minutes
time.seq <- data.frame(format(seq.POSIXt(start.time, end.time, by = "15 min"), "%Y-%m-%d %H:%M"))




air.conditioner1.results$by15 <- cut(as.POSIXct(as.character(air.conditioner1.results$time)), breaks = "15 min")
head(air.conditioner1.results)

air.conditioner2.results$by15 <- cut(as.POSIXct(as.character(air.conditioner2.results$time)), breaks = "15 min")

washing.machine.results$by15 <-cut(as.POSIXct(as.character(washing.machine.results$time)), breaks = "15 min")

laptop.computer.results$by15 <-cut(as.POSIXct(as.character(laptop.computer.results$time)), breaks = "15 min")

television.results$by15 <- cut(as.POSIXct(as.character(television.results$time)), breaks = "15 min")

levels(air.conditioner1.results$time)
