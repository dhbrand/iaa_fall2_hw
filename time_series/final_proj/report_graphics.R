library(haven)
library(tidyverse)
library(forecast)
library(lubridate)

fcast <- read_sas("data/forecast.sas7bdat")

str(fcast)
tail(fcast)

fc_ts <- ts(fcast$FORECAST)

timeset <- seq(ymd_h("2016-06-01 0", tz = "est"), ymd_h("2018-06-12 23", tz = "est"), "hours") %>% 
  tibble %>% 
  select(date = 1)

fcast <- bind_cols(date = timeset, fcast)
 + 
  geom_ribbon(data = fcast, aes(x = date, y = FORECAST, ymin=L95, ymax=U95), alpha=0.3)

line <- data.frame(date = as.Date("2016-06-01"))
plot_subset <- fcast %>% 
  filter(date >= "2018-05-01")
ggplot(data = plot_subset, aes(x = date, y = FORECAST)) +
  geom_line(color = "blue", size = 1.5) + 
  geom_line(aes(y= well), color = "red", size = 2) +
  geom_ribbon(aes(ymin=L95,ymax=U95), alpha=0.3, fill = "lightskyblue") +
  geom_vline(xintercept=as.POSIXct("2018-06-05 23:00:00"), color="grey40", linetype=4) +
  theme_bw() +
  scale_x_datetime(date_breaks = "1 week") +
  labs(x = "Date", y = "Well Depth (in Feet)", title = "Forecasted vs Actual Depth of Well G-561_T" ) + 
  theme(plot.title = element_text(hjust = 0.5))


# seasonal component plot

well <- read_csv("data/g561_final.csv")
well_ts <- ts(well$well, frequency = 8766, start = c(2007.10, 5))

well_stl <- stl(well_ts, s.window = 7)

seas <- as.numeric(well_stl$time.series[,1])

seas_df <- data.frame(date = date(well$date), seas = seas)
ggplot(seas_df, aes(date, seas)) +
  geom_line(color = "blue", size = 1) +
  theme_bw() +
  scale_x_date(date_breaks = "1 year") +
  labs(x = "Date", y = "Well Depth (in Feet)", title = "Seasonal Component of Well G-561_T" ) + 
  theme(plot.title = element_text(hjust = 0.5))
