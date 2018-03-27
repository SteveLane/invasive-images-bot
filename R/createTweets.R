################################################################################
################################################################################
## Title: Create Tweets
## Author: Steve Lane
## Date: Tuesday, 27 March 2018
## Synopsis: Creates tweets for twitterbot
## Time-stamp: <2018-03-27 14:15:57 (slane)>
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

## Send a tweet every hour with a randomly selected pest (may get repeats!)
repeat({
    ## Sample a pest
    one_pest <- getImage(all_pests)
    ## Tweet
    tweetImage(one_pest)
    ## Go to sleep for 15 minutes
    Sys.sleep(60 * 15)
})
