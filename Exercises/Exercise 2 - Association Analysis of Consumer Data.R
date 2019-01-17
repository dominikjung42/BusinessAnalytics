# Exercise 2 - Association Analysis of Consumer Data
# Contact: Dominik Jung, d.jung@kit.edu

library(arules)
library(arulesViz)

# Example of an association rule


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











