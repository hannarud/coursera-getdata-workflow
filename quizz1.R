setwd("/home/hannarud/Documents/GettingAndCleaningData/coursera-getdata-workflow/")

if (!file.exists("data")) {
    dir.create("data")
}

quizz1q1dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(quizz1q1dataURL, destfile = "./data/quizz1q1data.csv",
              method = "curl")
quizz1q1dateDownloaded <- date()

print(list.files())

