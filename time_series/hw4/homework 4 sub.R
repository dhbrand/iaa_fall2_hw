#G561
#ARIMA modeling with subset of well data because of
#differing seasonality

library(readxl)
library(dplyr)
#install.packages("mice")
library(mice)
library(stringr)
library(zoo)
G561 <- read_excel("data/Well Data/G-561_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))

### Rolling up to hourly
G561$time <- substr(G561$time,12,13)#make new column, hour of day
Grouped_Well <- aggregate(G561$Corrected, list(G561$date, G561$time), mean)#aggregate by day of month, then hour of day
colnames(Grouped_Well) <- c('Date', 'Hour', 'Corrected_Mean')#rename columns
hwell <-  Grouped_Well[order(Grouped_Well$Date,Grouped_Well$Hour),]#order by date then hour
rownames(hwell) <- NULL #reset index of hwell

### Checking for missing values
timeset <- seq(ISOdate(2007,10,5,0), ISOdate(2018,6,12,23), "hours")#create sequence of dates to compare to hwell
time_df = as.data.frame(timeset)#turn sequence into dataframe for comparison
nrow(time_df) - nrow(hwell)
## 254 missing values

hwell$Date = as.character(hwell$Date)#fix type of Date
colnames(hwell) <- c('Date', 'time', 'Corrected_Mean')#change column names

#Prepare to dfs for merging to explore missing values
#seperate date from hour
time_df$time <- substr(time_df$time,12,13)
time_df$Date = substr(time_df$timeset,1,10)

#will be merging on Date1 column, so making format consistent, includes date and hour
hwell$Date1 = paste(hwell$Date, '-', hwell$time, sep='')
time_df$Date1 = paste(time_df$Date, '-', time_df$time, sep='')

df_merged<-merge(time_df,hwell,by="Date1", all.x = TRUE)#merge the two dataframes, now we can find which dates are missing
summary(df_merged)
na_index = which(is.na(df_merged$Corrected_Mean))
df_merged[na_index,] #dates at which we have missing values

#impute with zoo forward fill
df_merged1 = df_merged[c(2,7)] #narrow down to the two columns im interested in
impwell = na.locf(df_merged1, na.rm = TRUE)#impute missing values with forward fill

#create time series object
tswell <- ts(impwell$Corrected_Mean, start=c(2007,10), frequency =8766)#seasonality of 8766

# STL decomposition
decomp_stl <- stl(tswell, s.window = 7)
plot(decomp_stl)
#notice how seasonality changes over time

#choose subset with consistent seasonality
wellsub <- impwell[75889:93696,]#2016-2018
tswell <- ts(wellsub$Corrected_Mean, start=c(2016,6), frequency =8766)
#should try other subsets (larger ones perhaps), maybe different seasonalities too
#trying frequency of 2160(quarterly is interesting with this subset)

# STL decomposition of our subset
decomp_stl <- stl(tswell, s.window = 7)
plot(decomp_stl)

#export impwell as csv for continued analysis in SAS
write.csv(wellsub, file = "impwell.csv")
getwd()

### GENERATE CSV FOR ENTIRE DATASET'S SEASONALITY, EXPORT AS CSV TO EXCEL FOR FORMATTING
tswell1 <- ts(impwell$Corrected_Mean, start=c(2007,10), frequency =8766)#seasonality of 8766
decomp_stl1 <- stl(tswell1, s.window = 7)
plot(decomp_stl1)
dc1 = decomp_stl1$time.series
dc2 = dc1[,'seasonal']
dc2 = as.data.frame(dc2)
dc2$Date = substr(impwell$timeset,1,10)
write.csv(dc2, file = "whole_season.csv")
###




