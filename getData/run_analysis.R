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

# Read the features
features <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
features <- features[,2]

# Read the training data set
trainSet <- read.table("./data/UCI HAR Dataset/train/X_train.txt", stringsAsFactors=FALSE)
names(trainSet) <- features

# Read the test data set
testSet <- read.table("./data/UCI HAR Dataset/test/X_test.txt", stringsAsFactors=FALSE)
names(testSet) <- features

## Now the first step:
## "Merges the training and the test sets to create one data set."
totalSet <- rbind(trainSet, testSet)

# Select mean() and std() only
index <- grep("mean\\(\\)|std\\(\\)", features)

## Now the second step:
## "Extracts only the measurements on the mean and standard deviation for each measurement."
meanStdSet <- totalSet[,index]

# Read the labels
activityLabel <- read.table("./data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
trainLabel <- read.table("./data/UCI HAR Dataset/train/y_train.txt", stringsAsFactors=FALSE)
testLabel <- read.table("./data/UCI HAR Dataset/test/y_test.txt", stringsAsFactors=FALSE)

names(trainLabel) <- c("Activity")
names(testLabel) <- c("Activity")

trainLabel$Activity <- activityLabel[trainLabel[,1],2]
testLabel$Activity <- activityLabel[testLabel[,1],2]
fullLabel <- c(trainLabel$Activity, testLabel$Activity)

## Now the third step:
## "Uses descriptive activity names to name the activities in the data set."
meanStdSet <- cbind(Activity=fullLabel, meanStdSet, stringsAsFactors=FALSE)

## Now the fourth step:
## "Appropriately labels the data set with descriptive variable names."

# Change variable names into more meaningful ones.
# e.g.) "tGravityAcc-mean()-X" becomes
#       "timeGravityAccelerometerMeanXaxis"
names(meanStdSet) <- gsub("^t", "time", names(meanStdSet))
names(meanStdSet) <- gsub("^f", "frequency", names(meanStdSet))
names(meanStdSet) <- gsub("Acc", "Accelerometer", names(meanStdSet))
names(meanStdSet) <- gsub("Gyro", "Gyroscope", names(meanStdSet))
names(meanStdSet) <- gsub("Mag", "Magnitude", names(meanStdSet))
names(meanStdSet) <- gsub("-mean\\(\\)", "Mean", names(meanStdSet))
names(meanStdSet) <- gsub("-std\\(\\)", "StandardDeviation", names(meanStdSet))
names(meanStdSet) <- gsub("-X", "Xaxis", names(meanStdSet))
names(meanStdSet) <- gsub("-Y", "Yaxis", names(meanStdSet))
names(meanStdSet) <- gsub("-Z", "Zaxis", names(meanStdSet))

# Read subject data
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", stringsAsFactors=FALSE)
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", stringsAsFactors=FALSE)
names(trainSubject) <- c("SubjectID")
names(testSubject) <- c("SubjectID")

fullSubject <- c(trainSubject$SubjectID, testSubject$SubjectID)

# Make an independent data set with subject data
tidySet <- cbind(SubjectID=fullSubject, meanStdSet, stringsAsFactors=FALSE)

## Now the fifth (the last!) step:
## "Creates a second, independent tidy data set with the average of each variable for each activity and each subject."
tidySet <- aggregate(.~SubjectID+Activity, data=tidySet, FUN=mean)
tidySet <- tidySet[with(tidySet, order(SubjectID, Activity)),]
row.names(tidySet) <- NULL

## Now save the result to a csv file.
write.table(tidySet, file="tidySet.csv", sep=",", row.names=FALSE)

## NOW EVERYTHING IS DONE!!

