# 5 Business Data Analytics

library(rpart)
fit = rpart(formula = mpg ~ ., data = mtcars, parms = list(split = "information"))
summary(fit)

