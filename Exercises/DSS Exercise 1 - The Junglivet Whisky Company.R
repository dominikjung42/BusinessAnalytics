# Exercise 3
# Topic: Identifying Consumer and Product Groups
# Please use the google styleguide for your code
# https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
# Contact: Dominik Jung, d.jung@kit.edu


map = qmap(location = "Karlsruhe Institut of Technology (KIT)", zoom = 14, source="osm")

geocode("Schloss, Karlsruhe")
castle = data.frame(lon=8.404435, lat=49.01351, name="castle")
map + geom_point(data = castle,
                 aes(x = lon,
                     y = lat))


# in the first step, we read in the data and do some prepocessing
whiskies <- read.csv("whiskies.csv", row.names = 1, stringsAsFactors = FALSE)

library("ggplot2")
ggplot(whiskies, aes(Body)) + 
  geom_bar()

ggplot(whiskies, aes(Smoky)) + 
  geom_bar()

sum(is.na(whiskies))  # no missing observations

whiskies_k <- scale(whiskies[2:13])  # rescale for kmeans

# kmeans(data, centers = i)

# let us find a good parameter for k means… 
ssplot <- function(data, maxCluster = 9) {
  SSw <- vector()
  for (i in 2:maxCluster) {
    SSw[i] <- sum(kmeans(data, centers = i)$withinss)
  }
  plot(1:maxCluster, SSw, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
}
ssplot(whiskies_k)  # Plot the sum of squares

# Anhand der Grafik für folgenden fit entscheiden
fit = kmeans(whiskies_k, 4)  # 5 cluster solution 

#######################################################################################################
# Exkurs
# Instead of the graphical solution you can also use information criterias to find suitable parameters
 kmeansAIC = function(fit){
  m = ncol(fit$centers)
  n = length(fit$cluster)
  k = nrow(fit$centers)
  D = fit$tot.withinss
  return(data.frame(AIC = D + 2*m*k,
                    BIC = D + log(n)*m*k))
}
kmeansAIC(fit)

icplot <- function(data, maxCluster = 9) {
  parameters <- data.frame()
  for (i in 2:maxCluster) {
    parameters = rbind(parameters, kmeansAIC((kmeans(whiskies_k,i))))
  }
  library(ggplot2)
  ggplot() + 
    geom_line(data = parameters, aes(x = seq(2:9)+1, y = AIC, color = "AIC")) +
    geom_line(data = parameters, aes(x = seq(2:9)+1, y = BIC, color = "BIC")) +
    labs(color="Information Criterions")
}
icplot(whiskies_k)  # Plot the sum of squares


#######################################################################################################

# append cluster assignment
whiskies <- data.frame(whiskies, fit$cluster)
whiskies$fit.cluster <- as.factor(whiskies$fit.cluster)


# Cluster centers can inform on how taste profiles differ between clusters.
fit$centers

# Show best cluster for bodied and smoky whisky
taste.centers = as.data.frame(fit$centers)
ggplot(taste.centers , aes(x = Body, y = Smoky, label=rownames(taste.centers))) +
  geom_point() +
  geom_label(size=10)

# now we have identified the best cluster for our taste
subset(whiskies, fit.cluster == 3)[,1:13]

# and we can find the most representative whisky for each cluster
whiskies_r <- whiskies[c(2:13, 17)]
candidates <- by(whiskies_r[-13], whiskies_r[13], function(data){
  dists <- sapply(data, function(x) (x - mean(x))^2)
  dists <- rowSums(dists)
  rownames(data)[dists == min(dists)]
})
candidates <- as.numeric(unlist(candidates))
whiskies[candidates, ]

library("ggmap")
# now we plot them on the map of scotland
whiskyMap <- qmap(location = "Scotland",
                  zoom = 6,
                  legend = "topleft",
                  maptype = "terrain",
                  color = "bw", 
                  darken = 0.5)

whiskyMap + geom_point(data = whiskies,
                       aes(x = lon,
                           y = lat,
                           colour = fit.cluster,
                           size = 3))


#####################################################################


library(arules)
library(arulesViz)

# Load the data
shopping.data = read.transactions("scottish-supermarket.csv", format = "basket", sep=",", skip = 1)


# Create an item frequency plot for the top 20 items
itemFrequencyPlot(shopping.data,topN=20,type="absolute")
summary(shopping.data)

shopping.data = read.transactions("scottish-supermarket.csv", format = "basket", sep=",", rm.duplicates = FALSE, skip = 1)


rules<-apriori(data=shopping.data, parameter=list(supp=0.001,conf = 0.001), 
               appearance = list(default="lhs",rhs="whisky"),
               control = list(verbose=F))
rules<-sort(rules, decreasing=TRUE,by="confidence")
inspect(rules)

plot(rules[1:5])

plot(rules[1:5], interactive=TRUE, shading=NA)
plot(rules[1:5], method="graph", control=list(type="itemsets"))











