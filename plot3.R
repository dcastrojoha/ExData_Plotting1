## This code assumes the raw data file is in your working directory

# Reading in the data
  data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")


# Inspecting the data
  summary(data)
  lapply(data, class)


# Converting time and date
  data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
  data$Time <- strptime(data$Time, format = "%H:%M:%S")
  data$Time <- strftime(data$Time, '%H:%M:%S')

# Subsetting the data for the two relevant dates
  data1 <- subset(data, Date %in% c(as.Date('2007-02-01'), as.Date('2007-02-02')))

# Building out Plot 3
  png("plot3.png", width = 480, height = 480)
    with(data1, plot(Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n"))
    with(data1, lines(Sub_metering_2, col = "red"))
    with(data1, lines(Sub_metering_3, col = "blue"))
    axis(side = 1, at = c(0,1450, 2900), labels = c("Thu", "Fri", "Sat"))
    legend("topright", lty = c(1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  dev.off()

