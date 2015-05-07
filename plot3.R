plot3 <- function(){
        
        #get the first line of file and put it into hpc.txt file overwriting it.
        system("head -n 1 ./household_power_consumption.txt > ./hpc.txt")
        # get all lines that start with 1/2/2007 or 2/2/2007 and ADD them to hpc.txt file
        system("grep '^[12]/2/2007' ./household_power_consumption.txt >> ./hpc.txt")
        
        # Load file into data2 variable
        library(data.table)
        data2 <- data.frame(fread("./hpc.txt", header=T, sep=";", colClasses=rep('character',9), na.strings=c("?")))
        
        # Convert to date and numeric classes the interesting data
        data2["cDateTime"] <- as.Date(data2$Date,format='%d/%m/%Y')
        
        # Convert to time class (combine date & time)
        d <- paste(data2$Date,data2$Time)
        data2$Time <- strptime(d,format='%d/%m/%Y %H:%M:%S')
        
        # Convert to numeric class
        data2$Sub_metering_1 <- as.numeric(data2$Sub_metering_1)
        data2$Sub_metering_2 <- as.numeric(data2$Sub_metering_2)
        data2$Sub_metering_3 <- as.numeric(data2$Sub_metering_3)
        
        # Plot to a png file
        png("./plot3.png")
        plot(data2$Time,data2$Sub_metering_1,type='l',xlab="",ylab="Energy sub metering")
        lines(data2$Time,data2$Sub_metering_2,col='red')
        lines(data2$Time,data2$Sub_metering_3,col='blue')
        legend("topright", lty=7, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()

}