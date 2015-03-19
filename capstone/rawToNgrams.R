source("./funcTA.R")
source("./funcMe.R")

# twitter: 2,360,000 lines (approx)
# blog:
# news:

con <- file("rawdata/en_US.twitter.txt", "r")
raw <- readLines(con, 1000)
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

g1.df <- as.data.frame(table(g1), stringsAsFactors=FALSE)
g2.df <- as.data.frame(table(g2), stringsAsFactors=FALSE)
g3.df <- as.data.frame(table(g3), stringsAsFactors=FALSE)

colnames(g1.df) <- c("Ngram", "Freq")
colnames(g2.df) <- c("Ngram", "Freq")
colnames(g3.df) <- c("Ngram", "Freq")

g1.df.sort <- g1.df[with(g1.df, order(-Freq)),]
g2.df.sort <- g2.df[with(g2.df, order(-Freq)),]
g3.df.sort <- g3.df[with(g3.df, order(-Freq)),]
