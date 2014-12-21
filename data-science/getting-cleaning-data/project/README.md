### Introduction

This project assignment demonstrates the learning ability to collect, analyze, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Expectation from project submission
Project submission expects 4 files as described below
1. README.md - this file
2. codebook.md - code book describes the meta data definitions of output file
3. run_analysis.R - script that implements requirements and generate output file
4. tidy_UCI_HAR_Dataset.csv - output file
	- tabular data (180 rows * 68 cols) in csv form
		- 2 columns subject_id and act_label_name represents columns on which output data is categorized
		- 66 columns (called features) out of 561 are taken from input data source representing mean and standard deviation only

### Requirement for project assignment
1. create one R script called run_analysis.R that does the following
	- Merges the training and the test sets to create one data set.
	- Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Uses descriptive activity names to name the activities in the data set
	- Appropriately labels the data set with descriptive variable names. 
	- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Raw data
1. download the data source file (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. unzip file
3. read and follow README.txt to understand the data definition
4. useful links
	- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
	- http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

### Files required for data analysis 
run_analysis.R script depends upon below files which are provided and are part of Raw data. Definition of each file is taken from README.txt of Raw data. All files are part of Raw data.
1. 'features.txt': List of all features.
2. 'activity_labels.txt': Links the class labels with their activity name.
3. 'train/X_train.txt': Training set.
4. 'train/y_train.txt': Training labels.
5. 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
6. 'test/X_test.txt': Test set.
7. 'test/y_test.txt': Test labels.
8. 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
			
### About the R script run_analysis.R
1. function run_analysis
This function is the main starting point of data analysis. This function 
	- downloads the raw data file, unzip it, and saves in local system
	- set the working directory to the folder unzipped 'UCI HAR Dataset'
	- read and store activities definition data in local variable
	- read and store features definition data in local variable
	- creates vector of selected features (mean and standard deviation columns)
	- prepare test and train data by calling function collectDataBySelectedFeatures
	- merge test and train data and join whole dataset with activities by activity id
	- clean up column names of dataset (remove chars ['(', ')'], replace '-' with '_')
	- aggregate dataset by subjects and activities
	- saves output data to "./../tidy_UCI_HAR_Dataset.csv" file
2. function collectDataBySelectedFeatures
This function 
	- reads the X data file, y data file, subject data file
	- binds 3 files into one dataset
	- select columns based on given vector of selected features 
3. function collectDataByAllFeatures
This function 
	- reads the X data file, y data file, subject data file
	- binds 3 files into one dataset

### Contributor
	- Student Coursera class getdata-016
