quiz3 <- function(quizStr, choices, n, corpus1, corpus2, corpus3) {
  ngram <- paste(tail(strsplit(quizStr, split=" ")[[1]], n-1), collapse=' ')
  ngram <- paste(ngram, choices)
  for(oneStr in ngram) {
    cat(oneStr, '\n')
    cat(paste0("In corpus 1: ", sum(grepl(oneStr, corpus1))), '\n')
    cat(paste0("In corpus 2: ", sum(grepl(oneStr, corpus2))), '\n')
    cat(paste0("In corpus 3: ", sum(grepl(oneStr, corpus3))), '\n')
    cat('\n')
  }
}

quizStr <- c("When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd",
             "Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his",
             "I'd give anything to see arctic monkeys this",
             "Talking to your mom has the same effect as a hug and helps reduce your",
             "When you were in Holland you were like 1 inch away from me but you hadn't time to take a",
             "I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the",
             "I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each",
             "Every inch of you is perfect from the bottom to the",
             "I'm thankful my childhood was filled with imagination and bruises from playing",
             "I like how the same people are in almost all of Adam Sandler's")
quizStr <- gsub("[^[:alnum:][:space:]']", " ", tolower(quizStr))
quizStr <- gsub("[[:space:]]+", " ", quizStr)

choices <-list(c("sleep", "die", "give", "eat"),
               c("horticultural", "spiritual", "financial", "marital"),
               c("morning", "decade", "weekend", "month"),
               c("hunger", "sleepiness", "stress", "happiness"),
               c("minute", "walk", "picture", "look"),
               c("case", "matter", "incident", "account"),
               c("hand", "finger", "arm", "toe"),
               c("center", "top", "middle", "side"),
               c("outside", "weekly", "inside", "daily"),
               c("movies", "stories", "pictures", "novels"))

#    3rd / 2nd / 1st / modification
# 1) . / die / give / "live and"
# 2) marital / financial / spiritual / "wife.+ tell.+" or wild guess
# 3) . / weekend / morning / "see.+ this"
# 4) . / . / stress / 3gram
# 5) picture / walk / look / "you.+ away from.+", 2nd most frequent // 5gram 2nd
# 6) . / matter / case / 3gram, 2nd most frequent
# 7) . / . / hand / 3gram
# 8) . / . / top / 3gram
# 9) . / . / outside / 3gram
#10) . / movies / stories / "adam sandler.+"