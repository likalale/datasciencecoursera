# QUESTIoN 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


#Preparing and subsetting the dataframe
#Filter only the sources with coal combustion related souces and use column SCC to subset NEI
coal <-  grep("Comb.*Coal", SCC$Short.Name, ignore.case=TRUE)  
SCC.coal <-  SCC[coal,] 
NEI.coal <- NEI[(NEI$SCC %in% SCC.coal$SCC), ] 


 #Group per year.
 NEI.coal<- summarise(group_by(NEI.coal, year), sum(Emissions))
 names(NEI.coal) <- c("Year", "Emissions")
 NEI.coal$Year <- as.character(NEI.coal$Year)


#Plot- Barplot
png(filename = "q4.png", width = 500, height = 500, units='px')
cp <- ggplot(NEI.coal, aes(Year, weight = Emissions/1000))
cp + geom_bar(fill = "powderblue") +
  labs(x="year", y = "PM2.5 Emissions(in ThousandTons)" )+ 
  labs(title="Total PM2.5 emissions from coal combustion related sources")


dev.off()
