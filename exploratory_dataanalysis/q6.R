# QUESTION 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Preparing and subsetting the dataframe. Filter only the vehicles. Subset the NEI using the column SCC
vehicle  <-  grep("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)  
SCC.vehicle  <-  SCC[vehicle ,] 
NEI.vehicle <- NEI[(NEI$SCC %in% SCC.vehicle$SCC), ] 

 #Filter by fips(Baltimore = 24150 , LA = 06037). Group by year and get total emission
NEI.Baltimore<- summarise(group_by(filter(NEI.vehicle, fips == "24510" & type == "ON-ROAD"),year), sum(Emissions))
NEI.Baltimore <- mutate(NEI.Baltimore, Place = 'Baltimore')
names(NEI.Baltimore) <- c("Year", "Emissions", "Place")
NEI.Baltimore$Year <- as.character(NEI.Baltimore$Year)

NEI.LA <- summarise(group_by(filter(NEI.vehicle, fips == "06037" & type == "ON-ROAD"), year), sum(Emissions))
NEI.LA <- mutate(NEI.LA, Place = 'Los Angeles')
names(NEI.LA) <- c("Year", "Emissions", "Place")
NEI.LA$Year <- as.character(NEI.LA$Year)
 
NEI.city <- rbind(NEI.Baltimore, NEI.LA)
 
#Plot- Barplot
png(filename = "q6.png", width = 500, height = 500, units='px')
city.comp <- ggplot(NEI.city, aes(Year, weight = Emissions, fill = Year))
city.comp + geom_bar() + facet_grid( .~ Place) +
  xlab("Year") + ylab("PM2.5 emissions in tons") +
  ggtitle(expression("Motor vehicle total emission compariscon in Baltimore and Los Angeles"))
dev.off()
