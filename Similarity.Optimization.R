setwd("/Volumes/Diascia.Genomics/SA.Data/Practice.Run/Assembly.Test/Trimmed.Reads/Ref.Opt/")

library(ggplot2)

data.table <- read.table("kopt.data", header = FALSE, col.names= c("k1","k2","Similarity", "Contigs"))

data.table$K1K2 <- paste(data.table$k1, data.table$k2, sep=",")

df=data.frame(data.table)
df$K1K2 <- as.factor(df$K1K2)

p <- ggplot(df, aes(x=Similarity, y=Contigs, group=K1K2)) + scale_x_continuous(breaks=seq(0.8,0.98,0.01)) + geom_line(aes(colour = K1K2))
p
