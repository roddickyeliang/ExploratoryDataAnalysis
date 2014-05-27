# Load Source Data
require(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")

# Baltimore City, Maryland (fips == "24510")
BC <- subset(NEI, fips == 24510)
BC$year <- factor(BC$year, levels=c('1999', '2002', '2005', '2008'))

png('plot3.png', width=800, height=500, units='px')
ggplot(data=BC, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log', ' of PM'[2.5], ' emitted, in tons'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City, Maryland') +
  geom_jitter(alpha=0.10)
dev.off()