#' @import assertthat
build_parse_addr_url <- function(
    address, format_keys = FALSE, api_key = mz_key())
{
    assert_that(is.string(address))
    assert_that(is.logical(format_keys))

    if(format_keys == TRUE)
        format <- "keys"
    else
        format <- NULL

    query <- list()

    query <- c(
        query,
        address = address,
        format = format,
        api_key = api_key
    )
    query <- query[!is.null(query)]

    do.call(libpostal_url, c(endpoint = "parse", query))
}

#' Parse Address with Mapzen Libpostal API
#'
#' @param address Address to parse.
#' @param format_keys By default the Libpostal API returns results as a list of dictionaries, each containing a label and value key. This is because there are occasions when a given key may have multiple values, for example an address that contains a cross-street. If you would prefer to have API results returned as a simple dictionary with labels as keys and values as lists of possible strings you should set the \code{format_keys} parameter to \code{TRUE}.
#' @param api_key Your Mapzen API key. The default is to look for the value in
#' the \code{MAPZEN_KEY} environment variable.
#'
#' @examples
#' \dontrun{
#' mz_parse_addr("The Book Club 100-106 Leonard St Shoreditch London EC2A 4RH, United Kingdom")
#' }
#' @export
mz_parse_addr <- function(address, format_keys = FALSE, api_key = mz_key())
{
    url <- build_parse_addr_url(
        address = address,
        format_keys = format_keys,
        api_key = api_key
    )

    libpostal_get(url)
}
