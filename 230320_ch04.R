ID <- c(1,2,3,4,5)
ID
SEX <- c("F","M","F","M","F")
SEX
DATA <- data.frame(ID = ID, SEX = SEX)
View(DATA)


varname <- c("ID","SEX","AGE","AREA")
ex_data <- read.table("./Source/data_ex.txt", 
                      encoding = 'EUC-KR', 
                      fileEncoding = 'UTF-8',
                      header = TRUE,
                      col.names = varname,
                      skip = 2,
                      nrows = 6)
View(ex_data)


varname <- c("ID","SEX","AGE","AREA")
ex_data <- read.table("./Source/data_ex1.txt", 
                      encoding = 'EUC-KR', 
                      fileEncoding = 'UTF-8',
                      header = TRUE,
                      sep = ',')


View(ex_data)

csv_data = read.csv("./Source/data_ex.csv")
View(csv_data)

# install.packages("readxl")
library(readxl)
library(Rcpp)

excel_data_ex = read_excel("./Source/data_ex.xlsx")
View(excel_data_ex)

install.packages("XML")
library(XML)

xml_data <- xmlToDataFrame("./Source/data_ex.xml")
View(xml_data)

install.packages("jsonlite")
library(jsonlite)

json_data = fromJSON("./Source/data_ex.json")
View(json_data)

data("iris")
iris

str(iris)
mode(iris)

ncol(iris)
nrow(iris)
dim(iris)
length(iris)

ls(iris)
head(iris, n=3)
tail(iris, n=3)
     
mean(iris$Sepal.Length)
median(iris$Sepal.Length)

mean(iris$Petal.Length)
median(iris$Petal.Length)

min(iris$Petal.Length)
max(iris$Petal.Length)
range(iris$Petal.Length)

quantile(iris$Sepal.Length)

quantile(iris$Petal.Length, probs = 0.25)
quantile(iris$Petal.Length, probs = 0.5)
quantile(iris$Petal.Length, probs = 0.75)
quantile(iris$Petal.Length, probs = 1)

var(iris$Petal.Length)
sd(iris$Petal.Length)

install.packages("psych")
library(psych)

kurtosi(iris$Petal.Length)
skew(iris$Petal.Length)

hist(iris$Petal.Length)

install.packages("descr")
library(descr)

freq_test <- freq(iris$Petal.Length, plot=T)
freq_test

library(readxl)
exdata1 <- read_excel("./Source/Sample1.xlsx")
exdata1

freq(exdata1$SEX, plot=T, main='성별(barplot)')

dist_sex <- table(exdata1$SEX)
dist_sex
barplot(dist_sex, ylim = c(0,14), 
        main="성별", xlab = "구분", ylab="빈도",
        names=c("Female", "Male"),
        col=c("pink","navy"))


boxplot(exdata1$Y21_CNT, exdata1$Y20_CNT,
        ylim = c(0,60),
        main = "boxplot",
        names = c("21년건수",
                  "20년건수"),
        col = c("green", "yellow"))

View(exdata1)

data <- exdata1$AGE

hist(data, col = "magenta", border = "white",
     xlab = "Value", ylab = "Frequency", main = "Histogram of Age",
     xlim = c(0, 60), ylim = c(0, 7))

data(mtcars)
x <- table(mtcars$gear)
pie(x, col=c("red", "blue", "green"))

View(mtcars)

x <- c(1,2,3,4,7,8,8,5,9,6,9)
stem(x, scale=1)

pairs(mtcars)

?mtcars

library(psych)
pairs.panels(iris)
