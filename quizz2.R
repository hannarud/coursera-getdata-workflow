setwd("/home/hannarud/Documents/GettingAndCleaningData/coursera-getdata-workflow/")

# Quiestion 1 is skipped

if (!file.exists("data")) {
  dir.create("data")
}

# Question 2
quizz2q2dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(quizz2q2dataURL, destfile = "./data/quizz2q2data.csv",
              method = "curl")
quizz2q2dateDownloaded <- date()

# Basic SQL knowledge makes no sense of diong questions 2 and 3

#Question 4
quizz2q4dataURL <- "http://biostat.jhsph.edu/~jleek/contact.html"
download.file(quizz2q4dataURL, destfile = "./data/quizz2q4data.html",
              method = "curl")
quizz2q4dateDownloaded <- date()

quizz2q4data <- readLines(con = "./data/quizz2q4data.html", n = 100)
nchar(quizz2q4data[10])
nchar(quizz2q4data[20])
nchar(quizz2q4data[30])
nchar(quizz2q4data[100])

#Question 5
quizz2q5data <- read.fwf(file = "./data/quizz2q5data.for", widths = c(15, 5, 8, 4, 30), skip = 4)
head(quizz2q5data)
sum(quizz2q5data$V4)
