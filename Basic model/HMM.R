## HMM model
library(hmm.discnp)

hmm(y=train[,2], K=2,verbose=TRUE)


install.packages("RHmm_2.0.3.tar.gz", repos = NULL, type = "source")
# Function of HMM MAD score

HMM_MAD <- function(model, obs_levels){
  abs.error <- abs(obs.levels - predict.levels)
  
  
}


HMMFit(train, dis="NORMAL",nStates=3)
test.short <- train_test_split(train.end = c("2013-07-28"), test.start = c("2013-07-29"),combined.df=df)[[2]]
train <-train_test_split(train.end = c("2013-07-28"), test.start = c("2013-07-29"),combined.df=df)[[1]]


# Fit HMM model

fit_HMM <- function(error.metric){
  cat("Looking for optimal number of states and fitting HMM")
  cat("\n")
  for (i in seq(2,5)){
    #candidate = 
    
  }
  
}
