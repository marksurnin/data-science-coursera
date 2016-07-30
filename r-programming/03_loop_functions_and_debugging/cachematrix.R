# Matrix inversion is usually a costly computation and there may be some benefit
# to caching the inverse of a matrix rather than compute it repeatedly.

# makeCacheMatrix() creates a special matrix object,
# that can cache its inverse. It is a list containing
# a function to:

# 1.  set the value of the matrix
# 2.  get the value of the matrix
# 3.  set the value of the inverse of the matrix
# 4.  get the value of the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setInverse <- function(inverse) inv <<- inverse
  getInverse <- function() inv
  list(set = set,
       get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


# cacheSolve() computes the inverse of the special "matrix" returned
# by makeCacheMatrix above. If the inverse has already been calculated
# (and the matrix has not changed), then the cachesolve should retrieve
# the inverse from the cache.

cacheSolve <- function(x, ...) {
  ## Return a matrix that is the inverse of 'x'
  inv <- x$getInverse()
  if (!is.null(inv)) {
    message("Getting cached data...")
    inv
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setInverse(inv)
  inv
}