# Leonardo Sala
# This script is the assignement for the Data Cleaning course, part if the Data Specialization

# Loading PLYR
library(plyr);

# Setting working Directory
setwd("C:/Users/Leonardo Sala/Desktop/COURSERA/Data_Science_Specialization/3_Data_cleaning/ASSIGNMENT_WEEK_4/GIT_HOME/Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project")
getwd()

# Getting Zipped data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Reading Training Data
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading Testing Data
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading features and activity labels
features <- read.table("./data/UCI HAR Dataset/features.txt")
Act_LBL = read.table("./data/UCI HAR Dataset/activity_labels.txt")

#Setting column names for the training data set
colnames(x_train) <- features[,2] 
colnames(y_train) <-"Act_ID"
colnames(subject_train) <- "Sub_ID"

#Setting column names for the testing data set
colnames(x_test) <- features[,2] 
colnames(y_test) <- "Act_ID"
colnames(subject_test) <- "Sub_ID"

colnames(Act_LBL) <- c('Act_ID','activityType')

# Merging by columns {Users;Activities,Features}
mergeTrain <- cbind(y_train, x_train,  subject_train)
mergeTest  <- cbind(y_test,  x_test,   subject_test )

# Merging by rows Training and Testing data sets
wholeDataset <- rbind(mergeTrain, mergeTest)

# Extracting measurements on the mean and standard deviation for each measurement
colNames <- colnames(wholeDataset)

# Boolean vector indicating columns being either activity, user
moments <- (  grepl("Act_ID" , colNames) | 
                grepl("Sub_ID" , colNames) | 
                grepl("mean.." , colNames) | 
                grepl("std.." , colNames) 
)
# Data Set reduced and having only Activity, User, Mean and standard deviation
momentsDataset <- wholeDataset[ , moments == TRUE]

# Using mnemonic activity names to name the activities in the data set
setWithActivityNames <- merge(momentsDataset, Act_LBL,
                              by='Act_ID',
                              all.x=TRUE)

# Creates a second, derived tidy data set with the average of each variable for each Activity and each Subject
TidyDataSet <- aggregate(. ~Sub_ID + Act_ID, setWithActivityNames, mean)

# Sort Properly  by User First and by Activity next
TidyDataSet <- TidyDataSet[order(TidyDataSet$Sub_ID, TidyDataSet$Act_ID),]

# Replace the activity numeric with Label
activity.code <- c(`NONE` = 0, WALKING=1, WALKING_UPSTAIRS=2, WALKING_DOWNSTAIRS=3, SITTING=4,  STANDING=5,  LAYING=6)
activity.str <- names(activity.code) [match(as.numeric(unlist(TidyDataSet$Act_ID)), activity.code)]
TidyDataSet$Act_ID <- as.character(activity.str)


# Save the text file
write.table(TidyDataSet, "TidyDataSet.txt", row.name=FALSE)