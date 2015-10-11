project <- function(){
## read the data, read only the data from 2007-02-01 and 2007-02-02
        file <- read.table("household_power_consumption.txt",
                               header = TRUE,
                               sep = ";",
                               skip = 66636,
                               nrows = 2880,
                               col.names = c("date",
                                             "time",
                                             "global_active_power",
                                             "global_reactive_power",
                                             "voltage","global_intensity",
                                             "sub_metering1",
                                             "sub_metering2",
                                             "sub_metering3"),
                               na.strings = c("?",""))
        
## convert the date and the time columns to one timestamp column with the correct class
        file$date <- as.Date(file$date, format = "%d/%m/%Y")
        file$timestamp <- paste(file$date, file$time)
        file$timestamp <- strptime(file$timestamp, format = "%Y-%m-%d %H:%M:%S")
        
## create an PNG file
        png(filename = "plot2.png", width = 480, height = 480, units = "px", type = "quartz")
        
## create the plot
        with(file, 
             plot(timestamp, 
                  global_active_power, 
                  ylab = "Global Active Power (kilowatts)",
                  xlab = "",
                  type = "l"))

        dev.off()
}