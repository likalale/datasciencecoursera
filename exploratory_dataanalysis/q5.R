#QUESTION 5. How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Preparing and subsetting the dataframe. Filter only the vehicles. Subset the NEI using the column SCC
vehicle  <-  grep("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)  
SCC.vehicle  <-  SCC[vehicle ,] 
NEI.vehicle <- NEI[(NEI$SCC %in% SCC.vehicle$SCC), ] 


#Group per year. Filter only Baltimore City
NEI.vehicle<- summarise(group_by(filter(NEI.vehicle, fips == "24510"), year), sum(Emissions))
names(NEI.vehicle) <- c("Year", "Emissions")
NEI.vehicle$Year <- as.character(NEI.vehicle$Year)


#Plot- Barplot
png(filename = "q5.png", width = 500, height = 500, units='px')
vp <- ggplot(NEI.vehicle, aes(Year, weight = Emissions))
vp + geom_bar(fill = "turquoise" ) + 
  labs(x="Year", y= "PM2.5 Emissions(tons)" )+ 
  labs(title="Motor vehicles total PM2.5 emissions from 1999-2008")
dev.off()
