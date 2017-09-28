# This script constructs plot 2
# The plot is a graph of the Global Active Power over time

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

# creating the data for the x and y axis
# for the x-axis the Date and Time column are combined
# the function 'dmy_hms' from the lubridate package is used to 
# convert from a character class to a date-time class

x <- dmy_hms(paste(data$Date, data$Time))
y <- data$Global_active_power

# creating a lineplot with the date/time on the x-axis and 
# Global Active Power on the y-axis
# the label on the x-axis is removed and the label on the y-axis
# is set to 'Global Active Power (kiloWatts)

plot2 <- plot(x=x, y=y, type="l",
              xlab="",
              ylab="Global Active Power (kiloWatts)")

# save plot to png file

dev.copy(png, file="plot2.png",width=480, height=480)
dev.off()

