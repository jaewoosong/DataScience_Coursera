library(stringi)
source("./func.R")

con <- file("rawdata_2014/en_US.twitter.txt", "r")
x0 <- readLines(con, 5)
close(con)

x1 <- tolower(x0)
x2 <- gsub("[^[:alnum:][:space:]']", " ", x1)
x3 <- gsub("( )+", " ", x2)
# x4 <- strsplit(x3, " ")

gram1 <- ngram_tokenizer(n=1)
gram2 <- ngram_tokenizer(n=2)
gram3 <- ngram_tokenizer(n=3)

g1 <- gram1(x3[1])
g2 <- gram2(x3[1])
g3 <- gram3(x3[1])

table(g1)
table(g2)
table(g3)
