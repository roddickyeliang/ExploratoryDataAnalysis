# Load Source Data
NEI <- readRDS("summarySCC_PM25.rds")

# Baltimore City, Maryland (fips == "24510")
BC <- subset(NEI, fips=='24510')

png(filename='plot2.png', width=480, height=480, units="px")
barplot(tapply(X=BC$Emissions, INDEX=BC$year, FUN=sum), main='Total Emission in Baltimore City, Maryland', 
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' emitted, in tons')))
dev.off()