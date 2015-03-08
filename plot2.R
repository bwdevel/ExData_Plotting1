#libraries covered in "Getting and Cleaning Data" as 
# part of the Data Science specialization.
library(dplyr)
library(lubridate)

# Read data from file
data <- read.csv("household_power_consumption.txt", 
                 sep = ";", na.strings = "?", header=TRUE)

# convert to a dplyr data frame table
data <- tbl_df(data)

#strip unneeded columns
data <- select(data, Date, Time, Global_active_power)

# filter down to target dates
data <- filter(data, dmy(Date) == dmy("01/02/2007") | 
                   dmy(Date) == dmy("02/02/2007"))

# convert target data to desired obj type and create a single 
# var to hold date and time
data <- mutate(data, Date_Time = dmy_hms(paste(Date, Time)))

# open png device
png(file = "plot2.png", width = 480, height = 480)

# set bg to transparent (not required, but the examples in the 
# assignment are also transparent)
par("bg" = "transparent")

# plot data, set type to line, set x&y lables
with(data, plot(Date_Time, Global_active_power, type = "l", ylab = "Global Active Power (killowatts)", xlab = ""))

# close the device
dev.off()
