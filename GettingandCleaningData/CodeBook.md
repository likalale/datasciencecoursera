CODEBOOK

STEP 0: Download the data. Checks and prepares the directories.
The script will download the data from the source and checks if the file and directories already exists. Else, it will download, extract (for the case of zip files), and create the necessary director

STEP 1: Reads the data. Use rbind to merge test and train according to type of data.
Resulting tables are subject_data, y_data, x_data. At the last part use cbind to merge all in one data set

activity_labels - decription of y_test and y_train
features - labels of the variables x_test and x_train
subject_test - subject IDs for test variables
subject_train - subject IDs for train variables
x_test - values in test variables
y_test - activity in test variables
x_train - values in train variables
y_train - activity in train variables
x_data - joined x_train and x_test
y_data - joined y_train and y_test
subject_data - joined subject_train and subject_test


STEP 2: Extracts only the measurements mean and standard deviation for each measurement
Subset features to create a vector of only mean() or and std(). Use grep to match the text.
meanandstd is the combined vector of mean and std.
x_data_meanandstd is the subsetted x_data using the meanandstd.
features_meanandstd contains the columns name of features with labels mean and std

STEP 3: Use function names() to label the columns.
to replace the activity no. in the y_data, use the activity_labels as your lookup table
to match and replace dataset. y_data.with.names is the dataset with descriptive activity 

STEP 4: Use the features_meanandstd from Step 3 to give names to x_data_meanandstd columns.

STEP 1-end: Now use the cbind to merge subject_data,y_data.with.names,x_data_meanandstd to have one data set.
Resulting file is test_train

STEP 5 : Load dplyr library. Use the group_by() sort the dataset by Subject first then by Activity.
Add summarise_all() function in the chain to get the mean according to subject and activity.

tidy_testtrain.txt is the output of the script.