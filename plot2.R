#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 2  =================================

#===== Second Plot Script =========
library(dplyr)
# First part to check if data loaded to memory

if(!exists("NEI")){
  if(!file.exists("NEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","NEI_data.zip")}
  if(!file.exists("summarySCC_PM25.rds")){unzip("NEI_data.zip")}
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  PM25<-tbl_df(merge(NEI,SCC,by.x = "SCC",by.y = "SCC"))
}


#Data processing
x<- PM25 %>% filter(fips=="24510") %>% select(Emissions,year) %>% group_by(year) %>% summarize_each(funs(sum))


#Plotting 
windows()

plot(x,type = "l",main="PM2.5 in the Baltimore City, Maryland")

#writing result to plot2.png device

dev.copy(png,filename="plot2.png",width=480,height=480,units="px")
dev.off()