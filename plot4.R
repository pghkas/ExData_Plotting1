# This script constructs plot 4
# The plot is a grid of 4 graphs:
# - Global Active power over time
# - Voltage over time
# - Energy sub metering over time and
# - Global reactive power over time

# Reading the data
# Only the data from the dates 2007-02-01 and 2007-02-02 is used
# 2007-02-01 starts at row 66638 and 2007-02-02 ends at row 69517
# So when reading the data the first 66637 rows are skipped 
# and the next 69517-66637=2880 rows will be read
# the first row can't be used as the header so it has to be read seperately
# so it can be used for the column names

require(lubridate)

filename <- "household_power_consumption.txt"
data <- read.table(file="household_power_consumption.txt", sep=";",skip=66637, nrows=2880, header=FALSE)
header <- read.table(file="household_power_consumption.txt", sep=";",nrows=1, header = FALSE, stringsAsFactors = FALSE)
colnames(data) <- unlist(header)

# creating the data for the x-axis
# for the x-axis the Date and Time column are combined
# the function 'dmy_hms' from the lubridate package is used to 
# convert from a character class to a date-time class

x <- dmy_hms(paste(data$Date, data$Time))

# creating data for the top left graph

y_topleft <- data$Global_active_power

# creatting data for the bottom left graph

y1_bottomleft <- data$Sub_metering_1
y2_bottomleft <- data$Sub_metering_2
y3_bottomleft <- data$Sub_metering_3

# creating data for the top right graph

y_topright <- data$Voltage

# creating data for the bottom right graph

y_bottomright <- data$Global_reactive_power

# set parameter to arrange 4 graphs in a 2 by 2 grid

par(mfcol=c(2,2), cex=0.6)

# add to the topleft a lineplot with the date/time on the x-axis and 
# Global Active Power on the y-axis
# the label on the x-axis is removed and the label on the y-axis
# is set to 'Global Active Power

plot(x=x, y=y_topleft, type="l",
              xlab="",
              ylab="Global Active Power")

# add to bottomleft a lineplot with the date/time on the x-axis and 
# sub metering 1 on the y-axis
# sub metering 2 and sub metering 3 are added as lines
# the label on the x-axis is removed and the label on the y-axis
# is set to 'Energy sub metering'

plot(x=x, y=y1_bottomleft, type="l",
              xlab="",
              ylab="Energy sub metering")
lines(x=x, y=y2_bottomleft, col="red")
lines(x=x, y=y3_bottomleft, col="blue")

# add a legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1, lwd=2, bty="n")

# add to top right a lineplot with the date/time on the x-axis and
# Voltage on the y-axis
# the label on the x-axis is set to datetime and the label on the
# y-axis is set to 'Voltage'

plot(x=x, y=y_topright, typ="l",
     xlab="datetime",
     ylab="Voltage")

# add to the bottom right a line plot with the date/time on the x-axis and
# global reactive poer on the y-axis
# the label on the x-axis is set to datetime and the label on the
# y-axis is set to 'Global_reactive_power

plot(x=x, y=y_bottomright, type="l",
     xlab="datetime",
     ylab="Global_reactive_power")


# save plot to png file

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
