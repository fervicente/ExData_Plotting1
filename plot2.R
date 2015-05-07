plot2 <- function(){
        
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
        data2$Global_active_power <- as.numeric(data2$Global_active_power)
        
        # Plot to a png file
        png("./plot2.png")
        plot(data2$Time,data2$Global_active_power,main='Global Active Power',ylab='Global Active Power (kilowatts)',xlab='',type='l')
        dev.off()    
}