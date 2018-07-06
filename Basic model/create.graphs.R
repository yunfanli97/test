library(ggplot2)
library(reshape2)
library(lubridate)




agg_hist_graph <- function(agg.df){
  
  # reformat aggregated data to melted data frame
  melted.joins.by.time <- melt(agg.df, id='time')
  
  g <- ggplot(data = melted.joins.by.time, aes(x=time, y=value,group=variable, colour = variable))
  return(g)
  }


combined.df <- read.csv("combined.df.csv")[,-1]
head(combined.df)


df.for.24h <- combined.df[1:1441,]
df.for.12h <- combined.df[1:721,]


# 12hr plot
ggplot()+
  geom_line(data = melted.joins.by.time12h, aes(x=time, y=value, group = variable,colour = variable),size=1)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Appliances Usage for 12hr")


# 24hr plot
ggplot()+
  geom_line(data = melted.joins.by.time24h, aes(x=time, y=value, group = variable,colour = variable),size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Appliances Usage for 24hr")

# Air conditioner1 plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=air.conditioner1,group = 1),colour = 1,size=1)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Air Conditioner1 Usage for 24hr")

# Air conditioner2 plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=air.conditioner2,group = 2),colour = 2,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Air Conditioner2 Usage for 24hr")

# Washing Machine plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=washing.machine,group = 3),colour = 3,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Washing Machine Usage for 24hr")


# Laptop Computer plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=laptop.computer,group = 4),colour = 4,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Laptop Computer Usage for 24hr")

# Iron plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=iron,group = 5),colour = 5,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Iron Usage for 24hr")


# Kitchen Outlets plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=kitchen.outlets,group = 6),colour = 6,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Kitchen Outlets Usage for 24hr")


# Television plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=television,group = 8),colour = 8,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Television Usage for 24hr")

# Water Filter plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=water.filter,group = 10),colour = 10,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Water Filter Usage for 24hr")

# Water Motor plot
ggplot()+
  geom_line(data = df.for.24h, aes(x=time, y=water.motor,group = 1),colour = 1,size=0.5)+
  xlab("Time")+
  ylab("Power (W)")+
  labs(title = "Water Motor Usage for 24hr")


