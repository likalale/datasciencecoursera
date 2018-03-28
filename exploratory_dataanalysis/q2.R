# QUESTION 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

library(dplyr)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Group per year. then get the total emissions
NEI.Baltimore <- summarise(group_by(filter(NEI, fips == 24510),year), sum(Emissions))
names(NEI.Baltimore) <- c("Year", "Emissions")

#Plot- Barplot
png(filename = "q2.png", width = 500, height = 500, units='px')
barplot(NEI.Baltimore$Emissions, names.arg = NEI.Baltimore$Year, col = "palegreen",
        main = "Baltimore city total PM2.5 emissions from 1999-2008" , xlab = "Year", ylab = "PM2.5 Emissions(Tons)")
dev.off()
