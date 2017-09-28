# This script constructs plot 1
# The plot is a histogram of the Global Active Power

# Reading the data
# Only the data from the dates 2007-02-01 and 2007-02-02 is used
# 2007-02-01 starts at row 66638 and 2007-02-02 ends at row 69517
# So when reading the data the first 66637 rows are skipped 
# and the next 69517-66637=2880 rows will be read
# the first row can't be used as the header so it has to be read seperately
# so it can be used for the column names

filename <- "household_power_consumption.txt"
data <- read.table(file="household_power_consumption.txt", sep=";",skip=66637, nrows=2880, header=FALSE)
header <- header <- read.table(file="household_power_consumption.txt", sep=";",nrows=1, header = FALSE, stringsAsFactors = FALSE)
colnames(data) <- unlist(header)

# create plot1 and setting the main title, axis labels 
# and the colour of the bins


plot1 <- hist(data$Global_active_power,
          main="Global Active Power",
          xlab="Global Active Power (kiloWatts)",
          ylab="Frequency",
          col="red")

# save plot to png file

dev.copy(png, file="plot1.png",width=480, height=480)
dev.off()
         
  
 
 
  
  

  
  
 



