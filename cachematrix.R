## COURSERA WEEK 3 ASSIGNMENT: Lexical Scoping



#The first function, makeCacheMatrix creates a special "vector", which is really a list containing a function to
#1.set the value of the matrix
#2.get the value of the matrix
#3.set the value of the inverse matrix
#4.get the value of the inverse matrix

makeCacheMatrix <- function(x = matrix()) {
        
        inv <- NULL
        set <- function(y) {
                x <<- y
                inv <<- NULL
        }
        get <- function() x
        setinv <- function(inverse) inv <<- inverse
        getinv <- function() inv
        
        #vector that will be used in CacheSolve
        list(set = set, get = get,
             setinv = setinv,
             getinv = getinv)
}


#The second function checks if the inversematrix has already been calculated.
#Gets the inverse from the cache or calculates inverse and sets it in the cache via setinv function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        inv <- x$getinv()
        if(!is.null(inv)) {
                message("getting cached data")
                return(inv)
        }
        data <- x$get()
        inv <- solve(data, ...)
        x$setinv(inv)
        inv
}