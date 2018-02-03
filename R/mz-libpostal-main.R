libpostal_url <- function(endpoint, ..., api_key = mz_key()) {
    query <- list(...)

    query <- c(
        api_key = api_key,
        query
    )

    structure(
        list(
            scheme = "https",
            hostname = getOption("RMAPZEN.libpostal.host"),
            path = endpoint,
            query = query),
        class = "url"
    )
}

#' @importFrom ratelimitr limit_rate
libpostal_GET <- ratelimitr::limit_rate(
    httr::GET,
    ratelimitr::rate(n = 6, period = 1)
)

#' @import assertthat
libpostal_get <- function(url) {
    response <- libpostal_GET(httr::build_url(url))
    libpostal_process(response)
}

libpostal_process <- function(response) {
    httr::stop_for_status(response)

    # unclear, what the libpostal usage limit is
    # # update the usage statistics
    # header <- httr::headers(response)
    # mz_update_usage(header, "search")

    txt <- httr::content(response, as = "text", encoding = "UTF-8")
    lst <- jsonlite::fromJSON(txt, simplifyVector = FALSE)
    lst
    # structure(lst, class = c("mapzen_geo_list", "geo_list"))
}


