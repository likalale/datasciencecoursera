# QUESTIoN 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Prepare the dataframe. Filter only Baltimore city. Group by type and year. Get total emission
Baltimore.type <- summarise(group_by(filter(NEI,fips == 24510),type,year), sum(Emissions))
names(Baltimore.type) <- c("Type","Year", "Emissions")
Baltimore.type$Year <- as.character(Baltimore.type$Year)

#Plot- Barplot
png(filename = "q3.png", width = 500, height = 500, units='px')
bp <- ggplot(Baltimore.type, aes(Year, weight = Emissions, fill=Year))
bp + geom_bar() + facet_grid(.~Type) + 
  labs(x="year", y= "PM2.5 Emissions(Tons)" )+ 
  labs(title="Total PM2.5 emissions in Baltimore City  from 1999-2008 by Source Type")

dev.off()
