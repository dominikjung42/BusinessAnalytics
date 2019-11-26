# 5 Business Data Analytics
# Contact: Dominik Jung, d.jung@kit.edu


library(rpart)
fit = rpart(formula = mpg ~ ., data = mtcars, parms = list(split = "information"))
summary(fit)

