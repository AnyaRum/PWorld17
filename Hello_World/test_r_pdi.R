

library("rJava")

#This does not work
a <- 1+2
a

#This will work
a <- 1+2
a.df <- as.data.frame(a)
a.df
