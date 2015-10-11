project <- function(){
## read the data, read only the data from 2007-02-01 and 2007-02-02
        file <- read.table("household_power_consumption.txt",
                           header = TRUE,
                           sep = ";",
                           skip = 66636,
                           nrows = 2880,
                           col.names = c("date","time","global_active_power","global_reactive_power","voltage","global_intensity","sub_metering1","sub_metering2","sub_metering3"),
                           na.strings = c("?",""))
        
## convert the date and the time columns to one timestamp column with the correct class
        file$date <- as.Date(file$date, format = "%d/%m/%Y")
        file$timestamp <- paste(file$date, file$time)
        file$timestamp <- strptime(file$timestamp, format = "%Y-%m-%d %H:%M:%S")

## create an PNG file
        png(filename = "plot4.png", width = 480, height = 480, units = "px", type = "quartz")

## make sure we get 4 graphs
        par(mfrow = c(2,2))        

## create the plots
        with(file, {
                ## first plot
                plot(timestamp, 
                     global_active_power, 
                     ylab = "Global Active Power",
                     xlab = "",
                     type = "l")
                ## second plot
                plot(timestamp, 
                     voltage, 
                     ylab = "Voltage",
                     xlab = "datetime",
                     type = "l")
                ## third plot
                ## create the first plot with sub_meetering1
                with(file, 
                     plot(timestamp, 
                          sub_metering1, 
                          ylab = "Energy sub meetering",
                          xlab = "",
                          type = "l"))
                par(new = TRUE)
                
                ## create the second plot with sub_meetering2
                with(file, 
                     plot(timestamp, 
                          sub_metering2,
                          ylab = "",
                          xlab = "",
                          type = "l",
                          col = "red",
                          yaxt = "n",
                          xaxt = "n",
                          ylim = c(0,30)))
                par(new = TRUE)
                
                ## create the third plot of sub_meetering3
                with(file, 
                     plot(timestamp, 
                          sub_metering3,
                          ylab = "",
                          xlab = "",
                          type = "l",
                          col = "blue",
                          yaxt = "n",
                          xaxt = "n",
                          ylim = c(0,30)))
                
                ## add the legend
                legend("topright", 
                       pch = "___", 
                       col = c("black", "red", "blue"), 
                       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       cex = 0.7,
                       bty = "n")
                ## fourth plot
                plot(timestamp, 
                          global_reactive_power, 
                  ylab = "Global_reactive_power",
                  xlab = "datetime",
                  type = "l")
        })

        dev.off()
}