## Caching the inverse of a Matrix
## Author : Peramanathan Sathyamoorthy
## template provided, filling objective

## creates a special "data" object that can cache itself
makeCacheData <- function(x) {
  d <- NULL
  # data update
  set <- function(y) {
    x <<- y
    d <<- NULL
  }
  get <- function() x
  # inverse values update
  setdata <- function(data) d <<- data
  getdata <- function() d
  list(set = set, get = get, setdata = setdata, getdata = getdata)
  # Special means it stores its inverse / cached
}

## stores the special data returned by cacheData function
cacheData <- function(x, ...) {
  ## Return the data 
  d <- x$getdata()
  if(!is.null(d)){
    message("getting cached data")
    return(d)
  }
  data <- x$get()
  d <- data
  x$setdata(d)
  d
}
