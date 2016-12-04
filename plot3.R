#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 2  =================================

#===== Third Plot Script =========
library(dplyr)
library(tidyr)
library(ggplot2)
# First part to check if data loaded to memory

if(!exists("NEI")){
  if(!file.exists("NEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip","NEI_data.zip")}
  if(!file.exists("summarySCC_PM25.rds")){unzip("NEI_data.zip")}
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  PM25<-tbl_df(merge(NEI,SCC,by.x = "SCC",by.y = "SCC"))
}


#Data processing
x<- PM25 %>% filter(fips=="24510") %>% select(Emissions,year,type) %>% group_by(year,type) %>% summarize_each(funs(sum)) #%>% spread(type,Emissions)


#Plotting 
windows()

qplot(year,Emissions,data=x,geom = "line",color=type,main="Emissions from 1999-2008 for Baltimore City")

#writing result to plot3.png device

dev.copy(png,filename="plot3.png",width=480,height=480,units="px")
dev.off()