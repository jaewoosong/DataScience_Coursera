library(stringi)
source("./func.R")

# twitter: 2,360,000 lines (approx)
# blog:
# news:

con <- file("rawdata/en_US.twitter.txt", "r")
raw <- readLines(con, 100000)
# 10000 approx. 1 minute
# 100000 approx. 6 minutes
raw <- iconv(raw,"WINDOWS-1252","ASCII", sub="")
close(con)

raw2 <- gsub("[^[:alnum:][:space:]']", " ", tolower(raw))
clean <- gsub("[[:space:]]+", " ", raw2)

gram1func <- ngram_tokenizer(n=1)
gram2func <- ngram_tokenizer(n=2)
gram3func <- ngram_tokenizer(n=3)

g1 <- gram1func(clean)
g2 <- gram2func(clean)
g3 <- gram3func(clean)

g1df <- as.data.frame(table(g1))
g2df <- as.data.frame(table(g2))
g3df <- as.data.frame(table(g3))

g1sort <- g1df[with(g1df, order(-Freq)),]
g2sort <- g2df[with(g2df, order(-Freq)),]
g3sort <- g3df[with(g3df, order(-Freq)),]
