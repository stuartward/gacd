# CodeBook for Getting and Cleaning Data - Course Project
Load required libraries  
- data.table and reshape2 are require for running this script

Import test and training data
- Data is read in from: x_train.txt, y_train.txt, subject_train.txt, x_test.txt, y_test.txt, subject_test.txt, features.txt, and activity_labels.txt

Extract mean and standard deviation
- Extract only the measurements on the mean and standard deviation for each measurement

Merge data
- Merge the data set and utilize appropriate activity names

Export data
