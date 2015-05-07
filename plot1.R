plot1 <- function(){

        # Load file into data2 variable
        library(data.table)
        data2 <- fread("./household_power_consumption.txt", header=T, sep=";", colClasses=rep('character',9), na.strings=c("?"))
        
        # Define temporal range Date0: initial and Date1: last date to consider
        Date0 = as.Date('2007/02/01')
        Date1 = as.Date('2007/02/03')
        
        # Convert to date and numeric classes the interesting data
        data2$Date <- as.Date(data2$Date,format='%d/%m/%Y')
        data2$Global_active_power <- as.numeric(data2$Global_active_power)
        
        # Select only data from the defined temporal range
        indxD = (data2$Date >= Date0) & (data2$Date < Date1)
        
        # Plot to a png file
        png("./plot1.png")
        hist(data2$Global_active_power[indxD],col='red',main='Global Active Power',xlab='Global Active Power (kilowatts)')
        dev.off()
}