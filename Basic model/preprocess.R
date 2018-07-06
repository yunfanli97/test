library(lubridate)
library(dplyr)
library(plyr)




## Function to load the data
# 


convert_to_datetime <- function(x){
  
  return (as.POSIXct(x,origin = '1970-01-01'))
}

load_data <- function(filepath, label){
  
  filename <- paste(filepath, "/",toString(label),'.csv',sep = "")
  cat(paste("Reading csv file for label", label, sep = ""))
  cat("\n")
  app.df <- read.csv(filename)
  cat(paste("Converting timestamp to date time", label, sep = ""))
  cat("\n")
  #change timestamp to date time format
  app.df$timestamp <- lapply(app.df$timestamp,convert_to_datetime)

  #change time from list of list to vector
  #app.df$timestamp <- do.call(c, app.df$timestamp)

  app.df <- data.frame(cbind(app.df$timestamp, app.df$W))
  colnames(app.df) <- c('time','W')
  return(app.df)
}




## Resampling

# Convert time and power lists to vectors
convert_lists_to_vector <- function(df){
  df$time <- do.call(c, df$time)
  #convert power list
  df[,2] <- do.call(c, df[,2])
  return(df)
}

# Format time and and delete seconds
delete_seconds <- function(df){
  df$time <- format(df$time, "%Y-%m-%d %H:%M")
  return(df)
}

# 
# 
# #function to extract date, hour and minute from time
# extract_date_hour_minute <- function(df){
#   #df<-convert_lists_to_vector(app6)
#  
#   df$date <- date(df$time)
#   df$hour <- hour(df$time)
#   df$minute <- minute(df$time)
#   return(df)
# }


# Funciton to group df by minute and compute mean 
downsample_by_minute <- function(df){
  df <- aggregate(df$W, by = list(df$time), FUN=mean)
  colnames(df) <- c("time", "W.per.min")
  return(df)
}







########################################################################################

## Read multiple files into dataframe

filepath <- "C:/Users/yli/Desktop/energy disaggregation/data/iAWE"
app.labels <- seq(5,6)
list_names <- c()

for(i in 1:length(app.labels)){
  df <-load_data(filepath,label = app.labels[i])
  assign(noquote(paste("app",app.labels[i],sep = "")),df)
  list_names <- cbind(list_names, paste("app",app.labels[i],sep = ""))
  }



##Data reorganizing, formatting and downsampling


for (app in list_names){
  df <- get(app) %>%
    convert_lists_to_vector() %>%
    delete_seconds() %>%
    downsample_by_minute()
  #assign(app, df)
  assign(noquote(app),df)
  cat("Start writing csv file for ", app)
  cat("\n")
  write.csv(df,file=paste('test.',app,'.csv',sep=""))
  cat("Finish writing ",app, ".csv")
}

class(app6$time)





app6 <- load_data(filepath,6)
app6$time
ap6<- load_data(filepath,6) %>%
  convert_lists_to_vector() %>%
  delete_seconds() %>%
  downsample_by_minute()

ap6$time





# 
# 
# merge(app3,app4,by.x= c('time'),by.y=c('time'))
# 
# 
# df<-inner_join(app3,app4,by.x= c('time'),by.y=c('time'))%>%
#   inner_join(.,app5,by.x= c("time"),by.y=c('time'))
# convert_to_datetime(min(df$time))
# convert_to_datetime(max(df$time))
# 
#   
#   #inner_join(.,app6,by.x= c("time"),by.y=c('time'))%>%
#  # merge(.,app7,by.x= c("time"),by.y=c('time'))%>%
#   merge(.,app8,by.x= c("time"),by.y=c('time'))
# 
# dim(df)

  # convert_to_datetime(min(com$X1))
  # 
  # merge(x=app6, y=app4,by= 'X1')
  # 
  # df <- inner_join(x=app3, y=app4, by=timestamp) %>%
  #       inner_join(x=df, y=app5, by=timestamp) %>%
  #       innter_join(x=df, y=app6, by=timestamp)
#   


## Downsample

#Group by minutes and get means

# create new df containing W per minute for apps

