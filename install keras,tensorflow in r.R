## �ʿ伳ġ����
# #R update
# install.packages('installr')
# require(installr)
# updateR()
#RTools ��ġ(3.4 ver/ Frozen version)
https://cran.r-project.org/bin/windows/Rtools/
#anaconda
https://www.anaconda.com/distribution/

# install keras in r ------------------------------------------------------
#https://lovetoken.github.io/r/machinelearning/keras/2018/06/02/keras_tutorial.html

install.packages('devtools')
devtools::install_github("rstudio/keras")

#�Ƴ��ܴ� 3.7 ��ġ �� 3.6���� ����
#�Ƴ��ܴ� �ֽ� ������ Python�� 3.7�� default�̰� Tensorflow�� Python 3.7�� �������� �����Ƿ� �ֽ� ������ ��ġ�ϸ� Python 3.6�� �������� �ٽ� ��ġ�ؾ���
#Python 3.6 ��ġ��  Anaconda ���� ������Ʈ���� conda install python=3.6 �������� ��ġ (�����ɸ�)


install.packages('keras')
library(keras)
install_keras() #Keras, Tensorflow ��ġ (GPU �ƴѰ��)

#�� ��ġ�Ǿ��� Ȯ��
mnist <- dataset_mnist()
model <- keras_model_sequential()


# install tensorflow in r -------------------------------------------------
#https://hiseon.me/2018/08/02/r-tensorflow-install/

devtools::install_github("rstudio/tensorflow")
install.packages("tensorflow")
library(tensorflow)
install_tensorflow()
#install_tensorflow(version = 'gpu') #gpu �����ϴ� �ټ��÷ο� ��ġ
#install_tensorflow(version = '1.13.0') #Ư������ ��ġ
#install_tensorflow(version = 'nightly') #���߹���-cpu
#install_tensorflow(version = 'nightly-gpu') #���߹���-gpu

#����
sess <- tf$Session()

hello <- tf$constant('Hello, TensorFlow!')
sess$run(hello)
