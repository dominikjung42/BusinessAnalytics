# 3 Business Data Understanding

# Visualisations
library(ggplot2)
tasting = data.frame(
  Whisky=rep(c("Ardbeg", "Laphroaig", "Connemara", "Bunnahabhain")),
  Taster=rep(c("Dominik", "Rick"), each = 4),
  Rating=c(3, 1, 2, 3, 1, 3, 3, 1),
  Consume=c(45, 10, 31, 32, 20, 28, 38, 21))

head(tasting)
tasting

# Simple Barplot ggplot2
ggplot(tasting, aes(x=Rating)) + geom_bar() + labs(title="Whisky Ratings")
#+ coord_flip()  # Horizontal bar plot

# Simple Barplot R-Base
counts = table(tasting$Rating)
barplot(counts, main="Whisky Tasting", xlab="Ratings")

# Stacked Barplot ggplot2
ggplot(data=tasting, aes(x=Whisky, y=Rating, fill=Taster)) +
  geom_bar(stat="identity")

# Grouped Barplot ggplot2
ggplot(data=tasting, aes(x=Whisky, y=Rating, fill=Taster)) +
  geom_bar(stat="identity", position=position_dodge())

# Boxplot ggplot2
ggplot(data=tasting, aes(x=Whisky, y=Rating)) + 
  geom_boxplot()

# Boxplot  R-Base
boxplot(Rating~Whisky,data=tasting)

# Boxplot Outlier example
example = data.frame(a = c(4,4.1,4.6,6,6.1,6.3,6.5,6.7,6.7,8,8.1,8.3,8.6,9,10,10.4,14), b=(1))
boxplot(a~b,data=example)
plot(example)

example = data.frame(a = c(12,4,4.1,4.6,6,6.1,6.3,6.5,6.7,6.7,8,8.1,8.3,8.6,9,10,10.4,14), b=(1))
boxplot(a~b,data=example)

example = data.frame(a = c(14,4,4.1,4.6,6,6.1,6.3,6.5,6.7,6.7,8,8.1,8.3,8.6,9,10,10.4,14), b=(1))
boxplot(a~b,data=example)

# Histogram ggplot2
ggplot(data=tasting, aes(x=Consume)) + 
  geom_histogram(binwidth = 10.0)

# Scatterplot ggplot2
ggplot(data=tasting, aes(y=Consume, x=Rating)) + 
  geom_point()

# Scatterplot with regression line ggplot2
ggplot(data=tasting, aes(y=Consume, x=Rating)) + 
  geom_point() + geom_smooth(method="loess", se=TRUE, fullrange=FALSE, level=0.95)

# Correlation matrix R-Basic
pairs(tasting)

# Correlation matrix GGally / ggplot2
library(GGally)
ggcorr(tasting)  # in this case not terribly useful

# Parallel Coordinates GGally / ggplot2
library(GGally)
ggparcoord(tasting) 

# Themes in ggplot2
ggplot(tasting, aes(x=Rating)) +
  geom_bar() +
  theme_bw()

ggplot(tasting, aes(x=Rating)) +
  geom_bar() +
  theme_classic()

ggplot(tasting, aes(x=Rating)) +
  geom_bar() +
theme_void()

# Facets in ggplot2
ggplot(tasting, aes(x=Rating)) +
  geom_bar() + facet_wrap( ~ Taster, ncol=2)

# Annotations in ggplot2
library(grid)
MyAnnotation = grobTree(textGrob("This text is written \n by Me et al.", x=.1,  y=.8, hjust=0,
                            gp=gpar(col="blue", fontsize=30, fontface="bold")))
ggplot(tasting, aes(x=Rating)) + geom_bar() + annotation_custom(MyAnnotation)



