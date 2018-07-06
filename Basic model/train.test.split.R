## Train test split
library(lubridate)

# head(df)
# 
# 
# lapply(combined.df$time,date)
# as.Date(as.character(combined.df$time))
# class(as.character(combined.df$time))
#  
# data.frame(strsplit(as.character(combined.df$time), " "))
# sapply(as.character(combined.df$time), strsplit,split = " ")[1]
# 
# #Extract date from time
# df$date <- as.Date(as.character(df$time),format = "%Y-%m-%d %H:%M")
# df.days <- levels(factor(df$date))
# length(df.days)
# train.end <- c("2013-07-28")
# test.start <- c("2013-07-29")
# 
# train.row.end <- which(df$date == train.end)[length(which(df$date == train.end))]
# test.row.start <- which(df$date == test.start)[1]
# train.df <- df[1:train.row,]
# test.df <- df[c(train.row+1):nrow(df),]
# train.df <- c()
# test.df <- c()


train_test_split <- function(train.end, test.start, combined.df){
  #train.end: end date for training set. format eg "2013-07-28"
  #test.start: start date for testing set. format eg "2013-07-29"
  combined.df$date <- as.Date(as.character(combined.df$time),format = "%Y-%m-%d %H:%M")
  combined.df.days <- levels(factor(combined.df$date))
  train.row.end <- which(combined.df$date == train.end)[length(which(combined.df$date == train.end))]
  test.row.start <- which(combined.df$date == test.start)[1]
  combined.df <- combined.df[, -ncol(combined.df)]
  train.df <- combined.df[1:train.row.end,]
  train.df$total <- rowSums(train.df[,2:ncol(train.df)])
  test.df <- combined.df[test.row.start:nrow(combined.df),]
  test.df$total <- rowSums(test.df[,2:ncol(test.df)])
  
  return(list(train.df, test.df))

}

short.df <- data.frame(df$time,df$`air conditioner1`,df$`air conditioner2`,
                       df$`washing machine`,df$`laptop computer`,
                      df$television)
colnames(short.df) <- c( "time","air conditioner1","air conditioner2", 
                         "washing machine", "laptop computer","television")
  
#short.df<- read.csv("short.df.0713-0804.csv")
head(short.df)

test <- read.csv("test.csv")[,-1]
head(test)
ncol(test)
test$total <- rowSums(test[, 2:6])
test <- test[,-7]

test <- train_test_split(train.end = c("2013-07-28"), test.start = c("2013-07-29"),combined.df=short.df)[[2]]
train <-train_test_split(train.end = c("2013-07-28"), test.start = c("2013-07-29"),combined.df=short.df)[[1]]


write.csv(test,file="test.csv")
write.csv(train,file="train.csv")
