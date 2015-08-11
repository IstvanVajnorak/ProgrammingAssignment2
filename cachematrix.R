## Put comments here that give an overall description of what your
## functions do

## Creates a matrix based on the makeVector implementation that 
## wraps a caching functionality around any ordinary matrix instace
## created in R.
makeCacheMatrix <- function(x = matrix()) {

  ## the holder for the inverse, which gets flushed when the actual matrix is reset
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  ## defining a get function that exposes the scoped x variable
  get <- function() x
  ## the setinverse function simply puts the input into the m variable
  setinverse <- function(inverse) m <<- inverse
  ## getinverse simply exposes the m variable's content
  getinverse <- function() m
  ## exposing the functions on the matrix so we can access them via the names
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## Based on the cachemean function, this function makes sure that
## if the matrix passed in has its inverse already calculated,
## then it won't run the computation again, but rather takes already
## existing results to speed up the workflow. 

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  m <- x$getinverse()
  ## we have an inverse cached already, so lets return that instead of computing it
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  ## calling the actual matrix inversion function from R
  m <- solve(data, ...)
  ## caching the data, so we won't have to compute it again
  x$setinverse(m)
  ##passing back the calculated result
  m
}
