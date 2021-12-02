#flood risk comparison example 

id.floodrisk <- read.csv("data/flood_example/idaho_floodrisk_firststreet.csv")
id.fema.2020.total <- round(sum(id.floodrisk$FEMA.Properties.at.Risk.2020..total.), digits=0)
id.fema.2020.pct <- round(mean(id.floodrisk$FEMA.Properties.at.Risk.2020..pct.), digits=1)
id.fs.2020.total <- round(sum(id.floodrisk$FS.Properties.at.Risk.2020..total.), digits=0)
id.fs.2020.pct <- round(mean(id.floodrisk$FS.Properties.at.Risk.2020..pct.), digits=1)

or.floodrisk <- read.csv("data/flood_example/oregon_floodrisk_firststreet.csv")
or.fema.2020.total <- round(sum(or.floodrisk$FEMA.Properties.at.Risk.2020..total.), digits=0)
or.fema.2020.pct <- round(mean(or.floodrisk$FEMA.Properties.at.Risk.2020..pct.), digits=1)
or.fs.2020.total <- round(sum(or.floodrisk$FS.Properties.at.Risk.2020..total.), digits=0)
or.fs.2020.pct <- round(mean(or.floodrisk$FS.Properties.at.Risk.2020..pct.), digits=1)

wa.floodrisk <- read.csv("data/flood_example/washington_floodrisk_firststreet.csv")
wa.fema.2020.total <- round(sum(wa.floodrisk$FEMA.Properties.at.Risk.2020..total.), digits=0)
wa.fema.2020.pct <- round(mean(wa.floodrisk$FEMA.Properties.at.Risk.2020..pct.), digits=1)
wa.fs.2020.total <- round(sum(wa.floodrisk$FS.Properties.at.Risk.2020..total.), digits=0)
wa.fs.2020.pct <- round(mean(wa.floodrisk$FS.Properties.at.Risk.2020..pct.), digits=1)

state.comp <- matrix(c(id.fema.2020.total, or.fema.2020.total, wa.fema.2020.total, id.fema.2020.pct, or.fema.2020.pct, wa.fema.2020.pct, id.fs.2020.total, or.fs.2020.total, wa.fs.2020.total, id.fs.2020.pct, or.fs.2020.pct, wa.fs.2020.pct), ncol=3, byrow=TRUE)
colnames(state.comp) <- c("Idaho", "Oregon", "Washington")
rownames(state.comp) <- c("Total FEMA Properties at Risk (2020) ", "Percent FEMA Properties at Risk (2020)", "Total FS Properties at Risk (2020) ", "Percent FS Properties at Risk (2020)")
