# 'Good-Turing Smoothing Without Tears'
# Written by William A. Gale (originally S code)
# Modified to be R code by Jaewoo
# 
# Input: Two items per line: frequency(r) and
#        non-zero frequencies of frequencies(Nr).
#
# Output: A first line containing the total number of objects(N),
#         and the total number of types seen.
#         The second line contains a zero and the TOTAL probability
#         of unseen objects.
#         The following lines contain the frequency(r),
#         and the SGT(r*).
#
# To get the probability for an object seen r>=1 times,
# divide r* by N


#' Calculates zr for Good-Turing frequency estimation.
#' Zr is defined as Z_r = N_r / (0.5(t-q))
#' and where q, r and t are consecutive subscripts having
#' N_q, N_r, N_t non-zero. When r is 1, take q to be 0.
#' When r is the last non-zero frequency, take t to be 2r - q.
#' @param r the frequency vector, r, has elements r_x
#' that give the number of individuals
#' that have been observed for species x.
#' @param nr the frequency of frequencies vector, nr,
#' shows how many times the frequency r occurs in the vector R;
#' i.e. among the elements R_x.
#' @return zr a revised quantity for nr
nrzest <- function(r, nr) {
  # According to wikipedia, Z_r = N_r / (0.5 * (t - q))
  # dr is 0.5 * (t - q)
  # It is assumed that r=1 (just one occurrence) exists.
  d <- c(1, diff(r))  
  dr <- c(0.5 * (d[-1] + d[-length(d)]), d[length(d)])
  return(nr/dr)
}

#' r-star estimation. p_r = r-star / N, where p_r is
#' the probability that we estimate for each of the
#' objects seen r times.
#' @param r frequency vector
#' @param coeff coefficients from lsfit function
#' @return r-star estimation
rstest <- function(r, coeff) {
  return(r * (1 + 1/r)^(1 + coeff[2]))
}

#' Good-Turing Analyzer.
#' Output to stdout has a first line containing
#' the total number of objects, N, and the total
#' number of types seen. The second line contains
#' a zero and the TOTAL probability of unseen objects.
#' The following lines contain the frequency r,
#' and the SGT r*.
#' @param rawData A data frame with freq.(r) and freq. of freq.(nr)
#' @return adsf
gtAnalysis <- function(rawData) {
  # read in data
  xr <- rawData$r
  xnr <- rawData$nr
  xN <- sum(xr*xnr)
  
  # make averaging transform: zr
  xnrz <- nrzest(xr, xnr)

  #get Linear Good-Turing estimate: r-star, r-star-relative
  xf <- lsfit(log(xr),log(xnrz))
  xcoef <- xf$coef
  xrst <- rstest(xr, xcoef)
  xrstrel <- xrst/xr
  
  # get Turing estimate
  xrtry <- xr == c(xr[-1]-1, 0)
  xrstarel <- rep(0,length(xr))
  xrstarel[xrtry] <- (xr[xrtry]+1)/xr[xrtry]*c(xnr[-1],0)[xrtry]/xnr[xrtry]
  
  # make switch from Turing to LGT estimates
  tursd <- rep(1,length(xr))
  for(i in 1:length(xr)) {
    if(xrtry[i]) {
      tursd[i]<-(i+1)/xnr[i]*sqrt(xnr[i+1]*(1+xnr[i+1]/xnr[i]))
    }
  }
  xrstcmbrel <- rep(0,length(xr))
  useturing <- TRUE
  for(r in 1:length(xr)) {
    if(!useturing) {
      xrstcmbrel[r]<-xrstrel[r]
    }
    else if(abs(xrstrel-xrstarel)[r]*r/tursd[r] > 1.65) {
      xrstcmbrel[r]<-xrstarel[r]
    }
    else {
      useturing<-FALSE
      xrstcmbrel[r]<-xrstrel[r]
    }
  }
  
  # renormalize the probabilities for observed objects
  sumpraw <- sum(xrstcmbrel*xr*xnr/xN)
  xrstcmbrel <- xrstcmbrel*(1-xnr[1]/xN)/sumpraw
  
  # output
  #cat(xN,sum(xnr), "\n")
  #cat(0,xnr[1]/xN, "\n")
  #for(i in 1:length(xr)) {
  #  cat(xr[i], xr[i]*xrstcmbrel[i], "\n")
  #}
  frq <- c(0, xr)
  sgt.frq <- c(0, xr*xrstcmbrel)
  frq.frq <- c(0, xnr)  
  sgt.prob.each <- c(NA, xr*xrstcmbrel/xN)
  sgt.prob.total <- c(xnr[1]/xN, xnr*xr*xrstcmbrel/xN)
  output <- data.frame(frq, sgt.frq, frq.frq,
                       sgt.prob.each, sgt.prob.total)
  output
}

r <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
       12, 14, 15, 16, 17, 19, 20, 21, 23, 24,
       25, 26, 27, 28, 31, 32, 33, 34, 36, 41,
       43, 45, 46, 47, 50, 71, 84, 101, 105, 121,
       124, 146, 162, 193, 199, 224, 226, 254, 257, 339,
       421, 456, 481, 483, 1140, 1256, 1322, 1530, 2131, 2395,
       6925, 7846)

nr <- c(120, 40, 24, 13, 15, 5, 11, 2, 2, 1,
        3, 2, 1, 1, 3, 1, 3, 2, 3, 3,
        3, 2, 2, 1, 2, 2, 1, 2, 2, 3,
        1, 3, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1)

prosody <- data.frame(r, nr)
colnames(prosody) <- c("r", "nr")