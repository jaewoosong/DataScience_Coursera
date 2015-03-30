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

# internal functions
# Zr estimation
nrzest <- function(r, nr) {
  d <- c(1, diff(r))
  # dr is all same as Wikipedia's definition.
  # It is assumed that r=1 exists.
  dr <- c(0.5 * (d[-1] + d[-length(d)]), d[length(d)])
  return(nr/dr)
}

# r-star estimation
rstest <- function(r, coef) {
  return(r * (1 + 1/r)^(1 + coef[2]))
}

#' Good-Turing Analyzer
#' @param rawData A data frame with freq.(r) and freq. of freq. (nr)
#' @return adsf
gtAnalysis <- function(rawData) {
  # read in data
  xr <- rawData$r
  xnr <- rawData$nr
  xN <- sum(xr*xnr)
  
  # make averaging transform: zr
  xnrz <- nrzest(xr, xnr)
  print(xr)
  print(xnrz)
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
  cat(xN,sum(xnr))
  cat(0,xnr[1]/xN)
  for(i in 1:length(xr)) {
    cat(xr[i],xr[i]*xrstcmbrel[i])
  }
}
