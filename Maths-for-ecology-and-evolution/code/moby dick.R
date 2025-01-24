

#moby <- read.csv('../data/words_moby_dick.csv')

#ordered_wordlabel <- moby[order(moby$word_label), ]


moby <- read.csv('../data/ordered_moby.csv')

log_worldlabel <- log(moby$word_label)
log_occurances <- log(moby$occurences)

plot(log_worldlabel, log_occurances)

model <- lm(log_occurances ~ log_worldlabel)

summary(model)

abline(model, col = "red")


