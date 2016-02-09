# Read in the source data file from text using a semi-colon delimiter (2,075,259 rows)
data <- read.delim("household_power_consumption.txt", sep=";")

# Confirm the number of columns and rows are expected
print(paste(length(names(data)),"x",nrow(data)))

# Convert the date string to a date field & produce a date-time field is a concatenation of the date and time fields
data$Date = as.Date(strptime(data$Date, "%d/%m/%Y"))
data$Date_Time = as.Date(strptime(paste(data$Date,data$Time), "%Y-%m-%d %H:%M:%S"))
head(data)

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


# Plot 1 - 
hist(data_$Global_active_power/500, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     border="black", 
     col="red",
     xlim=c(0,6),
     ylim=c(0,1200),
     breaks=13)
dev.copy(png,'plot1.png')
dev.off()

