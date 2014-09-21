Getting-Cleaning-Data
=====================
Course Project Tasks



1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps to work on this course project

Download Data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Download the data source and put into a folder on your local drive. You'll have a UCI HAR Dataset folder.
Put run_analysis.R in the parent folder of UCI HAR Dataset.

Run source("run_analysis.R"), then it will generate a new file tidy_data.txt in your working directory.

Dependencies

You need to have the following R packages installed before running the script (1)data.table (2) reshape2
