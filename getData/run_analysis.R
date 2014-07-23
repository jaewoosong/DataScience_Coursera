# Getting and Cleaning Data - Course Project

# A function for downloading the data
funDown <- function() {
    if(!file.exists("./data")) { dir.create("./data") }
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    localFile = "./data/getdata_proj.zip"
    if(!file.exists(localFile))
    {
        download.file(fileUrl, destfile=localFile)
        unzip(localFile, exdir="./data")    
    }
}

funDown()
