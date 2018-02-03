#########################################################################################################
# GETTING AND CLEANING DATA COURSE PROJECT
#
#  run_analysis.R that does the following.
#     1. Merges the training and the test sets to create one data set.
#     2. Extracts only the measurements on the mean and standard deviation for each measurement.
#     3. Uses descriptive activity names to name the activities in the data set
#     4. Appropriately labels the data set with descriptive variable names.
#     5. From the data set in step 4, creates a second, 
#        independent tidy data set with the average of each variable for each activity and each subject.
########################################################################################################

library(dplyr)

# GET DATA 

# download the data for the project
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI_HAR_Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file
dir <- "UCI_HAR_Dataset"
if (!file.exists(dir)) {
  unzip(zipFile)
}


# LOAD FILE 


features <- read.table(paste(dir,"/features.txt",sep=""),header = FALSE , sep = "")
activity_labels <-  read.table(paste(dir,"/activity_labels.txt"), header = FALSE , sep = "")

#Test Data
x_test <- read.table(paste(dir,"/test/X_test.txt"), header = FALSE , sep = "")
y_test <- read.table(paste(dir,"/test/X_test.txt"), header = FALSE , sep = "")
subject_test <-read.table(paste(dir,"/test/X_test.txt"), header = FALSE , sep = "")

#Train Data
x_train <- read.table(paste(dir,"/train/X_train.txt"), header = FALSE , sep = "")
y_train <- read.table(paste(dir,"/train/y_train.txt"), header = FALSE , sep = "")
subject_train <- read.table(paste(dir,"/train/subject_train.txt"), header = FALSE , sep = "")

#MERGE AND EXTRACT DATA

#1. Merge train and test by type of data
subject_data <- rbind(subject_test, subject_train)
y_data <- rbind(y_test,y_train)
x_data <- rbind(x_test, x_train)


#2. Extracts only the measurements on the mean and standard deviation for each measurement.
mean <- grep("mean()",fixed = TRUE, features[,2])
std <- grep("std()",fixed = TRUE, features[,2])
meanandstd <- sort(as.numeric(c(mean,std)))
features_meanandstd <- features[meanandstd,2]
x_data_meanandstd <- x_data[,meanandstd]


#NAMING COLUMNS

#3. Uses descriptive activity names to name the activities in the data set
names(subject_data) <- c("Subject")
names(activity_labels) <- c("Activity", "Label")
y_data.with.names <- y_data
y_data.with.names[] <- activity_labels$Label[match(unlist(y_data), activity_labels$Activity)]  
names(y_data.with.names) <- c("Activity")

#4. Appropriately labels the data set with descriptive variable names.
names(x_data_meanandstd) <- features_meanandstd

#MERGE ALL
test_train <- cbind(subject_data,y_data.with.names,x_data_meanandstd)



#5. From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable for each activity and each subject.

test_train_mean <- test_train %>% group_by(Subject, Activity) %>% summarise_all(funs(mean))

write.table(test_train_mean, "tidy_testtrain.txt", row.names = FALSE)
