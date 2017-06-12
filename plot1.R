

# This function will complete the 'plot 1' requirements and return the reuqired PNG file

#STEP 1
#read in the dataset (assumes the txt file is in the current working directory)

df<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

#STEP 2
#create a subset which contains the two days we care about 1/2/2007 and 2/2/2007

df_days<-subset(df,df$Date=="1/2/2007"|df$Date=="2/2/2007")

#STEP 3
#the measure we care about needs to be changed from a factor to a numeric
df_days$Global_active_power<-as.numeric(as.character(df_days$Global_active_power))

#STEP 4
#config the png details
png(filename = "plot1.png",width = 480, height = 480)

#STEP 5
# plot the histogram
with(df_days,hist(Global_active_power,
                  main="Global Active Power",
                  xlab="Global Active Power (kilowatts)",
                  ylab="Frequency",
                  col="red"
        )
)
#STEP LAST
#turn off with dev.off()
dev.off()
