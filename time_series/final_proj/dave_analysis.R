library(tidyverse)
library(forecast)
library(MLmetrics)
library(TSA)

###################################

well <- read_csv("data/g561_final.csv")

# building a small dataset to try and find a highly accuracte model
train <- well %>% 
  slice( ( (n() - 149) - 2*8766 ) : (n() - 149) )
test <- well %>% 
  slice( ( n() - 148)  : n() )

# using quarterly season
train_ts <- msts(train$well, c(2193, 8766))
train_ts %>% 
  mstl() %>% 
  autoplot()

# step one just trying full auto arima
mod1 <- auto.arima(train_ts, trace = TRUE)
summary(mod1) # ARIMA(1,1,5)

checkresiduals(mod1)

fcast <- forecast(mod1, h = 149)

MAPE(fcast$mean, test$well) # 0.09871133


# step two add xreg components
xreg <- select(train, tide, rain)
mod2 <- auto.arima(train_ts, trace = TRUE, xreg = xreg)
summary(mod2) # Regression with ARIMA(5,1,3)

checkresiduals(mod2)

fcast <- forecast(mod2, xreg = select(test, tide, rain))

MAPE(fcast$mean, test$well) # 0.1044572 worse


# step three check seasonal adf
nsdiffs(train_ts) # 0 

# so we fit dummy variables
xreg <- fourier(train_ts, K = c(8, 2))
mod3 <- auto.arima(train_ts, trace = TRUE, xreg = xreg, seasonal = FALSE)
mod3 <- Arima(train_ts, order = c(4,1,2), xreg = xreg, method = 'ML')
summary(mod3) # Regression with ARIMA(4,1,2)

checkresiduals(mod3)
test_ts <- msts(test$well, c(2193, 8766))
xreg <- fourier(test_ts, K = c(10,10))
fcast <- forecast(mod3, xreg = xreg)
MAPE(fcast$mean, test$well) # 0.4000634 horrible

# running a half season difference
train_diff <- diff(train_ts, 4383)

mod4 <- auto.arima(train_diff, trace = TRUE)
summary(mod4) # ARIMA(3,1,3) with drift

checkresiduals(mod4)

fcast <- forecast(mod4, h = 149)

MAPE(fcast$mean, test$well) # 1.031442 evidently that doesnt work

# Point (Pulse) Intervention - Deterministic #

autoplot(train_ts)
train[which.max(train$well),]
which(train$date == "2017-09-11 03:00:00") # index 11085

loop <- seq(1:nrow(train))
spike <- rep(0, nrow(train))
for(i in 1:length(spike)){
  if(loop[i] == 11085){
    spike[i] <- 1
  } else {
    spike[i] <- 0
  }
}

mod5 <- auto.arima(train_ts, xreg = spike, trace = TRUE)
summary(mod5) # ARIMA(4,1,2)

checkresiduals(mod5)

fcast <- forecast(mod5, xreg = rep(0, 149))

MAPE(fcast$mean, test$well) # 0.102967 evidently that doesnt work


# going to add a rain lag var
rain6 <- c(rep(0,6), diff(train$rain, 6))

xreg <- cbind(select(train, tide, rain), rain6)
mod6 <- auto.arima(train_ts, trace = TRUE, xreg = xreg)
summary(mod6) # Regression with ARIMA(3,1,2)

checkresiduals(mod6)
rain6 <- c(rep(0,6), diff(test$rain, 6))
fcast <- forecast(mod6, xreg = cbind(select(test, tide, rain), rain6))

MAPE(fcast$mean, test$well) # 0.09765766 better than without

# going to keep rain lag and add tide lag
rain6 <- c(rep(0,6), diff(train$rain, 6))
tide3<- c(rep(0,3), diff(train$tide, 3))
tide6 <- c(rep(0,6), diff(train$tide, 6))

xreg <- cbind(select(train, tide, rain), rain6, tide3, tide6)
mod7 <- auto.arima(train_ts, trace = TRUE, xreg = xreg)
summary(mod7) # Regression with ARIMA(5,1,3) 

checkresiduals(mod7)
rain6 <- c(rep(0,6), diff(test$rain, 6))
tide3<- c(rep(0,3), diff(test$tide, 3))
tide6 <- c(rep(0,6), diff(test$tide, 6))
fcast <- forecast(mod7, xreg = cbind(select(test, tide, rain), rain6, tide3, tide6))

MAPE(fcast$mean, test$well) # 0.09765766 better than without


# tbats

mod8 <- tbats(train_ts)
mod8
fcast <- forecast(mod8, h = 149)

MAPE(fcast$mean, test$well) 

# quarterly seasonal only

train_ts <- ts(train$well, frequency = 2193)

xreg <- fourier(train_ts, K = 10)
mod9 <- auto.arima(train_ts, trace = TRUE, xreg = xreg, seasonal = FALSE)
summary(mod9)

test_ts <- ts(test$well, frequency =2193)
xreg <- fourier(test_ts, K = 10)
fcast <- forecast(mod9, xreg = xreg)
MAPE(fcast$mean, test$well) #0.08968066  not great

