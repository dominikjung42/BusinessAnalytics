# Exercise 2 - Association Analysis of Consumer Data
# Contact: Dominik Jung, d.jung@kit.edu

library(arules)
# Example of an association rule
data("Groceries")  # a popular dataset with shopping transactions
rules = apriori(Groceries, parameter = list(supp=0.001))
# itemFrequency(items(fit))  # use it to get percentage of items of the model
summary(rules)
inspect(rules)

# Example visualization of assoication rules
library(arulesViz)
plot(rules)
plot(rules[1:5], interactive=TRUE, shading=NA)
plot(rules[1:5], method="graph", control=list(type="itemsets"))
plot(rules[1:5], method="paracoord")
ruleExplorer(rules[1:5], parameter = NULL)

# Case
# Load the data
shoppingData = read.transactions("scottish-supermarket.csv", format = "basket", sep=",", skip = 1)

library(arulesViz)
# Create an item frequency plot for the top 20 items
itemFrequencyPlot(shoppingData,topN=20,type="absolute")
summary(shoppingData)

rules = apriori(data=shoppingData, parameter=list(supp=0.001,conf = 0.001), 
               appearance = list(rhs="whisky"),
               control = list(verbose=F))

rules = sort(rules, decreasing=TRUE,by="confidence")
inspect(rules)

plot(rules[1:5], interactive=TRUE, shading=NA)
plot(rules[1:5], method="graph", control=list(type="itemsets"))

ruleExplorer(rules[1:5], parameter = NULL)









