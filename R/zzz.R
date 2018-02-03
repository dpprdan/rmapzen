.onAttach <- function(libname, pkgname) {
    options(RMAPZEN.search.host="search.mapzen.com")
    options(RMAPZEN.libpostal.host="libpostal.mapzen.com")
}
