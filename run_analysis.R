# run_analysis.R
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Please upload the tidy data set created in step 5 of the instructions. 
# Please upload your data set as a txt file created with write.table() 
# using row.name=FALSE (do not cut and paste a dataset directly into the text box, as this may cause errors saving your submission).

# Setting the working directory
setwd("C:/Users/Leonardo Sala/Desktop/COURSERA/Data_Science_Specialization/3_Data_cleaning/ASSIGNMENT_WEEK_4/GIT_HOME")

# Common data ==================================================================================================================================
# Read In features Labels
frame_features <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/features.txt", header = FALSE, sep = "")
features_labels <- t(frame_features)


# Read In activity Labels
frame_labels <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/activity_labels.txt", header = FALSE, sep = "")
activity_labels <- frame_labels

# TRAINING DATA SET ============================================================================================================================
# Reading the features
frame_train_features <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/X_train.txt", header = FALSE, sep = "")
# Reading the activities
frame_train_activities <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/subject_train.txt", header = FALSE, sep = "")
# Reading the users
frame_train_users <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/train/y_train.txt", header = FALSE, sep = "")


# TESTING DATA SET =============================================================================================================================
# Reading the data in - test data set
frame_test_features <- read.table("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/X_test.txt", header = FALSE, sep = "")
# Reading the activities
frame_test_activities <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/subject_test.txt", header = FALSE, sep = "")
# Reading the users
frame_test_users <- read.csv("../../getdata_projectfiles_UCI_HAR_Dataset/UCI_HAR_Dataset/test/y_test.txt", header = FALSE, sep = "")

# check class and size
class(frame_train_features)
dim(frame_train_features)


class(frame_test_features)
dim(frame_test_features)

# Actual Merging  ==============================================================================================================================
# Prevent the binding should anything be wrong
if (ncol(frame_test_features)==ncol(frame_train_features)){
  print("Size matches")
  } else {
  print("Size mismatch!")
  stop("Now leaving")
}

# Labeling  =====================================================================================================================================
# Merging the data
frame_merged_features <- rbind(frame_train_features,frame_test_features)

class(frame_merged_features)
dim(frame_merged_features)

# Labeling the rows - Users
frame_merged_users <- rbind(frame_train_users,frame_test_users)

# Labeling the rows - activity
frame_merged_activities <- rbind(frame_train_activities,frame_test_activities)
# Replace number with 

#Labeling the columns
colnames(frame_merged_features) <- new_labels[2,]
