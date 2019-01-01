# https://otexts.org/fpp2/holt-winters.html
# Example: International tourist visitor nights in Australia
# We apply Holt-Winters’ method with both additive and multiplicative seasonality to forecast quarterly visitor nights in Australia spent by international tourists. Figure 7.6 shows the data from 2005, and the forecasts for 2016–2017. The data show an obvious seasonal pattern, with peaks observed in the March quarter of each year, corresponding to the Australian summer.

library(fpp2)

aust <- window(austourists,start=2005)
fit1 <- hw(aust,seasonal="additive")
fit2 <- hw(aust,seasonal="multiplicative")
autoplot(aust) +
  autolayer(fit1, series="HW additive forecasts", PI=FALSE) +
  autolayer(fit2, series="HW multiplicative forecasts",
            PI=FALSE) +
  xlab("Year") +
  ylab("Visitor nights (millions)") +
  ggtitle("International visitors nights in Australia") +
  guides(colour=guide_legend(title="Forecast"))

# Forecasting international visitor nights in Australia using the Holt-Winters method with both additive and multiplicative seasonality.
# Figure 7.6: Forecasting international visitor nights in Australia using the Holt-Winters method with both additive and multiplicative seasonality.
