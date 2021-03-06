## EFFICIENTLY CALCULATING THE INVERSE OF A MATRIX
## Uses caching method to avoid recalculating a previously calculated inverse.
## Program assumes the input matrix is invertable.

## Use makeCacheMatrix to cache the inverse.
## It returns a list of functions with cached values that are used to:
## 	set        - caches matrix in secondary environment
## 	get        - recall matrix from the secondary environment
## 	setInverse - produce an inverse to be cached
## 	getInverse - fetch a previously cached inverse
## USAGE: cacheList<- makeCacheMatrix(invertableMatrix)

## Use cacheSolve to return either the cached inverse or a newly generated inverse.
## 	If a new inverse is generated, it is also cached.
## USAGE: Inverse<-cacheSolve(cacheList)

## They may also be used in one line: 
## USAGE:	Inverse<-cacheSolve(makeCacheMatrix(invertableMatrix))

makeCacheMatrix <- function(x = matrix()) {
## Caches the matrix being used.
## Provides the means to record and recall the matrix and its inverse.
## Input: a square matrix

            m <- NULL
            set <- function(y) {
                    x <<- y
                    m <<- NULL
            }
            get <- function() x
            setInverse <- function(solve) m <<- solve
            getInverse <- function() m
            list(set = set, get = get,
                 setInverse = setInverse,
                 getInverse = getInverse)
    }





cacheSolve <- function(x, ...) {
## Checks for previously calculated inverse and recalls it if present.
## Otherwise caches the newly submitted matrix and its inverse.
## Input: List generated by the makeCacheMatrix function.
## Return a matrix that is the inverse of 'x'

             m <- x$getInverse()
            if(!is.null(m)) {
                    message("getting cached data")
                    return(m)
            }
            data <- x$get()
            m <- solve(data, ...)
            x$setInverse(m)
            m
    }

# EXAMPLE:
# > m1
#      [,1] [,2] [,3]
# [1,]    1    8   13
# [2,]    2    3   24
# [3,]    3    5    6
# > cacheSolve(makeCacheMatrix(m1))
#              [,1]        [,2]        [,3]
# [1,] -0.260869565  0.04347826  0.39130435
# [2,]  0.153452685 -0.08439898  0.00511509
# [3,]  0.002557545  0.04859335 -0.03324808
# > m1%*%cacheSolve(makeCacheMatrix(m1))
#              [,1]         [,2]         [,3]
# [1,] 1.000000e+00 1.110223e-16 5.551115e-17
# [2,] 0.000000e+00 1.000000e+00 1.110223e-16
# [3,] 5.551115e-17 0.000000e+00 1.000000e+00
# 
# > m1%*%m1%*%cacheSolve(makeCacheMatrix(m1))
#      [,1] [,2] [,3]
# [1,]    1    8   13
# [2,]    2    3   24
# [3,]    3    5    6
