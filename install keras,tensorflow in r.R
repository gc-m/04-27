## 필요설치사항
# #R update
# install.packages('installr')
# require(installr)
# updateR()
#RTools 설치(3.4 ver/ Frozen version)
https://cran.r-project.org/bin/windows/Rtools/
#anaconda
https://www.anaconda.com/distribution/

# install keras in r ------------------------------------------------------
#https://lovetoken.github.io/r/machinelearning/keras/2018/06/02/keras_tutorial.html

install.packages('devtools')
devtools::install_github("rstudio/keras")

#아나콘다 3.7 설치 후 3.6으로 변경
#아나콘다 최신 버전의 Python은 3.7이 default이고 Tensorflow가 Python 3.7을 지원하지 않으므로 최신 버전을 설치하면 Python 3.6을 기준으로 다시 설치해야함
#Python 3.6 설치는  Anaconda 명령 프롬프트에서 conda install python=3.6 명령으로 설치 (오래걸림)


install.packages('keras')
library(keras)
install_keras() #Keras, Tensorflow 설치 (GPU 아닌경우)

#잘 설치되었나 확인
mnist <- dataset_mnist()
model <- keras_model_sequential()


# install tensorflow in r -------------------------------------------------
#https://hiseon.me/2018/08/02/r-tensorflow-install/

devtools::install_github("rstudio/tensorflow")
install.packages("tensorflow")
library(tensorflow)
install_tensorflow()
#install_tensorflow(version = 'gpu') #gpu 지원하는 텐서플로우 설치
#install_tensorflow(version = '1.13.0') #특정버전 설치
#install_tensorflow(version = 'nightly') #개발버전-cpu
#install_tensorflow(version = 'nightly-gpu') #개발버전-gpu

#예제
sess <- tf$Session()

hello <- tf$constant('Hello, TensorFlow!')
sess$run(hello)

