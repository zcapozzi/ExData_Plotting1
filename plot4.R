setwd("C:\\Users\\zcapozzi002\\Documents\\GitHub\\ExData_Plotting1\\")

# Read in the source data file from text using a semi-colon delimiter (2,075,259 rows)
data <- read.delim("household_power_consumption.txt", sep=";")

# Confirm the number of columns and rows are expected
print(paste(length(names(data)),"x",nrow(data)))

# Convert the date string to a date field & produce a date-time field is a concatenation of the date and time fields
data$Date = as.Date(strptime(data$Date, "%d/%m/%Y"))
data$Date_Time = as.Date(strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S"))

# Filter the data set for the relevant days
data_ = subset(data, data$Date == "2007-02-01" | data$Date == "2007-02-02")
data_$Date_Time_ = as.POSIXct(strptime(paste(data_$Date,data_$Time), "%Y-%m-%d %H:%M:%S"))

# Remove rows with missing data
data_ = subset(data_, data_$Global_active_power != "?")
data_ = subset(data_, data_$Sub_metering_1 != "?")
data_ = subset(data_, data_$Sub_metering_2 != "?")
data_ = subset(data_, data_$Sub_metering_3 != "?")
data_ = subset(data_, data_$Voltage != "?")

# Convert strings to numeric values
data_$Global_active_power = as.numeric(data_$Global_active_power)
data_$Sub_metering_1 = as.numeric(data_$Sub_metering_1)
data_$Sub_metering_2 = as.numeric(data_$Sub_metering_2)
data_$Sub_metering_3 = as.numeric(data_$Sub_metering_3)
data_$Voltage = as.numeric(data_$Voltage)

# Plot 4 - 
png(file='plot4.png')
par(mfrow= c(2, 2))
# Replicate plot 2
plot(data_$Date_Time_,data_$Global_active_power/500, type="l", ylab="Global Active Power (kilowatts)")
# New Plot
plot(data_$Date_Time_,data_$Voltage, type="l", ylab="Voltage", xlab="datetime")
# Replicate plot 3
plot(data_$Date_Time_,data_$Sub_metering_1, type="l", ylim=c(0,40), xlab="", ylab="Energy Sub metering", col=1)
par(new=T)
plot(data_$Date_Time_,data_$Sub_metering_2, type="l", ylim=c(0,40), xlab="", ylab="", col=2)
par(new=T)
plot(data_$Date_Time_,data_$Sub_metering_3, type="l", ylim=c(0,40), xlab="", ylab="", col=4)
legend("topright", c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c('black','blue','red'))
par(new=F)
# New Plot
plot(data_$Date_Time_,data_$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()


