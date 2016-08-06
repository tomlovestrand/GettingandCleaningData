## run_analysis script for final project of Getting and Cleaning Data
##

## Load libraries
library(plyr)

## Read TEST Subjects, Data and Activity
testSubject<-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testData<-read.table("./data/UCI HAR Dataset/test/X_test.txt")
testActivity<-read.table("./data/UCI HAR Dataset/test/y_test.txt")

## Read TRAINING Subject, Data and Activity
trainSubject<-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainData<-read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainActivity<-read.table("./data/UCI HAR Dataset/train/y_train.txt")

## Read FEATURES and ACTIVITY LABELS
features<-read.table("./data/UCI HAR Dataset/features.txt")
activityLabels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")


## 1. Merge the Training and Test data sets to create one data set
allSubject<-rbind(trainSubject, testSubject)
allActivity<-rbind(trainActivity, testActivity)
allData<-rbind(trainData, testData)

## Set the Column names for the data sets
colnames(allSubject)<-"SubjectNo."
colnames(allActivity)<-"Activity"
colnames(allData)<-features[[2]]


## Merge all data sets and create 
fullDataMerge<-cbind(allSubject, allActivity, allData)

## 2. Extract only the measurements on the mean and standard deviation for each measurement
columnIndex<-c(1,2,(grep(".*mean*.|.*std*.", names(fullDataMerge), ignore.case=TRUE, value=FALSE)))
subsetData<-fullDataMerge[columnIndex]

## 3. Use descriptive activity names to name the activities in the data set
subsetData[,2]<-as.character(subsetData[,2])
activityLabels[,2]<-as.character(activityLabels[,2])
subsetData[,2]<-mapvalues(subsetData[,2], from = c("1","2","3","4","5","6"), to=activityLabels$V2)

## 4. Appropriately label the data set with descriptive activity names
names(subsetData)<-gsub("\\(\\)-X", "(X)", names(subsetData))
names(subsetData)<-gsub("\\(\\)-Z", "(Z)", names(subsetData))
names(subsetData)<-gsub("\\(\\)-Y", "(Y)", names(subsetData))
names(subsetData)<-gsub("std", "StDev", names(subsetData))
names(subsetData)<-gsub("mean", "Mean", names(subsetData))
names(subsetData)<-gsub("^t", "TD-", names(subsetData))
names(subsetData)<-gsub("^f", "FD-", names(subsetData))
names(subsetData)<-gsub("\\(\\)", "", names(subsetData))


## 5. Create a 2nd independent tidy data set with the average of each variable for each activity and each subject.
meansBySubjectActivity<-aggregate(subsetData[3:88], by=list(Subject=subsetData[,1], Activity=subsetData[,2]), FUN=mean)
write.table(meansBySubjectActivity, "./data/UCI HAR Dataset/meansBySubjectActivity.csv", row.names=FALSE )
