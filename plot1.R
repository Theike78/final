project <- function(){

##Read the data, read only the data from 2007-02-01 and 2007-02-02
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
        png(filename = "plot1.png", width = 480, height = 480, units = "px", type = "quartz")
        
## create the first plot, a histogram of Global Active Power in the screen device
        with(file,
             hist(file$global_active_power, 
                  xlab = "Global Active Power (kilowatts)", 
                  col = "red",
                  main = "Global Active Power"))

        dev.off()
}