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