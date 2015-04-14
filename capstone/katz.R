#' Katz's back-off model probability
#' @param sentence a
#' @param ngramDB a
#' @param n n for ngram
#' @param k usually 0
#' @return
#' @examples
#' if "dad's guide to pregnacy is a good" is an input,
#' 1) 4-gram = "pregnancy is a good"
#' 2) w1 = pregnancy, w2 = is, w3 = a, w4 = good
#' 3) w5 = candidate words
#'    (ALL words? or appeared + some others? maybe from 2-grams)    
#' 4) to calculate P_bo(w5|w1~w4) for each w5,
#' 5) calculate C(w1, w2, w3, w4, w5)
#' 6) if C(w1~w5) > k, return d_(w1~w5) * C(w1~w5) / C(w1~w4)
#' 7) else, return alpha_(w1~w4) * P_bo(w5|w2~w4)
#' 8) return the candidates with the most probable first.
katz <- function(sentence, ngramDB, n=5, k=0) {
  sen.tail <- tail(strsplit(sentence,split=" ")[[1]], n-1)
  # candidates should be a data frame, with 'words' and 'prob' columns.
  candidates <- c("dummy", "vector", "now")
  for(oneWord in candidates) {
    frq.after <- frq(c(sen.tail, oneWord))
    if(frq.after > k) {
      frq.before <- frq(c(sen.tail))
      # add (d * frq.after / frq.before) to 'candidates' data frame
    }
    else {
      # add (alpha * katz(sentence, ngramDB, n=n-1, k=0))
      # to 'candidates' data frame
      # (ngramDB should be put outside, to make recursion lighter)
    }
  }
  # should return candidates data frame
  1  
}
