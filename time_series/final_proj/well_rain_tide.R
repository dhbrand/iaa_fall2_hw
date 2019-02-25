G561_T=read.csv("G-561_T.csv",header=TRUE)
G561_rain=read.csv("G-561_T_rain.csv",header=TRUE)
G561_tide=read.csv("G-561_T_tide.csv",header=TRUE)

#G561 works
G561_T$startdate=strptime(G561_T$date, "%m/%d/%y")
G561_T$starttime=strptime(G561_T$time, "%H:%M")
G561_T$starttime = format(G561_T$starttime, "%H:%M:%S")
G561_T$datetime=paste(G561_T$startdate,G561_T$starttime,G561_T$tz_cd)
G561=aggregate(G561_T["Corrected"], list(date=cut(as.POSIXct(G561_T$datetime), "hour")), mean)

G561_rain$startdate=strptime(G561_rain$Date, "%m/%d/%y")
G561_rain$starttime=strptime(G561_rain$Date, "%m/%d/%y %H:%M") 
G561_rain$starttime = format(G561_rain$starttime, "%H:%M:%S")
G561_rain$datetime=paste(G561_rain$startdate,G561_rain$starttime)
G561_rain$datetime = as.POSIXct(G561_rain$datetime,tz = "EST")
G561_rain=aggregate(G561_rain["RAIN_FT"], list(date=cut((G561_rain$datetime), "hour")), sum)

G561_tide$date=strptime(G561_tide$Date, "%m/%d/%y") #Creates R formatted date column
G561_tide$time=strptime(G561_tide$Time, "%H:%M") #Creates R formatted time column (with today's date)
G561_tide$starttime = format(G561_tide$time, "%H:%M:%S") #Removes today's date from the times!
G561_tide$datetime=paste(G561_tide$date,G561_tide$starttime) #Combines the new R formatted date and time into one column
G561_tide$datetime = as.POSIXct(G561_tide$datetime,tz = "EST")
G561_tide=aggregate(G561_tide["Prediction"], list(date=cut((G561_tide$datetime), "hour")),mean)

G561=merge(G561,G561_rain,by="date",all=T)
G561=merge(G561,G561_tide,by="date",all=T)
G561$well=rep('G561',nrow(G561)) # make new column 

G561 = na.locf(G561, na.rm = TRUE)#impute missing values with forward fill
wellsub <- G561[75889:93696,]#2016-2018

write.csv(wellsub,file='well_tide_rain_sub.csv')