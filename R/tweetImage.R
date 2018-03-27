## Given the chosen pest, create a tweet
tweetImage <- function(pest) {
    
    ## Tweet string
    twt <- paste0(
        pest$scientificname,
        " (",
        pest$commonname,
        "). Image by ",
        pest$citation,
        " (",
        pest$ref,
        ") #GetINNSvolved"
    )

    ## Send tweet
    rtweet::post_tweet(
                status = twt,
                media = pest$img
            )
}
