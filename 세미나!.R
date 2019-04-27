
# AdaBoost ----------------------------------------------------------------

#####adabag package#####
#http://r-bong.blogspot.com/2016/10/adabag.html
#https://cran.r-project.org/web/packages/adabag/adabag.pdf
#분류와 회귀트리를 가지는 AdaBoost.M1, SAMME.R, bagging 구현
#rpart package를 사용하는 기본 분류기

install.packages('adabag')
library(adabag)
data("iris")
train <- c(sample(1:50, 25), sample(51:100, 25), sample(101:150, 25))

##boosting (bagging은 bagging함수 쓰면 됨)
iris.adaboost <- boosting(Species ~ ., data = iris[train,], mfinal = 10, control = rpart.control(maxdepth = 1))

iris.adaboost$importance #중요변수 확인
importanceplot(iris.adaboost)

table(iris.adaboost$class, iris$Species[train], dnn = c('predicted','observed')) #confusion matrix

1-sum(iris.adaboost$class == iris$Species[train]) / length(iris$Species[train]) #error

#predict
iris.pred <- predict.boosting(iris.adaboost, newdata = iris[-train,])
iris.pred$confusion
iris.pred$error

#cv
iris.cv <- boosting.cv(Species ~ ., v = 10, data = iris[train,], mfinal = 10, control = rpart.control(maxdepth = 1))

###bagging
iris.bagging <- bagging(Species ~ ., data = iris[train,], mfinal = 10, control = rpart.control(maxdepth = 1))

##margin
#object : bagging, boosting, predict.bagging, predict.boosting
#newdata : 객체생성하기 위해 사용된 데이터프레임

iris.boosting.margin <- margins(iris.adaboost, iris[train,])
iris.boosting.predmargin <- margins(iris.pred, iris[-train,])
plot.margins(iris.boosting.margin)
plot.margins(iris.boosting.predmargin)
plot.margins(iris.boosting.margin, iris.boosting.predmargin)


##error evolution
#object : bagging, boosting
error.boosting <- errorevol(iris.adaboost, newdata = iris[train,])
error.bagging <- errorevol(iris.bagging, newdata = iris[train,])
plot.errorevol(error.boosting)
plot.errorevol(error.bagging)
plot.errorevol(error.bagging, error.boosting)





# GBM ---------------------------------------------------------------------

##### gbm package
# https://cran.r-project.org/web/packages/gbm/gbm.pdf
# https://datascienceplus.com/gradient-boosting-in-r/

install.packages('gbm')
require(gbm)

iris.gbm <- gbm(Species ~ ., data = iris[train,], distribution = 'gaussian', n.trees = 10, interaction.depth = 1) 
summary(iris.gbm) #variable importance plot 제공

gbm.pred <- predict.gbm(iris.gbm, newdata = iris[train,], n.trees = 10)


# XGBoost -----------------------------------------------------------------

#모든 변수는 numeric, 결과값은 확률로 측정
#명목형 변수의 경우 one hot encoding(관찰값이 0,1만 존재)
#factor 변수의 경우 one hot encoding 무조건 수행
#parameter 설명 : https://blog.naver.com/PostView.nhn?blogId=tjdudwo93&logNo=221071886633&proxyReferer=https%3A%2F%2Fwww.google.com%2F
#http://freesearch.pe.kr/archives/4405
install.packages("xgboost"); require(xgboost)


# LightGBM ----------------------------------------------------------------

#설치방법 까다로움 : https://bluediary8.tistory.com/25
#CMake, git, Rtools, Visual Studio 설치 필수


# CatBoost ----------------------------------------------------------------
#설치방법 : https://github.com/2econsulting/2econsulting.github.io/blob/master/_posts_w_code/CatBoost%20in%20R.ipynb
#caret package : method=catboost.caret (catboost package)
devtools::install_url("https://github.com/catboost/catboost/releases/download/v0.8.1/catboost-R-Windows-0.8.1.tgz")
library(catboost)
library(caret)
install.packages("titanic");library(titanic)

# load data
data <- as.data.frame(as.matrix(titanic::titanic_train), stringsAsFactors=TRUE)

# handle missing value
age_levels <- levels(data$Age)
most_frequent_age <- which.max(table(data$Age))
data$Age[is.na(data$Age)] <- age_levels[most_frequent_age]

# set x and y 
drop_columns = c("PassengerId", "Survived", "Name", "Ticket", "Cabin")
x <- data[,!(names(data) %in% drop_columns)]
y <- data[,c("Survived")]

# use caret for grid search 
fit_control <- caret::trainControl(
    method = "cv", 
    number = 3, 
    search = "random",
    classProbs = TRUE
)

# set grid options
grid <- expand.grid(
    depth = c(4, 6, 8),
    learning_rate = 0.1,
    l2_leaf_reg = 0.1,
    rsm = 0.95,
    border_count = 64,
    iterations = 10
)

# train catboost
model <- caret::train(
    x = x, 
    y = as.factor(make.names(y)),
    method = catboost.caret,
    metric = "Accuracy",
    maximize = TRUE,
    preProc = NULL,
    tuneGrid = grid, 
    tuneLength = 30, 
    trControl = fit_control
)
print(model)

# variable importance
importance <- varImp(model, scale = FALSE)
print(importance)
