
#souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenir <- scan("../input/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
print("souvenirtimeseries:")
souvenirtimeseries

plot.ts(souvenirtimeseries)

logsouvenirtimeseries <- log(souvenirtimeseries)
souvenirtimeseriesforecasts <- HoltWinters(logsouvenirtimeseries)
souvenirtimeseriesforecasts
# souvenirtimeseriesforecasts$fitted

# plot.ts(souvenirtimeseriesforecasts)
# Error in xy.coords(x, NULL, log = log, setLab = FALSE) : 
#   (list) object cannot be coerced to type 'double'

souvenirtimeseriesforecasts2 <- forecast:::forecast.HoltWinters(souvenirtimeseriesforecasts, h=48)
plot(forecast(souvenirtimeseriesforecasts2))
