##You should create one R script called run_analysis.R that does the following. 
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Load libraries
library(data.table)
library(reshape2)

##Test data
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

##Import feature names and activity labels
features <- read.table("features.txt")[,2]
activity_labels <- read.table("activity_labels.txt")[,2]


##Extract mean and standard deviation; set activity labels
extract_features <- grepl("mean|std", features)
names(X_test) = features
X_test <- X_test[,extract_features]
y_test[,2] <- activity_labels[y_test[,1]]
names(y_test) <- c("ActivityID", "ActivityLabel")
names(subject_test) <- "Subject"

TestData <- cbind(as.data.table(subject_test), y_test, X_test)

##Training data
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
names(X_train) = features

##Extract mean and standard deviation; set activity labels
X_train <- X_train[,extract_features]
y_train[,2] <- activity_labels[y_train[,1]]
names(y_train) <- c("ActivityID", "ActivityLabel")
names(subject_train) <- "Subject"

TrainingData <- cbind(as.data.table(subject_train), y_train, X_train)

##Create data set
MergedData <- rbind(TestData, TrainingData, fill=TRUE)
IDlabels <- c("Subject", "ActivityID", "ActivityLabel")
DataLabels <- setdiff(colnames(MergedData), IDlabels)
TempResult <- melt(MergedData, id = IDlabels, measure.vars = DataLabels)
FinalResult <- dcast(TempResult, Subject + ActivityLabel ~ variable, mean)

write.table(FinalResult, file = "TidyDataSet.txt", row.name=FALSE)