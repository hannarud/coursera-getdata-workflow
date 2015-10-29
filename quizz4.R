setwd("/home/hannarud/Documents/GettingAndCleaningData/coursera-getdata-workflow/")

if (!file.exists("data")) {
    dir.create("data")
}

# Question 1
quizz4q1dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quizz4q1dataURL, destfile = "./data/quizz4q1data.csv",
              method = "curl")
quizz4q1dateDownloaded <- date()
quizz4q1codebookURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf"
download.file(quizz4q1codebookURL, destfile = "./data/quizz4q1codebook.pdf",
              method = "curl")

quizz4q1data <- read.csv("./data/quizz4q1data.csv", header = TRUE, sep = ",")
head(colnames(quizz4q1data))
length(colnames(quizz4q1data))

# Apply strsplit() to split all the names of the data frame on the characters "wgtp"
# What is the value of the 123 element of the resulting list?
splittednames <- strsplit(colnames(quizz4q1data), "wgtp")
print(splittednames[123])

# Question 2
quizz4q2dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(quizz4q2dataURL, destfile = "./data/quizz4q2data.csv",
              method = "curl")
quizz4q2dateDownloaded <- date()

quizz4q2data <- read.csv("./data/quizz4q2data_prepared.csv", header = TRUE, sep = ",")
head(colnames(quizz4q2data))

# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
head(quizz4q2data)

quizz4q2data$GDP <- sapply(quizz4q2data$GDP, function(x) {as.numeric(gsub(",", "", gsub(" ", "", as.character(x))))})
head(quizz4q2data$GDP)
class(quizz4q2data$GDP)

mean(quizz4q2data$GDP, na.rm = TRUE)

# Question 3
# Regular expression that would allow to count the number of countries whose name begins with "United"?
countryNames <- as.character(quizz4q2data$Economy)
head(countryNames)

united <- grep("^United",countryNames) # Acceptable grep("*United",countryNames)

# How many countries begin with United?
length(united)

# Question 4 is skipped

# Question 5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
head(sampleTimes)
tail(sampleTimes)

# How many values were collected in 2012?
sampletimesYears <- sapply(sampleTimes, function(x) { as.numeric(format(x, "%Y")) })
year2012 <- sampletimesYears == 2012
sum(year2012)

# How many values were collected on Mondays in 2012?
sampletimesWeekdays <- sapply(sampleTimes, function(x) { weekdays(x) })
mondays <- sampletimesWeekdays == "Панядзелак"

sum(year2012 & mondays)
