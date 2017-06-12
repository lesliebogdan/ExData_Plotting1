######################
# will be using these libraries

# use to transform 'Date' to a date format (use then to find weekdays)
library(lubridate)
######################


# This function will complete the 'plot 1' requirements and return the reuqired PNG file

#STEP 1
#read in the dataset (assumes the txt file is in the current working directory)

df<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#STEP 2
#create a subset which contains the two days we care about 1/2/2007 and 2/2/2007
#change to a date format to then extract the day of the week

df_days<-subset(df,df$Date=="1/2/2007"|df$Date=="2/2/2007")
#STEP 3 
# change 'Date' to date format
df_days$Date<-dmy(df_days$Date)

#STEP 4
#create new Date + Time column
df_days$DateTime<-as.POSIXct(paste(df_days$Date,df_days$Time))

#STEP 5
#the measure we care about needs to be changed from a factor to a numeric
df_days$Global_active_power<-as.numeric(as.character(df_days$Global_active_power))

#STEP 6
#config the png details
png(filename = "plot2.png",width = 480, height = 480)

#STEP 7
# plot the data
with(df_days,plot(DateTime,
                  Global_active_power,
                  lines(DateTime,Global_active_power),
                  ylab="Global Active Power (kilowatts)",
                  xlab="",
                  pch=""
)
)

#STEP LAST
#turn off with dev.off()
dev.off()