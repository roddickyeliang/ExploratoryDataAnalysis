# Load Source Data
NEI <- readRDS("summarySCC_PM25.rds")

# Aggregate
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

png(filename='plot1.png', width=480, height=480, units="px")
barplot(Emissions$PM, names.arg=Emissions$Group.1, main=expression('Total Emission of PM'[2.5]), 
        xlab='Year', ylab=expression(paste('PM', ''[2.5], ' emitted, in Kilotons')))
dev.off()