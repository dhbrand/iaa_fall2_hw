#G561
#ARIMA modeling with subset of well data because of
#differing seasonality
### Rolling up to hourly
library(readxl)
library(readr)
library(dplyr)
#install.packages("mice")
library(mice)
library(stringr)
library(zoo)
  G561 <- read_excel("data/Well Data/G-561_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
G561$time <- substr(G561$time,12,13)
Grouped_Well <- aggregate(G561$Corrected, list(G561$date, G561$time), mean)
colnames(Grouped_Well) <- c('Date', 'Hour', 'Corrected_Mean')
hwell <-  Grouped_Well[order(Grouped_Well$Date,Grouped_Well$Hour),]
rownames(hwell) <- NULL

### Checking for missing values
timeset <- seq(ISOdate(2007,10,5,0), ISOdate(2018,6,12,23), "hours")
time_df = as.data.frame(timeset)
nrow(time_df) - nrow(hwell)
# 254 missing values

#fix type of Date
hwell$Date = as.character(hwell$Date)
#change column names
colnames(hwell) <- c('Date', 'time', 'Corrected_Mean')

#Prepare to dfs for merging to explore missing values
time_df$time <- substr(time_df$time,12,13)
time_df$Date = substr(time_df$timeset,1,10)
hwell$Date1 = paste(hwell$Date, '-', hwell$time, sep='')
time_df$Date1 = paste(time_df$Date, '-', time_df$time, sep='')
df_merged<-merge(time_df,hwell,by="Date1", all.x = TRUE)
summary(df_merged)
na_index = which(is.na(df_merged$Corrected_Mean))
df_merged[na_index,] #dates at which we have missing values

#impute with zoo forward fill
df_merged1 = df_merged[c(2,7)] #narrow down to the two columns im interested in
impwell = na.locf(df_merged1, na.rm = TRUE)

# Create training and validation data sets and time-series objects
wellsub <- impwell[75889:93696,]
tswell <- ts(wellsub$Corrected_Mean, start=c(2016,6), frequency =8760)

# STL decomposition of training set
decomp_stl <- stl(tswell, s.window = 7)
plot(decomp_stl)

#export impwell as csv for continued analysis in SAS
write_csv(wellsub, path =  "data/impwell.csv")
getwd()








