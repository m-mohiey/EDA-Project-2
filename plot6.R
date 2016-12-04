#================== Course 4: Exploratory Data Analysis ===============
#================== Course Project 2  =================================

#===== Sixth Plot Script =========
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
x1<- PM25 %>% filter(fips=="24510") %>% filter(grepl("(?=.*otor)(?=.*ehicle)",Short.Name,perl = T)) %>% select(Emissions,year) %>% group_by(year) %>% summarize_each(funs(sum))
x2<- PM25 %>% filter(fips=="06037") %>% filter(grepl("(?=.*otor)(?=.*ehicle)",Short.Name,perl = T)) %>% select(Emissions,year) %>% group_by(year) %>% summarize_each(funs(sum))


#Plotting 
windows()
par(mar=c(2,5,2,5))
plot(x1,type = "l",main="Emissions from motor vehicle sources changed from 1999-2008 in Baltimore V LA",ylab="Emissions in Baltimore")
par(new=T)
plot(x2,col="green",axes=F,type="l",lwd=3,ylab="")
mtext(side = 4, line = 3, 'Emissions in Los Angeles')
legend("bottomright",col=c("black","green"),legend = c("Baltimore","Los Angeles"),lty =1)
axis(side = 4)
#writing result to plot6.png device

dev.copy(png,filename="plot6.png",width=480,height=480,units="px")
dev.off()