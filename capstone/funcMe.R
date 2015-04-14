#' Ngram predictor (written by Jaewoo)
#' @param inputStr An n-1gram string
#' @param model An ngram dictionary with frequencies
#' @return A predicted ngram string
ngram_pred <- function(inputStr, model) {
  # collect ngrams which start with inputStr
  # apply(g2sort, 2, function(x) x[grepl("^of ", x)])
  model.sub <- subset(model, grepl(paste("^", inputStr, sep=""), Ngram))
  if(is.na(model.sub[1,1])) { inputStr }
  else { model.sub[1,1] }
}

#' Smooth function for Good-Turing (written by Jaewoo)
#' @param freqFreq frequency of frequencies vector
#' @param r target single species was seen r times
#' @return smoothed(adjuested) value of the frequency
smth <- function(freqFreq, r) {
  Nr <- sum(freqFreq == r)
}

#' Good-Turing frequency estimator (written by Jaewoo)
#' @param freq The frequency vector
#' @return prFunc Function that calculates p_r
gt <- function(freq) {
  # frequency of frequencies vector
  maxFreq <- max(freq)
  freqTable <- table(freq)
  freqFreq <- c()
  for(i in 1:maxFreq) {
    if(i %in% names(freqTable)) {
      freqFreq[i] <- as.vector(freqTable[names(freqTable) == i])
    }
    else { freqFreq[i] <- 0 }    
  }
  
  N <- sum(freq)
  N1 <- sum(freqFreq == 1)
  p0 <- N1 / N
  
  function(r) {
    # p0: an estimate of the total probability of unseen species
    if(r == 0) { p0 }
    
    Nr <- sum(freqFreq == r)
    Nr1 <- sum(freqFreq == r+1)
    pr <- ((r+1) * smth(Nr1)) / (N * smth(Nr))
    
    # pr: an estimate of probability for species
    #     which were seen r times, for a single species
    pr
  }
}

basicSummary1 <- function(x) {
  fileName <- 'temp.txt'
  if(x == 'blogs') { fileName <- 'en_US.blogs.txt'}
  else if(x == 'news') { fileName <- 'en_US.news.txt'}
  else if(x == 'twitter') { fileName <- 'en_US.twitter.txt'}
  else {
    stop('Wrong option!')
  }
  
  con <- file(paste0("rawdata/", fileName), "rb")
  raw <- readLines(con)
  raw <- iconv(raw,"WINDOWS-1252","ASCII", sub="")
  close(con)
  
  clean <- gsub("[^[:alnum:][:space:]']", " ", tolower(raw))
  clean <- gsub("[[:space:]]+", " ", clean)
  wordCount <- 0
  
  for(i in c(1:length(clean))) {
    wordCount <- wordCount + length(strsplit(clean[i], split=" ")[[1]])
  }
  
  #unigram <- (ngram_tokenizer(n=1))(clean)
  #unigram.df <- as.data.frame(table(unigram), stringsAsFactors=FALSE)
  #colnames(unigram.df) <- c("Unigram", "Freq")
  #unigram.df.sort <- unigram.df[with(unigram.df, order(-Freq)),]
  
  cat(paste0('\n', x, '\n'))
  cat(paste0('Number of lines: ', length(raw), '\n'))
  cat(paste0('Number of words: ', wordCount, '\n'))
  #cat(paste0('Number of words: ', length(unigram), '\n'))
  #cat(paste0('Number of unique words: ', nrow(unigram.df), '\n'))
  #unigram.df.sort
  clean
}

quiz2 <- function(x) {
  cat(length(grep(x, cleaned.blogs)))
  cat("\n")
  cat(length(grep(x, cleaned.news)))
  cat("\n")
  cat(length(grep(x, cleaned.twitter)))
  cat("\n")
}
