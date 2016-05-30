#set the working directory to UCI HAR Dataset folder
install.packages(c("data.table", "dplyr"))
library(data.table)
library(dplyr)

#1. Merges the training and the test sets to create one dataset.

#read features and activities
featureVector <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt", header = FALSE)

#read subject files of both datasets
subjectTrain <- read.table("train/subject_train.txt", header = FALSE)
subjectTest <- read.table("test/subject_test.txt", header = FALSE)

#read activity files of both datasets

activityTrain <- read.table("train/y_train.txt", header = FALSE)
activityTest <- read.table("test/y_test.txt", header = FALSE)

#read features filess of both datasets
featuresTrain <- read.table("train/X_train.txt", header = FALSE)
featuresTest <- read.table("test/X_test.txt", header = FALSE)

#binding training and test data row wise
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Naming the columns  
names(subject) <- c("subject")
names(activity) <- c("activity") 
names(features) <- featureVector$V2 

#binding the coloumns 
mergedData <- cbind(features,activity,subject)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

#columns with mean and std
MeanStdCols<- grep(".*Mean.*|.*Std.*", names(mergedData), ignore.case=TRUE)

# activity and subject added
AddedCols <- c(MeanStdCols, 562, 563) 

combinedData<- mergedData[,AddedCols]

dim(combinedData)

#3. Uses descriptive activity names to name the activities in the dataset

#change activity type from numeric to char

combinedData$activity <- as.character(combinedData$activity)

#activity names taken from activity labels file

for (i in 1:6){combinedData$activity[combinedData$activity == i] <- as.character(activityLabels[i,2])}

#factorize activity variable
combinedData$activity <- as.factor(combinedData$activity)

# 4.  Appropriately labels the data set with descriptive variable names.
#before edit
names(combinedData)

#edit names
names(combinedData)<-gsub("Acc", "Accelerometer", names(combinedData))
names(combinedData)<-gsub("Gyro", "Gyroscope", names(combinedData))
names(combinedData)<-gsub("BodyBody", "Body", names(combinedData))
names(combinedData)<-gsub("Mag", "Magnitude", names(combinedData))
names(combinedData)<-gsub("^t", "Time", names(combinedData))
names(combinedData)<-gsub("^f", "Frequency", names(combinedData))
names(combinedData)<-gsub("tBody", "TimeBody", names(combinedData))
names(combinedData)<-gsub("-mean()", "Mean", names(combinedData), ignore.case = TRUE)
names(combinedData)<-gsub("-std()", "STD", names(combinedData), ignore.case = TRUE)
names(combinedData)<-gsub("-freq()", "Frequency", names(combinedData), ignore.case = TRUE)
names(combinedData)<-gsub("angle", "Angle", names(combinedData))
names(combinedData)<-gsub("gravity", "Gravity", names(combinedData))

#after edit
names(combinedData)

#5.From the dataset in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#tidy dataset with average of each subject and activtiy variable
tidyData <- aggregate(. ~subject + activity, combinedData, mean)

#sorted according to subject and activity
tidyData <- tidyData[order(tidyData$subject,tidyData$activity),]

#output the dataset
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
