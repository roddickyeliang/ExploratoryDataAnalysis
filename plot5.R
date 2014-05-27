# Load Source Data
require(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))
SCC <- readRDS("Source_Classification_Code.rds")

# Baltimore City, Maryland (fips == "24510")
BC.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
BC.df <- aggregate(BC.onroad[, 'Emissions'], by=list(BC.onroad$year), sum)
colnames(BC.df) <- c('year', 'Emissions')
 
png('plot5.png', width=600, height=480, units="px")
ggplot(data=BC.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
    ylab(expression(paste('PM'[2.5], ' emitted, in tons'))) + xlab('Year') + theme(legend.position='none') + 
    geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))
dev.off()