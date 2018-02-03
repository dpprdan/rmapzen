#' @import assertthat
build_normalize_addr_url <- function(
    address, api_key = mz_key())
{
    assert_that(is.string(address))

    query <- list()

    query <- c(
        query,
        address = address,
        api_key = api_key
    )
    query <- query[!is.null(query)]

    do.call(libpostal_url, c(endpoint = "expand", query))
}

#' Normalize Address with Mapzen Libpostal API
#'
#' @param address Address to normalize
#' @param api_key Your Mapzen API key. The default is to look for the value in
#' the MAPZEN_KEY environment variable.
#'
#' @examples
#' \dontrun{
#' mz_normalize_addr("Quatre-vingt-douze Ave des Champs-\u00c9lys\u00e9es")
#' }
#'
#' @export
mz_normalize_addr <- function(address, api_key = mz_key())
{
    url <- build_normalize_addr_url(
        address = address,
        api_key = api_key
    )

    libpostal_get(url)
}


#' @rdname mz_normalize_addr
#' @export
mz_normalise_addr <- mz_normalize_addr
