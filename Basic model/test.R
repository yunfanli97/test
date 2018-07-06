
# Chose start and end date as 7-13-2013 and 8-4-2013
# Downsampled data to 1 minute resolution
# Ignored water motor which didn't have sufficient data in this time window
# Filled gaps where data was missing with zeros (this indicates appliance was not being used)
# Ensured that all appliances and both the mains have equal amount of data

######################


filepath <- "C:/Users/yli/Desktop/energy disaggregation/data/iAWE"


#filep <- 
app.labels <- seq(3,12)
list.labels <- c()

for(i in 1:length(app.labels)){
  df <-load_data(filepath,label = app.labels[i])
  assign(noquote(paste("app",app.labels[i],sep = "")),df)
  list.labels <- cbind(list.labels, paste("app",app.labels[i],sep = ""))
}



##Data reorganizing, formatting and downsampling


for (app in list.labels){
  df <- get(app) %>%
    convert_lists_to_vector() %>%
    delete_seconds() %>%
    downsample_by_minute()
  assign(app, df)
  cat("Start writing csv file for ", app)
  cat("\n")
  #write.csv(df,file=paste('new.',app,'.csv',sep=""))
  cat("Finish writing ",app, ".csv")
}
head(app3)

app3 <- read.csv("new.app3.csv")[,-1]
app4 <- read.csv("new.app4.csv")[,-1]
app5 <- read.csv("new.app5.csv")[,-1]
app6 <- read.csv("new.app6.csv")[,-1]
app7 <- read.csv("new.app7.csv")[,-1]
app8 <- read.csv("new.app8.csv")[,-1]
app9 <- read.csv("new.app9.csv")[,-1]
app10 <- read.csv("new.app10.csv")[,-1]
app11 <- read.csv("new.app11.csv")[,-1]
app12 <- read.csv("new.app12.csv")[,-1]

list.labels <- c("app3","app4","app5","app6","app7","app8","app9","app10","app11","app12")

## Combine_df
## Create a list of time from 7-13 to 8-4
app.names.list <- c( "fridge","air conditioner1","air conditioner2", 
                     "washing machine", "laptop computer","iron",
                     "kitchen outlets","television","water filte","water motor")

start.time<- as.POSIXct("2013-07-13 00:01:00")
end.time <- as.POSIXct("2013-08-4 23:59:00")



########################################################################################
#Read combined df


combined.df <- read.csv("combined.df.csv")[,-1]
head(combined.df$time)

df <- combine_df(list.labels , start.time , end.time, app.names=app.names.list)
class(df$time)
head(df)
class(df$time)
which(as.character(df$time)=="2013-07-13 23:59")
class(lapply(list.of.df.combine, get))

df.for.24h <- combined.df[1:1439,]
head(df.for.24h)
dim(df.for.24h)
















