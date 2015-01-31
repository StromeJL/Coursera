###R Programming

## Data Types - R Objects and Attributes

# Objects

Five basic classes:
  
  Character

  Numeric

  Integer

  Complex

  Logical

Most basic object: Vector

  Most vectors can only contain objects of the same class

  One exception is a "list"

  Can create empty vectors with vector()

# Numbers

  Generally treated as numeric objects

  Can specify integer with L suffix

  Inf represents infinity

  NaN represents an undefined value

# Attributes

Objects can have attributes

  names, dimnames

  dimensions

  class

  length

  other user-defined attributes/metadata

Can be accessed using attributes() function

## Vectors and Lists

# Creating vectors

# Can use c() to create vectors of objects

 x <- c(0.5, 0.6) ## numeric
 x <- c(TRUE, FALSE) ## logical
 x <- c(T, F) ## logical
 x <- c("a", "b", "c") ## character
 x <- 9:29 ## integer
 x <- c(1+0i, 2+4i) ## complex

#Using vector() function

x <- vector("numeric", length = 10)
x

#Mixing Objects

# R will coerce objects into different classes so that every element in vector is same class

> y <- c(1.7, "a") ## character
> y <- c(TRUE, 2) ## numeric
> y <- c("a", TRUE) ## character

# Explicit Coercion

# Can use as.* functions ie. as.numeric()

> x <- 0:6
> class(x)
> as.numeric(x)
> as.logical(x)
> as.character(x)

# Nonsensical coercion results in NAs.

> x <- c("a", "b", "c")
> as.numeric(x)
> as.logical(x)
> as.complex(x)

## Matrices

# Matrices are vectors with a dimension attribute. The dimension attribute is itself an integer vector of
# length 2 (nrow, ncol)

> m <- matrix(nrow = 2, ncol = 3)
> m
> dim(m)
> attributes(m)

# Matrices are constructed column-wise, so entries can be thought of starting in the "upper left" corner
# and running down the columns.

> m <- matrix(1:6, nrow = 2, ncol = 3)
> m

# Matrices can also be created directly from vectors by adding a dimension attribute.

> m <- 1:10
> m
> dim(m) <- c(2, 5)
> m

# cbind-ing and rbind-ing cbind-ing and rbind-ing

# Matrices can be created by column-binding or row-binding with cbind() and rbind().

> x <- 1:3
> y <- 10:12
> cbind(x, y)
> rbind(x, y) 

## Factors

# Factors are used to represent categorical data.
# Can be ordered or unordered.
# One can think of a factor as an integer vector where each integer has a label

#Factors are treated specially by modelling functions like lm() and glm()

# Using factors with labels is better than using integers because factors are self-describing; having
# a variable that has values "Male" and "Female" is better than a variable that has values 1 and 2.

x <- factor(c("yes", "yes", "no", "yes", "no"))
> x
> table(x)
> unclass(x)
attr(,"levels")

# The order of the levels can be set using the levels argument to factor(). This can be important
# in linear modelling because the first level is used as the baseline level.

> x <- factor(c("yes", "yes", "no", "yes", "no"),
              levels = c("yes", "no"))
> x

