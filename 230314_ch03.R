C = D <- 5
C
D

A <- B = 3
A
B
x <- 1:3
y <- 3:1

(x>0)&(y>1)
(x>0)|(y>1)


a <- 9
if(a%%2==0){
  print("짝수")
}else{
  print("홀수")
}

# 몫, 나머지 연산자
20%/%7
20%%7

b <- 80
if (b >= 90){
  print("A학점입니다")
} else if (b >= 80) {
  print("B학점입니다")
} else {
  print("C 학점입니다")
}

x <- 1
for(i in 1:5){
  x <- x+2
}
x

x <- 1
i <- 0
while(i < 10){
  x <- x + 2
  i <- i + 1
}

x

x <- 1
i <- 0
repeat{
  x <- x+2
  print(paste(i, x))
  if(i >= 9)break
  i <- i + 1
}

x

for (i in 1:9){
  a <- 2*i
  print(a)
}

for (i in 2:9){
  for(j in 1:9){
    print(paste(i, "*", j, "=",i*j))
  }
}

x <- matrix(1:4,2,2)
x
apply(x,1,sum)
apply(x,2,min)
apply(x,1,max)

force(iris)
View(iris)

apply(iris[,1:4], 2, sum)
apply(iris[,1:4], 2, mean)
apply(iris[,1:4], 2, min)
apply(iris[,1:4], 2, max)
apply(iris[,1:4], 2, median)

apply(iris[,1:4], 2, sum)
lapply(iris[,1:4], sum)
sapply(iris[,1:4], sum)

summary()