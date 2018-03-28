# QUESTION 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission 
#from all sources for each of the years 1999, 2002, 2005, and 2008.#

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Group per year. then get the total emissions(divide by 1M to scale it in the graph)
NEI.YearMil <- summarise(group_by(NEI, year), sum(Emissions/ 1000000))
names(NEI.YearMil) <- c("Year", "Emissions")

#Plot- Barplot
png(filename = "q1.png", width = 500, height = 500, units='px')
barplot(NEI.YearMil$Emissions, names.arg = NEI.YearMil$Year, col = "paleturquoise",
        main = "United States total PM2.5 emissions from 1999-2008 " , xlab = "Year", ylab = "PM2.5 Emissions(inMillions Tons)")
dev.off()
