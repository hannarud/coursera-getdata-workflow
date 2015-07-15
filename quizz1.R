setwd("/home/hannarud/Documents/GettingAndCleaningData/coursera-getdata-workflow/")

library(xlsx)
library(XML)
library(data.table)

if (!file.exists("data")) {
    dir.create("data")
}

quizz1q1dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quizz1q1dataURL, destfile = "./data/quizz1q1data.csv",
              method = "curl")
quizz1q1dateDownloaded <- date()

quizz1q1data <- read.csv("./data/quizz1q1data.csv", header = TRUE, sep = ",")
head(colnames(quizz1q1data))

print(head(quizz1q1data$VAL))

# Property that cost $1000000 or mor (>= 24 in query)
sum(quizz1q1data$VAL >= 24, na.rm = TRUE)

quizz1q3dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
# original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program
download.file(quizz1q3dataURL, destfile = "./data/quizz1q3data.xlsx",
              method = "curl")
quizz1q3dateDownloaded <- date()

quizz1q3data <- read.xlsx(file = "./data/quizz1q3data.xlsx", sheetIndex = 1,
                          rowIndex = 18:23, colIndex = 7:15)
head(quizz1q3data)
print(sum(quizz1q3data$Zip*quizz1q3data$Ext,na.rm=T))

quizz1q4dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(quizz1q4dataURL, destfile = "./data/quizz1q4data.xml",
              method = "curl")
quizz1q4dateDownloaded <- date()

quizz1q4data <- xmlTreeParse("./data/quizz1q4data.xml", useInternalNodes = TRUE)
rootNode <- xmlRoot(quizz1q4data)
xmlName(rootNode)
names(rootNode)
print(rootNode[[1]])
print(rootNode[[1]][[1]])
print(rootNode[[1]][[1]][[2]][[1]])

print(head(xpathSApply(rootNode[[1]],"//zipcode",xmlValue)))
sum(xpathSApply(rootNode[[1]],"//zipcode",xmlValue) == "21231", na.rm = TRUE)

quizz1q5dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(quizz1q4dataURL, destfile = "./data/quizz1q5data.csv",
              method = "curl")
quizz1q5dateDownloaded <- date()

quizz1q5data <- fread("./data/quizz1q5data.csv")

# The fastest way to calculate the average value of the variable pwgtp15,
# broken down by sex using the data.table package
quizz1q5data[,mean(pwgtp15),by=SEX]
