# https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html

# NOTE: Code assumes it is executed from the "scripts" directory.
# NOTE: You may need to run setwd() to set the working directory to the "scripts" directory.

# kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings <- scan("../input/kings.dat",skip=3)
# Read 42 items
kings
# [1] 60 43 67 50 56 42 50 65 68 43 65 34 47 34 49 41 13 35 53 56 16 43 69 59 48
# [26] 59 86 55 68 51 33 49 67 77 81 67 71 81 68 70 77 56

kingstimeseries <- ts(kings)
kingstimeseries
# Time Series:
# Start = 1
# End = 42
# Frequency = 1
# [1] 60 43 67 50 56 42 50 65 68 43 65 34 47 34 49 41 13 35 53 56 16 43 69 59 48
# [26] 59 86 55 68 51 33 49 67 77 81 67 71 81 68 70 77 56

# births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
births <- scan("../input/nybirths.dat")
# Read 168 items
birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
birthstimeseries

# souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenir <- scan("../input/fancy.dat")
# Read 84 items
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries

plot.ts(kingstimeseries)
plot.ts(birthstimeseries)
plot.ts(souvenirtimeseries)

logsouvenirtimeseries <- log(souvenirtimeseries)
plot.ts(logsouvenirtimeseries)

library("TTR")

kingstimeseriesSMA3 <- SMA(kingstimeseries,n=3)
plot.ts(kingstimeseriesSMA3)
kingstimeseriesSMA8 <- SMA(kingstimeseries,n=8)
plot.ts(kingstimeseriesSMA8)

birthstimeseriescomponents <- decompose(birthstimeseries)
print("birthstimeseriescomponents$seasonal")
birthstimeseriescomponents$seasonal
print("birthstimeseriescomponents$trend")
birthstimeseriescomponents$trend
print("birthstimeseriescomponents$random")
birthstimeseriescomponents$random
plot(birthstimeseriescomponents)

# Seasonally adjusting

birthstimeseriescomponents <- decompose(birthstimeseries)
birthstimeseriesseasonallyadjusted <- birthstimeseries - birthstimeseriescomponents$seasonal
plot(birthstimeseriesseasonallyadjusted)


# Forecasts using Exponential Smoothing - https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html#forecasts-using-exponential-smoothing
# Simple Exponential Smoothing

# rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
rain <- scan("../input/precip1.dat",skip=1)
# Read 100 items
rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)

rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma=FALSE)
print("rainseriesforecasts")
rainseriesforecasts
print("rainseriesforecasts$fitted")
rainseriesforecasts$fitted

plot(rainseriesforecasts)

print("rainseriesforecasts$SSE")
rainseriesforecasts$SSE

# HoltWinters(rainseries, beta=FALSE, gamma=FALSE, l.start=23.56)


library("forecast")

# This code does not work:
# rainseriesforecasts2 <- forecast.HoltWinters(rainseriesforecasts, h=8)
# rainseriesforecasts2
# plot.forecast(rainseriesforecasts2)

# rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
rain <- scan("../input/precip1.dat",skip=1)
rainseries <- ts(rain,start=c(1813))

# This code works instead of the above (ref: https://stackoverflow.com/a/50656970)
rainseriesforecasts2 <- forecast:::forecast.HoltWinters(rainseriesforecasts, h=8)
rainseriesforecasts2
plot(forecast(rainseriesforecasts2))

# This code does not work
# acf(rainseriesforecasts2$residuals, lag.max=20)
# Fixed (ref: https://stackoverflow.com/a/45400995)
acf(rainseriesforecasts2$residuals, lag.max=20, na.action = na.pass)

Box.test(rainseriesforecasts2$residuals, lag=20, type="Ljung-Box")

plot.ts(rainseriesforecasts2$residuals)

