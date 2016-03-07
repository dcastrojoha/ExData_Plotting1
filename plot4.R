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

# Building out Plot 4
  png("plot4.png", width = 480, height = 480)
    par(mfrow = c(2,2))   ## sets number of rows and columns
    # Top-Right Plot
      with(data1, plot(Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", xaxt = "n"))
      axis(side = 1, at = c(0,1450, 2900), labels = c("Thu", "Fri", "Sat"))
    # Top-Left Plot
      with(data1, plot(Voltage, xlab = "datetime", ylab = "Voltage", type = "l", xaxt = "n"))
      axis(side = 1, at = c(0,1450, 2900), labels = c("Thu", "Fri", "Sat"))
    # Bottom-Right Plot
      with(data1, plot(Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", xaxt = "n"))
      with(data1, lines(Sub_metering_2, col = "red"))
      with(data1, lines(Sub_metering_3, col = "blue"))
      axis(side = 1, at = c(0,1450, 2900), labels = c("Thu", "Fri", "Sat"))
      legend("topright", lty = c(1,1), col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    # Bottom-Left Plot
      with(data1, plot(Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l", xaxt = "n"))
      axis(side = 1, at = c(0,1450, 2900), labels = c("Thu", "Fri", "Sat"))
  dev.off()