### Introduction

This repository contains the R code required to complete the Coursera Getting and Cleaning Data - Data Science course project. this project demonstrates techniques for collecting and cleaning data. the end result being  a"tidy data set. All code is contained in the file run_analysis.R.

### Input Data

Data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Files of note:
- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels. 

### Data Cleansing Process

The function getSummarizedDataSet will create the tidy data set from the input files supplied by UC Irvine.

The process flows as follows:
* Call getMeasures function to 
	* Read training set measurements (train/X_train.txt) and test set measurements (test/X_test.txt)
	* Merges the training and the test sets to create one data set
	* Call the getFeatureNames function to obtain meaningful column names for each measure
		- the column names are obtained from the file feature.txt
		- After reading the file, the data is transposed to facilitate easily renaming the columns in the measures data set.
	* Extracts only the measurements on the mean and standard deviation for each measurement
	
* Call getActivities function to
	* Read training set activities (train/y_train.txt) and test set activities (test/y_test.txt)
	* Merges the training and the test sets to create one data set
	* Call getActivityLabels function to obtain descriptive names for each activity (obtained form file activity_labels.txt)  
	* Join the descriptive activity names to the activity data set 
	Note this data set will identify the specific activity associated with each measurement that has been gathered. The rows in this combined data set correspond to the rows in the measures data set obtained in getMeasures.

* Call getSubjects function to 
	* Read training set subjects (train/subject_train.txt) and test set subjects (test/subject_test.txt)
	* Merge these two datasets into one data set
	Note this data set will identify the subject or participant from whom each measurement was gathered. The rows in this combined data set correspond to the rows in the measures data set obtained in getMeasures.
	
* Combine all three data sets - measures, subjects and activities into one data set
* Create a second, independent tidy data set with the average of each variable for each activity and each subject
