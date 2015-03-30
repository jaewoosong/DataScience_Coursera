# Quiz 1: Getting Started

# Question 1
# The en_US.blogs.txt file is how many megabytes?
## Just look for the windows explorer: 210,160,014 bytes (200 MB)

# Question 2
# The en_US.twitter.txt has how many lines of text?
## Just open the file in Vim: 2,360,148 lines (2 million)

# Question 3
# What is the length of the longest line
# seen in any of the three en_US data sets?
## blogs, 483,415th line (40833 characters)
con <- file("rawdata/en_US.twitter.txt", "rb")
twitter <- readLines(con, encoding="UTF-8")
close(con)

con <- file("rawdata/en_US.blogs.txt", "rb")
blogs <- readLines(con, encoding="UTF-8")
close(con)

con <- file("rawdata/en_US.news.txt", "rb")
news <- readLines(con, encoding="UTF-8")
news <- iconv(news,"WINDOWS-1252","ASCII", sub="")
close(con)

max.twitter <- 0
max.twitter.index <- 0
i <- 0
for(oneLine in twitter) {
  i <- i+1
  if(nchar(oneLine) > max.twitter) {
    max.twitter <- nchar(oneLine)
    max.twitter.index <- i
  }  
}
max.twitter
max.twitter.index

max.blogs <- 0
max.blogs.index <- 0
i <- 0
for(oneLine in blogs) {
  i <- i+1
  if(nchar(oneLine) > max.blogs) {
    max.blogs <- nchar(oneLine)
    max.blogs.index <- i
  }  
}
max.blogs
max.blogs.index

max.news <- 0
max.news.index <- 0
i <- 0
for(oneLine in news) {
  i <- i+1
  if(nchar(oneLine) > max.news) {
    max.news <- nchar(oneLine)
    max.news.index <- i
  }  
}
max.news
max.news.index

# Question 4
# In the en_US twitter data set, if you divide
# the number of lines where the word "love"
# (all lowercase) occurs by the number of lines
# the word "hate" (all lowercase) occurs,
# about what do you get?
## 90956 / 22138 = 4.108592

twitter.love <- 0
twitter.hate <- 0
for(oneLine in twitter) {
  if(grepl("love", oneLine)) {
    twitter.love <- twitter.love + 1
  }
  if(grepl("hate", oneLine)) {
    twitter.hate <- twitter.hate + 1
  }
}

print(twitter.love)
print(twitter.hate)

# Question 5
# The one tweet in the en_US twitter data set
# that matches the word "biostats" says what?
## "i know how you feel.. i have biostats on
## tuesday and i have yet to study =/"
for(oneLine in twitter) {
  if(grepl("biostats", oneLine)) { print(oneLine) }
}

# Question 6
# How many tweets have the exact characters
# "A computer once beat me at chess,
# but it was no match for me at kickboxing".
# (I.e. the line matches those characters exactly.)
## 3 times
for(oneLine in twitter) {
  if(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", oneLine)) {
    print(oneLine)
  }
}