plotForecastErrors <- function(forecasterrors)
{
  # make a histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd   <- sd(forecasterrors)
  mymin  <- min(forecasterrors) - mysd*5
  mymax  <- max(forecasterrors) + mysd*3
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  mymin2 <- min(mynorm)
  mymax2 <- max(mynorm)
  if (mymin2 < mymin) { mymin <- mymin2 }
  if (mymax2 > mymax) { mymax <- mymax2 }
  # make a red histogram of the forecast errors, with the normally distributed data overlaid:
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1
  # generate normally distributed data with mean 0 and standard deviation mysd
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

plotForecastErrors(rainseriesforecasts2$residuals)

# Above code does not work:
# Error in quantile.default(as.numeric(x), c(0.25, 0.75), na.rm = na.rm,  : 
#   missing values and NaN's not allowed if 'na.rm' is FALSE 
# 6. stop("missing values and NaN's not allowed if 'na.rm' is FALSE") 
# 5. quantile.default(as.numeric(x), c(0.25, 0.75), na.rm = na.rm, names = FALSE, type = type) 
# 4. quantile(as.numeric(x), c(0.25, 0.75), na.rm = na.rm, names = FALSE, type = type) 
# 3. diff(quantile(as.numeric(x), c(0.25, 0.75), na.rm = na.rm, names = FALSE, type = type)) 
# 2. IQR(forecasterrors) 
# 1. plotForecastErrors(rainseriesforecasts2$residuals) 



# skirts <- scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)
skirts <- scan("../input/skirts.dat",skip=5)
# Read 46 items
skirtsseries <- ts(skirts,start=c(1866))
plot.ts(skirtsseries)

skirtsseriesforecasts <- HoltWinters(skirtsseries, gamma=FALSE)
skirtsseriesforecasts
skirtsseriesforecasts$SSE
plot(skirtsseriesforecasts)

HoltWinters(skirtsseries, gamma=FALSE, l.start=608, b.start=9)

# skirtsseriesforecasts2 <- forecast.HoltWinters(skirtsseriesforecasts, h=19)
# plot.forecast(skirtsseriesforecasts2)
# Fixed with...
skirtsseriesforecasts2 <- forecast:::forecast.HoltWinters(skirtsseriesforecasts, h=19)
plot(forecast(skirtsseriesforecasts2))

# acf(skirtsseriesforecasts2$residuals, lag.max=20, na.action = na.pass)
# Fixed by appending ", na.action = na.pass"
acf(skirtsseriesforecasts2$residuals, lag.max=20, na.action = na.pass)
Box.test(skirtsseriesforecasts2$residuals, lag=20, type="Ljung-Box")

plot.ts(skirtsseriesforecasts2$residuals)            # make a time plot
plotForecastErrors(skirtsseriesforecasts2$residuals) # make a histogram
# Same error as above




# Holt-Winters Exponential Smoothing
# https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html#holt-winters-exponential-smoothing

# If you have a time series that can be described using an additive model with increasing or decreasing trend and seasonality, you can use Holt-Winters exponential smoothing to make short-term forecasts.
# Holt-Winters exponential smoothing estimates the level, slope and seasonal component at the current time point. Smoothing is controlled by three parameters: alpha, beta, and gamma, for the estimates of the level, slope b of the trend component, and the seasonal component, respectively, at the current time point. The parameters alpha, beta and gamma all have values between 0 and 1, and values that are close to 0 mean that relatively little weight is placed on the most recent observations when making forecasts of future values.
# An example of a time series that can probably be described using an additive model with a trend and seasonality is the time series of the log of monthly sales for the souvenir shop at a beach resort town in Queensland, Australia (discussed above):

# souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenir <- scan("../input/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
logsouvenirtimeseries <- log(souvenirtimeseries)
plot.ts(logsouvenirtimeseries)

# To make forecasts, we can fit a predictive model using the HoltWinters() function. For example, to fit a predictive model for the log of the monthly sales in the souvenir shop, we type:

logsouvenirtimeseries <- log(souvenirtimeseries)
souvenirtimeseriesforecasts <- HoltWinters(logsouvenirtimeseries)
souvenirtimeseriesforecasts

# The estimated values of alpha, beta and gamma are 0.41, 0.00, and 0.96, respectively. The value of alpha (0.41) is relatively low, indicating that the estimate of the level at the current time point is based upon both recent observations and some observations in the more distant past. The value of beta is 0.00, indicating that the estimate of the slope b of the trend component is not updated over the time series, and instead is set equal to its initial value. This makes good intuitive sense, as the level changes quite a bit over the time series, but the slope b of the trend component remains roughly the same. In contrast, the value of gamma (0.96) is high, indicating that the estimate of the seasonal component at the current time point is just based upon very recent observations.
# As for simple exponential smoothing and Holt’s exponential smoothing, we can plot the original time series as a black line, with the forecasted values as a red line on top of that:

plot(souvenirtimeseriesforecasts)

# We see from the plot that the Holt-Winters exponential method is very successful in predicting the seasonal peaks, which occur roughly in November every year.
# To make forecasts for future times not included in the original time series, we use the “forecast.HoltWinters()” function in the “forecast” package. For example, the original data for the souvenir sales is from January 1987 to December 1993. If we wanted to make forecasts for January 1994 to December 1998 (48 more months), and plot the forecasts, we would type:

# souvenirtimeseriesforecasts2 <- forecast.HoltWinters(souvenirtimeseriesforecasts, h=48)
# plot.forecast(souvenirtimeseriesforecasts2)
souvenirtimeseriesforecasts2 <- forecast:::forecast.HoltWinters(souvenirtimeseriesforecasts, h=48)
plot(forecast(souvenirtimeseriesforecasts2))


# The forecasts are shown as a blue line, and the orange and yellow shaded areas show 80% and 95% prediction intervals, respectively.
# We can investigate whether the predictive model can be improved upon by checking whether the in-sample forecast errors show non-zero autocorrelations at lags 1-20, by making a correlogram and carrying out the Ljung-Box test:

# acf(souvenirtimeseriesforecasts2$residuals, lag.max=20)
acf(souvenirtimeseriesforecasts2$residuals, lag.max=20, na.action = na.pass)
Box.test(souvenirtimeseriesforecasts2$residuals, lag=20, type="Ljung-Box")

# The correlogram shows that the autocorrelations for the in-sample forecast errors do not exceed the significance bounds for lags 1-20. Furthermore, the p-value for Ljung-Box test is 0.6, indicating that there is little evidence of non-zero autocorrelations at lags 1-20.
# We can check whether the forecast errors have constant variance over time, and are normally distributed with mean zero, by making a time plot of the forecast errors and a histogram (with overlaid normal curve):
#
plot.ts(souvenirtimeseriesforecasts2$residuals)            # make a time plot
plotForecastErrors(souvenirtimeseriesforecasts2$residuals) # make a histogram
# Again, the above does not work

# From the time plot, it appears plausible that the forecast errors have constant variance over time. From the histogram of forecast errors, it seems plausible that the forecast errors are normally distributed with mean zero.
# Thus,there is little evidence of autocorrelation at lags 1-20 for the forecast errors, and the forecast errors appear to be normally distributed with mean zero and constant variance over time. This suggests that Holt-Winters exponential smoothing provides an adequate predictive model of the log of sales at the souvenir shop, which probably cannot be improved upon. Furthermore, the assumptions upon which the prediction intervals were based are probably valid.



# ARIMA Models
# https://a-little-book-of-r-for-time-series.readthedocs.io/en/latest/src/timeseries.html#arima-models

getwd()

skirts <- scan("../input/skirts.dat",skip=5)
skirtsseries <- ts(skirts,start=c(1866))
skirtsseriesdiff1 <- diff(skirtsseries, differences=1)
plot.ts(skirtsseriesdiff1)

skirtsseriesdiff2 <- diff(skirtsseries, differences=2)
plot.ts(skirtsseriesdiff2)

kings <- scan("../input/kings.dat",skip=3)
kingstimeseries <- ts(kings)
kingtimeseriesdiff1 <- diff(kingstimeseries, differences=1)
plot.ts(kingtimeseriesdiff1)

acf(kingtimeseriesdiff1, lag.max=20)             # plot a correlogram
acf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the autocorrelation values

pacf(kingtimeseriesdiff1, lag.max=20)             # plot a partial correlogram
pacf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the partial autocorrelation 

auto.arima(kings)


# volcanodust <- scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip=1)
volcanodust <- scan("../input/dvi.dat", skip=1)
volcanodustseries <- ts(volcanodust,start=c(1500))
plot.ts(volcanodustseries)

