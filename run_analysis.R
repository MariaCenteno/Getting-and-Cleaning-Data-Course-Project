# Introduction

## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
## The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers 
## on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data 
## set as described below, 2) a link to a Github repository with your script for performing the analysis, 
## and 3) a code book that describes the variables, the data, and any transformations or work that you 
## performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with 
## your scripts. This repo explains how all of the scripts work and how they are connected.

## One of the most exciting areas in all of data science right now is wearable computing - see for example 
## this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced 
## algorithms to attract new users. The data linked to from the course website represent data collected from
## the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site 
## where the data was obtained:

## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Here are the data for the project:

## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following:

## Download and unzip the dataset
URL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, destfile = "data.zip", method = "auto")
unzip(zipfile="data.zip")
pathFile = file.path("./UCI HAR Dataset")

## Read the Test files (Subject - Features - Activity)
subjectTestData = read.table(file.path(pathFile, "test" , "subject_test.txt"),header = FALSE)
activityTestData  = read.table(file.path(pathFile, "test" , "Y_test.txt" ),header = FALSE)
featuresTestData = read.table(file.path(pathFile, "test" , "X_test.txt" ),header = FALSE)

## Read the Train files (Subject - Features - Activity)
subjectTrainData = read.table(file.path(pathFile, "train", "subject_train.txt"),header = FALSE)
activityTrainData = read.table(file.path(pathFile, "train", "Y_train.txt"),header = FALSE)
featuresTrainData = read.table(file.path(pathFile, "train", "X_train.txt"),header = FALSE)

# I. Merges the training and the test sets to create one data set

## i. Concatenate the data tables by rows (Test - Train)  
subject = rbind(subjectTestData, subjectTrainData)
activity = rbind(activityTestData, activityTrainData)
features = rbind(featuresTestData, featuresTrainData)

## ii. Remane the variables in the data tables
names(subject) = c("subject")
names(activity) =  c("activity")
featuresNames  =  read.table(file.path("./UCI HAR Dataset", "features.txt"),head=FALSE)
names(features) =  featuresNames$V2

## iii. Create one final Data Set
dataSet  =  cbind(subject, activity, features)

# II. Extracts only the measurements on the mean and standard deviation for each measurement

## i. Extract the column indices that have either the suffix mean or std in them and
## subset the featuresNames table with that information
subColumnNames = grep(".*Mean.*|.*Std.*", names(dataSet), ignore.case=TRUE)
subColumnNames = c(as.character(subColumnNames),1,2)
data = subset(dataSet,select=subColumnNames)

# III. Uses descriptive activity names to name the activities in the data set

## i. Read the labels from the activity_labels.txt file 
activityLabels=read.table(file.path("./UCI HAR Dataset","activity_labels.txt"),header = FALSE)

## ii. Change the numeric values in the activity variable for the name of the activities
data$activity=as.character(data$activity)
for (i in 1:6){
  data$activity[data$activity == i] = as.character(activityLabels[i,2])
}
data$activity=as.factor(data$activity)

# IV. Appropriately labels the data set with descriptive variable names

## i. Rename the variables with the respective word according to its prefix
names(data) = gsub("^t", "time", names(data))
names(data) = gsub("Acc", "Accelerometer", names(data))
names(data) = gsub("-mean()", "Mean", names(data), ignore.case = TRUE)
names(data) = gsub("-std()", "STD", names(data), ignore.case = TRUE)
names(data) = gsub("Gyro", "Gyroscope", names(data))
names(data) = gsub("Mag", "Magnitude", names(data))
names(data) = gsub("gravity", "Gravity", names(data))
names(data) = gsub("^f", "frequency", names(data))
names(data) = gsub("-freq()", "Frequency", names(data), ignore.case = TRUE)
names(data) = gsub("BodyBody", "Body", names(data))
names(data) = gsub("tBody", "TimeBody", names(data))
names(data) = gsub("angle", "Angle", names(data))

# V. From the data set in step 4, creates a second, independent tidy data set with the average  
# of each variable for each activity and each subject

# i. Calculate the average of each variable and create an independent data set
install.packages("data.table")
library(data.table)       
data$subject=as.numeric(data$subject)
data=data.table(data)

install.packages("plyr")
library(plyr)
tidyDataSet = aggregate(. ~subject + activity, data, mean)
tidyDataSet = tidyDataSet[order(tidyDataSet$subject,tidyDataSet$activity),]
write.table(tidyDataSet, file = "tidydata.txt",row.name=FALSE)
