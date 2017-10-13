################################################################################
# Social Network Analysis - Non Participant Plotting
# Pilot Script Code
#importedData <- read.csv(file.choose(), header = TRUE)
#v <- unique(c(importedData[,1], importedData[,2])) #Define v from both columns in data
#v <- na.omit(v)
#e <- na.omit(importedData)
#g<-graph.data.frame(e, vertices = v, directed = T)
#plot(g)

data <- data.frame(ID = c(1,1,1,3,4,5,2), 
                   relation = c(3,4,5,1,1,1,NA))

v <- unique(c(data[,1], data[,2])) #Define v from both columns in data
v <- na.omit(v)
e <- na.omit(data)

g<-graph.data.frame(e, vertices = v, directed = F)
plot(g)
get.edgelist(g)
get.adjedgelist(g, mode = c("all"))
get.adjlist(g, mode = c("all"))
