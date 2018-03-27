################################################################################
################################################################################
## Title: Create Tweets
## Author: Steve Lane
## Date: Tuesday, 27 March 2018
## Synopsis: Creates tweets for twitterbot
## Time-stamp: <2018-03-27 13:59:14 (slane)>
################################################################################
################################################################################
library(dplyr)
library(httr)
library(rtweet)
source("getLists.R")
source("getImage.R")
source("tweetImage.R")
all_pests <- getLists()
one_pest <- getImage(all_pests)
tweetImage(one_pest)
