library(datasets)
data(iris)

?iris

virginica <- which(iris[, "Species"] == "virginica")

head(virginica)
virginica
mean(iris[101:150, "Sepal.Length"])

colMeans(iris)

apply(iris[, 1:4],2,mean)

rowMeans(iris[, 1:4])

apply(iris, 2, mean)

?apply

data(mtcars)
?mtcars

?tapply
?sapply
?split
?mean

tapply(mtcars$cyl, mtcars$mpg, mean)
sapply(split(mtcars$mpg, mtcars$cyl), mean)
split(mtcars, mtcars$cyl)
mean(mtcars$mpg, mtcars$cyl)

debug(ls)
ls()
?debug
stop()

stop(debug)

with(mtcars, tapply(mpg, cyl, mean))
cyl_mpg <- with(mtcars, tapply(mpg, cyl, mean))
head(cyl_mpg)
cyl_mpg
cyl_mpg[2, 1] - cyl_mpg[2, 3]

head(mtcars)
with(mtcars, tapply(hp, cyl, mean))
209.21429 - 82.63636
