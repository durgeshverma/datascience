## runs analysis on the given data
## source of data: 
##      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## see README.txt file to know more about meta data 
run_analysis <- function() {
    library(data.table)
    setwd("/Users/durgeshverma/Documents/personal/durgesh/coursera/data-science/course-3-getting-and-cleaning-data")
    
    filename <- 'UCI HAR Dataset.zip'
    if (!file.exists(filename)) {
        download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', filename, method='curl')
        unzip(filename, exdir="./")
    }
    setwd(paste(getwd(),'UCI HAR Dataset',sep='/'))
    
    ## read list of activities selected to perform the experiment
    activities = read.table("./activity_labels.txt")
    colnames(activities) <- c("act_label_id", "act_label_name")
    
    ## read list of features applied on the experimental data
    all_features = read.table("./features.txt")
    features_of_interest <- c(grep("-mean\\(\\)",all_features$V2), grep("-std\\(\\)",all_features$V2))
    
    ## 1. Merges the train and the test sets to create one data set.
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    
    ## read test dataset
    test_dataset <- collectDataBySelectedFeatures(all_features, features_of_interest, "./test/X_test.txt", "./test/y_test.txt", "./test/subject_test.txt")
    ## add column to identify data belongs to test dataset
    test_dataset <- cbind(data.frame(dataset_name=rep("test", nrow(test_dataset))), test_dataset)
    
    ## read train dataset
    train_dataset <- collectDataBySelectedFeatures(all_features, features_of_interest, "./train/X_train.txt", "./train/y_train.txt", "./train/subject_train.txt")
    ## add column to identify data belongs to train dataset
    train_dataset <- cbind(data.frame(dataset_name=rep("train", nrow(train_dataset))), train_dataset)
    
    ## merge test and train dataset
    merged_data <- rbind(test_dataset, train_dataset)
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    ## 4. Appropriately labels the data set with descriptive variable names.
    
    ## add activity label name to merged dataset
    merged_data <- plyr::join(merged_data, activities, by = "act_label_id", type = "left")
    
    ## clean up column names in merged dataset
    colnames(merged_data) <- gsub("\\(\\)","",colnames(merged_data))
    colnames(merged_data) <- gsub("\\-","_",colnames(merged_data))

    ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    ## group merged dataset by subject and activity
    by_subjects_activities <- aggregate(
        select(merged_data,-(dataset_name:subject_id), -act_label_name),                    ## select quantitative data
        list(subject_id=merged_data$subject_id,act_label_name=merged_data$act_label_name),  ## define group by
        mean                                                                                ## function to apply on selected quantitative data
    )
    
    #write.csv(by_subjects_activities, file="./../tidy_UCI_HAR_Dataset.csv", row.names=FALSE)
    write.table(by_subjects_activities, file="./../tidy_UCI_HAR_Dataset.txt", row.names=FALSE)
    
    by_subjects_activities
}

## returns dataset as outcome of reading given dataset file, filtering the selected features, and then combine it with subject and activities data
## input parameters:
##      all_features - all features used in this dataset
##      selected_features - final selection of features required in output dataset
##      main_filename - main file (X_*.txt) to read this dataset
##      activity_filename - activity file of this dataset
##      subject_filename - subject file of this dataset
## returns:
##      data frame
collectDataBySelectedFeatures <- function(all_features, selected_features, main_filename, activity_filename, subject_filename) {
    main_data = read.table(main_filename)
    colnames(main_data) <- all_features$V2
    main_data_selected_features = main_data[, selected_features]
    main_data_act_labels = read.table(activity_filename)
    colnames(main_data_act_labels) <- c("act_label_id")
    main_data_subjects = read.table(subject_filename)
    colnames(main_data_subjects) <- c("subject_id")
    main_data <- cbind(main_data_act_labels, main_data_subjects, main_data_selected_features)
    main_data
}

## returns dataset as outcome of reading given dataset file, and then combine it with subject and activities data
## input parameters:
##      all_features - all features used in this dataset
##      main_filename - main file (X_*.txt) to read this dataset
##      activity_filename - activity file of this dataset
##      subject_filename - subject file of this dataset
## returns:
##      data frame
collectDataByAllFeatures <- function(all_features, main_filename, activity_filename, subject_filename) {
    main_data = read.table(main_filename)
    colnames(main_data) <- all_features$V2
    main_data_act_labels = read.table(activity_filename)
    colnames(main_data_act_labels) <- c("act_label_id")
    main_data_subjects = read.table(subject_filename)
    colnames(main_data_subjects) <- c("subject_id")
    main_data <- cbind(main_data_act_labels, main_data_subjects, main_data)
    main_data
}
