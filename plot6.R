# Load Source Data
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland
# Los Angeles County, California
BC.onroad <- subset(NEI, fips == '24510' & type == 'ON-ROAD')
CA.onroad <- subset(NEI, fips == '06037' & type == 'ON-ROAD')

# Aggregate
BC.DF <- aggregate(BC.onroad[, 'Emissions'], by=list(BC.onroad$year), sum)
colnames(BC.DF) <- c('year', 'Emissions')
BC.DF$City <- paste(rep('BC', 4))

CA.DF <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.DF) <- c('year', 'Emissions')
CA.DF$City <- paste(rep('CA', 4))

DF <- as.data.frame(rbind(BC.DF, CA.DF))

png('plot6.png', width=600, height=480, units="px")
ggplot(data=DF, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources\nBaltimore City, Maryland vs. Los Angeles County, California') + 
    ylab(expression(paste('PM'[2.5], ' emitted, in tons'))) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))
dev.off()