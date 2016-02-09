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

# Plot 2 - 
plot(data_$Date_Time_,data_$Global_active_power/500, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,'plot2.png')
dev.off()
