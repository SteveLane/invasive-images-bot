getLists <- function() {
    ## Plant list
    plants <-
        httr::GET("https://api.bugwood.org/rest/api/subject/.json?neq=cat2:278,sub:22115+59409+59419+59420+59737+61975+76954+59408+59738&includeonly=id,commonname,scientificname,count&fmt=datatable&&systemid=2&imagerecruitproject=17&div=5&draw=5&start=0&length=1600&search[value]=&_=1522107416634") %>%
        httr::content(as = "parsed")
    plants <- lapply(plants$data, to_data, nm = unlist(plants$columns))
    plants <- plants %>%
        dplyr::bind_rows() %>%
        dplyr::distinct() %>%
        dplyr::mutate(type = "plants")

    ## Insect list
    insects <-
        httr::GET("https://api.bugwood.org/rest/api/subject/.json?neq=cat2:278,sub:22115+59409+59419+59420+59737+61975+76954+59408+59738&includeonly=id,commonname,scientificname,count&fmt=datatable&&systemid=2&imagerecruitproject=17&div=1&draw=6&start=0&length=110&search[value]=&_=1522107416635") %>%
        httr::content(as = "parsed")
    insects <- lapply(insects$data, to_data, nm = unlist(insects$columns))
    insects <- insects %>%
        dplyr::bind_rows() %>%
        dplyr::distinct() %>%
        dplyr::mutate(type = "insects")

    ## Disease list
    diseases <-
        httr::GET("https://api.bugwood.org/rest/api/subject/.json?neq=cat2:278,sub:22115+59409+59419+59420+59737+61975+76954+59408+59738&includeonly=id,commonname,scientificname,count&fmt=datatable&&systemid=2&imagerecruitproject=17&div=2&draw=7&start=0&length=126&search[value]=&_=1522107416636") %>%
        httr::content(as = "parsed")
    diseases <- lapply(diseases$data, to_data, nm = unlist(diseases$columns))
    diseases <- diseases %>%
        dplyr::bind_rows() %>%
        dplyr::distinct() %>%
        dplyr::mutate(type = "diseases")

    ## Wildlife list
    wildlife <-
        httr::GET("https://api.bugwood.org/rest/api/subject/.json?neq=cat2:278,sub:22115+59409+59419+59420+59737+61975+76954+59408+59738&includeonly=id,commonname,scientificname,count&fmt=datatable&&systemid=2&imagerecruitproject=17&div=7&draw=8&start=0&length=250&search[value]=&_=1522107416637") %>%
        httr::content(as = "parsed")
    wildlife <- lapply(wildlife$data, to_data, nm = unlist(wildlife$columns))
    wildlife <- wildlife %>%
        dplyr::bind_rows() %>%
        dplyr::distinct() %>%
        dplyr::mutate(type = "wildlife")

    ## Combine all and return
    all_lists <- dplyr::bind_rows(
                            plants,
                            insects,
                            diseases,
                            wildlife
                        )
    all_lists
}

## Helper function to transform lists into data frames.
to_data <- function(x, nm) {
    names(x) <- nm
    xx <- dplyr::as_data_frame(x)
    xx
}
