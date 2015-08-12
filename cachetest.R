## 
## A set of commands that shows how the caching API works, and proves that it actually speeds up 
## computations requiring the same thing over and over again. Alongside, it also shows that the
## cache gets purged when the matrix inside the holder is reset.
##
##
cachetest <- function(){

  source("cachematrix.R")
  print("-------------------------------------------------------------------------------------")
  print("1. Create a cache")
  print("-------------------------------------------------------------------------------------")  
  cachingMatrix <- makeCacheMatrix()
  print(paste("Was the the cache created successfully?",!is.null(cachingMatrix), sep = " : "))
  
  print("----------------------------------------")
  print("2. Checking if the inverse is null")
  print("----------------------------------------")
  
  matrix <- cachingMatrix$get()
  inverse <- cachingMatrix$getinverse()
  ##asserting that the inverse is null
  print(paste("Is the inverse null?",is.null(inverse), sep = " : "))
  
  
  print("-------------------------------------------------------------------------------------")
  print("3. Setting a matrix for which we are to calculate the inverse")
  print("-------------------------------------------------------------------------------------")
  
  cachingMatrix$set(rbind(c(2,3), c(7,5)))
  matrix <- cachingMatrix$get()
  inverse <- cachingMatrix$getinverse()
  print(matrix)
  print(inverse)

  print("-------------------------------------------------------------------------------------")
  print("4. Calculating the inverse and checking the result")
  print("-------------------------------------------------------------------------------------")
  
  cacheSolve(cachingMatrix)
  inverse <- cachingMatrix$getinverse()
  print(inverse)
  paste("Was the inverse calculated?",!is.null(inverse),sep=" : ")

  print("-------------------------------------------------------------------------------------")
  print("5. Calling calculate again, this time it should also print that data is from the cache")
  print("-------------------------------------------------------------------------------------")
  
  cacheSolve(cachingMatrix)
  inverse <- cachingMatrix$getinverse()
  print(inverse)
  
  print("-------------------------------------------------------------------------------------")
  print("6. Changing the input matrix in the holder and check if the inverse is correctly evicted")
  print("-------------------------------------------------------------------------------------")
  
  cachingMatrix$set(rbind(c(2,3,5), c(7,11,13)))
  inverse <- cachingMatrix$getinverse()
  paste("Was the inverse evicted?",is.null(inverse),sep=" : ")
  
}