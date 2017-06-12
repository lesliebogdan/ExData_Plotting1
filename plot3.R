######################
# will be using these libraries

# use to transform 'Date' to a date format (use then to find weekdays)
library(lubridate)
library(reshape2)
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

df_days$Sub_metering_1<-as.numeric(as.character(df_days$Sub_metering_1))
df_days$Sub_metering_2<-as.numeric(as.character(df_days$Sub_metering_2))
df_days$Sub_metering_3<-as.numeric(as.character(df_days$Sub_metering_3))

#STEP 

keeps<-c("DateTime",
         "Sub_metering_1",
         "Sub_metering_2",
         "Sub_metering_3")

#Drop the columns you do not need
df_days_drop<-df_days[keeps]

#melt the df to only have the columns you care about left
df_days_melt<-melt(df_days_drop, id=c("DateTime"))

#convert the 'value' return to numeric values so you can plot them                    
#df_days_melt$value<-as.numeric(df_days_melt$value)


#STEP 6
#config the png details
png(filename = "plot3.png",width = 480, height = 480)

#STEP 7
# plot the data
with(df_days_melt,
        plot(DateTime,
        value,
        type="l",
        ylab="Energy sub metering",
        xlab=""
        )
)

with(subset(df_days_melt, variable == "Sub_metering_1"),
     points(DateTime,value, col = "black",type="l"))

with(subset(df_days_melt, variable == "Sub_metering_2"),
     points(DateTime,value, col = "red",type="l"))

with(subset(df_days_melt, variable == "Sub_metering_3"),
     points(DateTime,value, col = "blue",type="l"))

legend("topright", 
       lty=1, 
       col = c("black",
               "red",
               "blue"), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3")
       )


#STEP LAST
#turn off with dev.off()
dev.off()