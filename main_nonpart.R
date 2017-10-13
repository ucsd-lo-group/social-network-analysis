############################################################################################
# Social Network Analysis Parameters
# For cases where there are non-participants
# Sample Script Data
data <- data.frame(ID = c(143918,176206,210749,219170,
                          247818,314764,321459,335945,
                          339637,700689,712607,712946,
                          735907,735907,735907,735907,
                          735907,735907,735908,735908,
                          735908,735908,735908,735908,
                          735910,735911,735912,735913,
                          746929,746929,747540,755003,
                          767168,775558,776656,794173,
                          794175,807493), 
                   relation = c(111098,210749,176206,
                                NA,NA,NA,NA,NA,NA,807493,
                                NA,NA,735908,735910,735911,
                                735912,735913,767168,735907,
                                735910,735911,735912,735913,
                                767168,NA,NA,NA,NA,NA,100723,
                                NA,NA,NA,776656,775558,NA,NA,700689))

v <- unique(c(data[,1], data[,2])) #Define v from both columns in data
v <- na.omit(v)
e <- na.omit(data)

g<-graph.data.frame(e, vertices = v, directed = T)
plot(g)
