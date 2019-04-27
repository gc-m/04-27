# 참고한 사이트들
# https://rfriend.tistory.com/118
# https://acpi.tistory.com/30
# http://blog.naver.com/PostView.nhn?blogId=yys2818&logNo=221039532263&categoryNo=0&parentCategoryNo=0
# https://m.blog.naver.com/PostView.nhn?blogId=jjy0501&logNo=221016092102&proxyReferer=https%3A%2F%2Fwww.google.com%2F
# https://blog.pabii.co/data-science-students-questions/
m(list = ls())
options(scipen = 100)


# Import Packages ---------------------------------------------------------
if (!require(ggplot2)) {install.packages("ggplot2")}; require(ggplot2)
if (!require(UsingR)) {install.packages("UsingR")}; require(UsingR)
if (!require(psych)) {install.packages("psych")}; require(psych)
if (!require(outliers)) {install.packages("outliers")}; require(outliers)
data("diamonds")

diamonds # 53940 x 10

str(diamonds)

# R로하는 정규성 검정

#[정규성 여부 검정]

#- 단일 모집단 분포의 정규성 검정

#: shapiro.test(), qqnorm(), qqline()

#(1) shapiro.test() 함수를 이용한 Shapiro-Wilk 검정, 
#(2) Histogram, Kernel Density Plot 그래프를 이용한 정규성 확인, 
#(3) Q-Q plot 그래프를 이용한 정규성 확인 (qqnorm(), qqline() 함수)를 사용해 예를 들어보겠습니다


shapiro.test(diamonds$carat)
# 샘플의 크기는 반드시 3부터 5000이내 
str(cfb)
shapiro.test(cfb$INCOME)
hist(cfb$INCOME,breaks=100)
hist(diamonds$price,breaks=100)
hist(diamonds$carat,breaks=100)
hist(diamonds$depth,breaks=100)
# 아래의 Kernel Density Plot에서는 Y축이 Frequency가 아니라 Probability 임에 유의하시기 바랍니다. (hist(freq=FALSE)) 옵션 사용)
hist(cfb$INCOME, freq=FALSE, breaks=100, main="Kernel Density Plot of cfb$INCOME")
lines(density(cfb$INCOME), col="blue", lwd=3)

hist(diamonds$price, freq=FALSE, breaks=100, main="Kernel Density Plot of price")
lines(density(diamonds$price), col="blue", lwd=3)

qqnorm(diamonds$price)
qqline(diamonds$price)

library(nortest)
ad.test(diamonds$price)
cvm.test(diamonds$price)
ks.test(diamonds$price,'pnorm',mean=mean(diamonds$price),sd=sd(diamonds$price))
lillie.test(diamonds$price)
pearson.test(diamonds$price)
sf.test(diamonds$price)

ad.test(diamonds$depth)
cvm.test(diamonds$depth)
ks.test(diamonds$depth,'pnorm',mean=mean(diamonds$depth),sd=sd(diamonds$depth))
lillie.test(diamonds$depth)
pearson.test(diamonds$depth)
sf.test(diamonds$depth)

# 왜도 첨도를 이용

skew(diamonds$price)
kurtosi(diamonds$price)
skew(cfb$INCOME)
kurtosi(cfb$INCOME)

mardia(cfb$INCOME)
# 큰 데이터의 경우 사용 불가능!! 
# 근데 데이터가 큰 경우에는 CLT에 근거하여 정규성 검정을 할 필요가 없어짐

# 참고한 사이트들
# https://www.rdocumentation.org/packages/outliers/versions/0.14/topics/grubbs.test
# http://prefity.blogspot.com/2016/09/sosal-r-3.html
 
# R로하는 Grubb's test (이상치 검정)
# grubbs.test(x, type = 10, opposite = FALSE, two.sided = FALSE)

hist(diamonds$depth)
boxplot(diamonds$depth,horizontal = T)
grubbs.test(diamonds$depth)
grubbs.test(diamonds$depth,opposite = T)
grubbs.test(diamonds$depth,type = 11)
grubbs.test(diamonds$depth,type = 10)


