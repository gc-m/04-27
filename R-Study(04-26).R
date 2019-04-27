# ������ ����Ʈ��
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

# R���ϴ� ���Լ� ����

#[���Լ� ���� ����]

#- ���� ������ ������ ���Լ� ����

#: shapiro.test(), qqnorm(), qqline()

#(1) shapiro.test() �Լ��� �̿��� Shapiro-Wilk ����, 
#(2) Histogram, Kernel Density Plot �׷����� �̿��� ���Լ� Ȯ��, 
#(3) Q-Q plot �׷����� �̿��� ���Լ� Ȯ�� (qqnorm(), qqline() �Լ�)�� ����� ���� ���ڽ��ϴ�


shapiro.test(diamonds$carat)
# ������ ũ��� �ݵ�� 3���� 5000�̳� 
str(cfb)
shapiro.test(cfb$INCOME)
hist(cfb$INCOME,breaks=100)
hist(diamonds$price,breaks=100)
hist(diamonds$carat,breaks=100)
hist(diamonds$depth,breaks=100)
# �Ʒ��� Kernel Density Plot������ Y���� Frequency�� �ƴ϶� Probability �ӿ� �����Ͻñ� �ٶ��ϴ�. (hist(freq=FALSE)) �ɼ� ���)
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

# �ֵ� ÷���� �̿�

skew(diamonds$price)
kurtosi(diamonds$price)
skew(cfb$INCOME)
kurtosi(cfb$INCOME)

mardia(cfb$INCOME)
# ū �������� ��� ��� �Ұ���!! 
# �ٵ� �����Ͱ� ū ��쿡�� CLT�� �ٰ��Ͽ� ���Լ� ������ �� �ʿ䰡 ������

# ������ ����Ʈ��
# https://www.rdocumentation.org/packages/outliers/versions/0.14/topics/grubbs.test
# http://prefity.blogspot.com/2016/09/sosal-r-3.html
 
# R���ϴ� Grubb's test (�̻�ġ ����)
# grubbs.test(x, type = 10, opposite = FALSE, two.sided = FALSE)

hist(diamonds$depth)
boxplot(diamonds$depth,horizontal = T)
grubbs.test(diamonds$depth)
grubbs.test(diamonds$depth,opposite = T)
grubbs.test(diamonds$depth,type = 11)
grubbs.test(diamonds$depth,type = 10)

