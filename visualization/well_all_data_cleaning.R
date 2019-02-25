library(tidyverse)
library(lubridate)

#### ---------------------------------WELL G561_T ----------------------------------######
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-561_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)
### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-05 0", tz = "est"), ymd_h("2018-06-12 23", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722956.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-561_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g561 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g561$Well <- "G561"

write_csv(g561, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g561_final.csv")

### -------------------------------- WELL G580A (2) ------------------------------------###
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-580A.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 0", tz = "est"), ymd_h("2018-04-09 11", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-580A.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-580A.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g580A <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g580A$Well <- "G580A"

write_csv(g580A, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g580A_final.csv")
summary(g580A)

### -------------------------------- WELL F-319 (3) ------------------------------------###
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-319.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-04-09 12", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-319.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-319.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
f319 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

f319$Well <- "F319"

write_csv(f319, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/f319_final.csv")
summary(f319)


### ---------------------------------- WELL F45 ------------------------- ###
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-45.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-03-26 10", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-45.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-45.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
f45 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

f45$Well <- "F45"

write_csv(f45, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/f45_final.csv")
summary(f45)

#### ---------------------------------------- WELL F-179 -----------------------------####

# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-179.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-06-04 11", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-179.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/F-179.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
f179 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

f179$Well <- "F179"

write_csv(f179, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/f179_final.csv")
summary(f179)

#### ---------------------------------------- WELL G-852** -----------------------------####

# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-852.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(Date), hour = hour(Time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-04-09 14", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8723080/station_8723080.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-852.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g852 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g852$Well <- "G852"

write_csv(g852, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g852_final.csv")
summary(g852)


#### ---------------------------------------- WELL G-860 -----------------------------####

# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-860.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-06-04 12", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-860.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-860.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g860 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g860$Well <- "G860"

write_csv(g860, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g860_final.csv")
summary(g860)

#### ---------------------------------------- WELL G-3549 -----------------------------####

# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-3549.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-06-12 23", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-3549.xlsx", sheet = "Tide")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Tide_ft)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-3549.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g3549 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g3549$Well <- "G3549"

write_csv(g3549, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g3549_final.csv")
summary(g3549)

#### ---------------------------------WELL G-2147_T ----------------------------------######
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-2147_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-10 0", tz = "est"), ymd_h("2018-06-08 09", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722859.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-2147_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g2147 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g2147$Well <- "G2147"

write_csv(g2147, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g2147_final.csv")
summary(g2147)

#### ----------------------------------WELL G-1260_T ------------------------------------####
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-1260_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-06-08 12", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722802.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-1260_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g1260 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g1260$Well <- "G1260"

write_csv(g1260, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g1260_final.csv")

#### ----------------------------------WELL G-2866_T ------------------------------------####
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-2866_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-06-08 09", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722859.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-2866_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g2866 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))
g2866$Well <- "G2866"

write_csv(g2866, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g2866_final.csv")
summary(g2866)

#### ----------------------------------WELL G-1220_T ------------------------------------####
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-1220_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-04-21 21", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722956.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/G-1220_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
g1220 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

g1220$Well <- "G1220"

write_csv(g1220, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/g1220_final.csv")
summary(g1220)


#### ----------------------------------WELL PB-1680_T ------------------------------------####
# original well cleaning from hw4
well <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/PB-1680_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
str(well)

### Rolling up to hourly
well_agg <- well %>% 
  group_by(date = date(date), hour = hour(time)) %>% 
  summarize(well = mean(Corrected)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))


# create sequence of dates to compare to well_agg
timeset <- seq(ymd_h("2007-10-01 1", tz = "est"), ymd_h("2018-02-08 09", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

# checking for missing
nrow(timeset) - nrow(well_agg)
length(which(is.na(left_join(timeset, well_agg))))

# join on date
well <- left_join(timeset, well_agg)


# working with tide data
tide <- read_csv("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/station_8722802.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  #unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/PB-1680_T.xlsx", sheet = "Rain")

rain_agg <- rain %>% 
  group_by(date = date(Date), hour = hour(Date)) %>% 
  summarize(rain = sum(RAIN_FT)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# bringing all 3 dataframes together and fill missing values
pb1680 <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  zoo::na.locf(.) %>%
  mutate(year=year(date),
         month=month(date))

pb1680$Well <- "PB1680"

write_csv(pb1680, "C:/Users/Greg/Desktop/Greg/IAA/AA 502/Visualization/Well_Data/Well Data/pb1680_final.csv")


#### ------------------------------------- Concatenate Data Sets ------------------------------------------####

well_merge <- rbind(f179, f319, f45, g1260, g2147, g2866, g3549, g561, g580A, pb1680, g1220, g852)
well_merge <- well_merge %>%
  separate(date, c("date", "hour"), sep=" ")
write_csv(well_merge, "C:/Users/Greg/Documents/GitHub/fall_2_orange_hw/visualization/Aggregated Well Data/well_merge.csv")

