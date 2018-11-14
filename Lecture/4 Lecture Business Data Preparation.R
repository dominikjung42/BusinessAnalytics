# 4 Business Data Preparation

# Example application of a pca
fitPCA = prcomp(mtcars[,c(1:7)], center = TRUE, scale. = TRUE)
summary(fitPCA)

# classroom task, data handling with plyr
tasting = data.frame(
  Whisky=rep(c("Ardbeg", "Laphroaig", "Connemara", "Bunnahabhain")),
  Taster=rep(c("Dominik", "Rick"), each = 4),
  Rating=c(3, 1, 2, 3, 1, 3, 3, 1),
  Consume=c(45, 10, 31, 32, 20, 28, 38, 21))

# split
pieces = split(tasting, tasting$Taster)
# apply
pieces.transformed = vector("list", length(pieces)) # declare a temporary list
for(i in 1:length(pieces)){ #iterate over the two sets male and female
  piece = pieces[[i]]
  piece = transform(piece, rank = rank(piece$Consume, ties.method = "first"))
  pieces.transformed[[i]] = piece
}
# combine
pieces.preprocessed = do.call("rbind", pieces.transformed)

# with plyr
pieces.preprocessed2 = plyr::ddply(tasting, "Taster", transform, rank = rank(piece$Consume))


# tidyverse
library("tidyverse")
filter(tasting, Rating==3)

filter(tasting, Rating>=2 & Taster == "Dominik")

filter(tasting, Rating==1|3)

arrange(tasting, Rating)

select(tasting, Taster, Rating)

mutate(tasting, consume_in_L = Consume/100)

summarize(tasting, baseline = mean(Rating))

dataset = select(tasting, Taster, Rating)
dataset = group_by(dataset, Taster)
summarize(dataset, Average = mean(Rating))


sample = tasting %>% 
  select(Taster, Rating) %>%
  group_by(Taster) %>% 
  summarize(Average = mean(Rating))


