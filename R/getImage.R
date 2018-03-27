## Given the whole data frame of pests, sample one, then draw it out.
getImage <- function(pest_list) {
    ## Sample pest
    pest <- pest_list %>%
        dplyr::sample_n(1)

    ## Get list of images
    pest_images <-
        httr::GET(paste0("https://api.bugwood.org/rest/api/image.json?include=description,citation&sub=", pest$id)) %>%
        httr::content(as = "parsed")
    pest_images <- lapply(pest_images$rows, img_to_data) %>%
        dplyr::bind_rows()

    ## Sample one of the images
    pest_image <- pest_images %>%
        dplyr::sample_n(1)

    ## Download to tempdir
    url <- paste0("http://bugwoodcloud.org/images/384x256/",
                  pest_image$imgnum, ".jpg")
    dest <- paste0(tempdir(), "/pest.jpg")
    download.file(url, dest, quiet = TRUE)

    ## Output data frame for rendering
    ref <- paste0("https://www.invasive.org/browse/detail.cfm?imgnum=",
                  pest_image$imgnum)
    pest <- dplyr::bind_cols(pest, pest_image) %>%
        dplyr::mutate(img = dest, ref = ref)
    pest
}

## Helper function to turn image list into data frame
img_to_data <- function(x) {
    xx <- dplyr::as_data_frame(x) %>%
        dplyr::mutate(imgnum = as.integer(imgnum))
    xx
}
