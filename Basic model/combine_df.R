


## Function to combine multiple appliance usage data frames in to one dataframe 

combine_df <- function(list.labels, start.time, end.time, app.names){
  # list.labels: list of appliances labels
  # start.time: start time of the usage data. Format example "2013-07-13 00:01:00"
  # end.time : end time of the usage data. Format example "2013-08-4 23:59:00"
  
  #create a time sequence with 1 minute gap 
  start.time <- as.POSIXct(start.time)
  end.time <- as.POSIXct(end.time)
  #t <- seq.POSIXt(start.time, end.time, by = "1 min")
  time.seq <- data.frame(format(seq.POSIXt(start.time, end.time, by = "1 min"), "%Y-%m-%d %H:%M"))
  #cat(time.seq[1,1])
  colnames(time.seq) <- c("time")
  cat("Time sequence created!")
  cat("\n")
  
  # Create a list of names of data frames to combine
  list.of.df.combine <- c('time.seq', list.labels)
  
  # Combine time sequence with each appliance power data frame and rename columns 
  df.join <- join_all(lapply(list.of.df.combine, get), by = "time", type = 'left') 
  cat("Join all dataframes successed")
  cat("\n")
  colnames(df.join) <- c("time", app.names)
  cat("Modified colnames to appliance names")
  cat("\n")
  df.join <- df.join %>% 
    mutate_if(is.numeric,funs(replace(., is.na(.), 0)))
  
  cat("Replace NA with 0s done!")
  cat("\n")
  return(df.join)
  }
  



## Create a list of time from 7-13 to 8-4
app.names.list <- c( "fridge","air conditioner1","air conditioner2", 
                "washing machine", "laptop computer","iron",
                "kitchen outlets","television","water filter","water motor")

#start <- as.POSIXct("2013-07-13 00:01:00")
#end <- as.POSIXct("2013-08-4 23:59:00")




