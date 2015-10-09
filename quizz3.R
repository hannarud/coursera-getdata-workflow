setwd("/home/hannarud/Documents/GettingAndCleaningData/coursera-getdata-workflow/")

if (!file.exists("data")) {
    dir.create("data")
}

# Question 1
quizz3q1dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quizz3q1dataURL, destfile = "./data/quizz3q1data.csv",
              method = "curl")
quizz3q1dateDownloaded <- date()

quizz3q1data <- read.csv("./data/quizz3q1data.csv", header = TRUE, sep = ",")
head(colnames(quizz3q1data))

print(head(quizz3q1data$ACR))

# House on ten or more acres (ACR == 3) who sold more than $10000 worth of agriculture products (AGS == 6)
agricultureLogical <- quizz3q1data$ACR == 3 & quizz3q1data$AGS == 6

head(which(agricultureLogical), 3)

# Question 2
library(jpeg)

quizz3q2dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(quizz3q2dataURL, destfile = "./data/quizz3q2data.jpg",
              method = "curl")
quizz3q2dateDownloaded <- date()

quizz3q2data <- readJPEG(source = "./data/quizz3q2data.jpg", native = TRUE)
quantile(quizz3q2data, c(0.30, 0.80))

# Question 3
quizz3q3data1url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
quizz3q3data2url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(quizz3q3data1url, destfile = "./data/quizz3q3data1.csv",
              method = "curl")
download.file(quizz3q3data2url, destfile = "./data/quizz3q3data2.csv",
              method = "curl")
quizz3q3data1dateDownloaded <- date()
quizz3q3data2dateDownloaded <- date()

# But we won't use this data, it's badly preprocessed. We'd better use hand-preprocessing to get better formatted table

quizz3q3data1 <- read.csv("./data/quizz3q3data1_worked.csv", header = TRUE, sep = ";", stringsAsFactors = FALSE)
head(colnames(quizz3q3data1))
head(quizz3q3data1)

quizz3q3data2 <- read.csv("./data/quizz3q3data2_worked.csv", header = TRUE, sep = ";")
head(colnames(quizz3q3data2))
head(quizz3q3data2)

mergedData <- merge(quizz3q3data1, quizz3q3data2, by.x = "Code", by.y = "Country.Code")
head(mergedData)
length(mergedData$Code)

mergedData <- mergedData[order(-mergedData[,4]),]

# Well, seems like we took more recent data, so
mergedData$Economy[14]

# Question 4
mean(mergedData[mergedData$Income.Group == "High income: OECD", ]$GDP2014)
mean(mergedData[mergedData$Income.Group == "High income: nonOECD", ]$GDP2014)

# Question 5
q <- quantile(mergedData$GDP2014, probs = c(0, 0.2, 0.4, 0.6, 0.8, 1))
mergedData$GDPQuanileGroup <- cut(mergedData$GDP2014, q, include.lowest=TRUE,
                    labels=paste("Group", 1:5))

table(mergedData$GDPQuanileGroup, mergedData$Income.Group)
