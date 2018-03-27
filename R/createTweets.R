################################################################################
################################################################################
## Title: Create Tweets
## Author: Steve Lane
## Date: Tuesday, 27 March 2018
## Synopsis: Creates tweets for twitterbot
## Time-stamp: <2018-03-27 14:40:03 (slane)>
################################################################################
################################################################################
library(dplyr)
library(httr)
library(rtweet)
source("getLists.R")
source("getImage.R")
source("tweetImage.R")

## Grab all pests
all_pests <- getLists()

## Send a tweet every 15 minutes with a randomly selected pest (may get
## repeats!) until the end of invasives week.
start <- Sys.time()
intermediate <- Sys.time()
duration <- as.numeric(intermediate - start) / 60
while (duration < (84 * 60)) {
    ## Sample a pest
    one_pest <- getImage(all_pests)
    ## Tweet
    tweetImage(one_pest)
    ## Go to sleep for 15 minutes
    Sys.sleep(60 * 15)
    intermediate <- Sys.time()
    duration <- as.numeric(intermediate - start) / 60
}
