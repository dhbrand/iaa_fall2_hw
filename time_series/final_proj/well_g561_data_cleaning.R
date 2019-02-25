library(tidyverse)
library(readxl)
library(lubridate)

# original well cleaning from hw4
well <- read_excel("data/Well Data/G-561_T.xlsx", sheet = "Well", col_types = c("date", "date", "text", "numeric", "text", "numeric"))
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
tide <- read_csv("data/Well Data/station_8722956.csv")

# filtering to same date as well data aggregated by hour
tide_agg <- tide %>%
  group_by(date = Date, hour = hour(Time)) %>%
  summarize(tide = mean(Prediction)) %>% 
  unite(date, date, hour, sep = " ") %>% 
  mutate(date = ymd_h(date, tz = "est"))

# rain data
rain <- read_excel("data/Well Data/G-561_T.xlsx", sheet = "Rain")

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

#write_csv(g561, "data/g561_final.csv")

missing <- left_join(well, tide_agg) %>% 
  left_join(., rain_agg) %>% 
  select_if(function(x) any(is.na(x))) %>% 
  summarise_all(funs(sum(is.na(.))))
  
