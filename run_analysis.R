# file run_analysis.R to create tidy data consisting of mean of parameters
# This script requires plyr and reshape2 libraries
#
# SET UP:
library(plyr)                                                   # Calling plyr library
library(reshape2)                                               # Calling reshape2 library
setwd("./UCI HAR Dataset")                                      # Change working directory where raw dataset is located
#
# Read the activity labels and features (variables in dataset - 561 variables)
activity <- read.table(file = "activity_labels.txt", FALSE)     # read table containing activity labels
activity<- tolower(activity[,2])                                # convert activity labels to lower case
features <- read.table(file = "features.txt")                   # read in 561 variable names for sensors
#
# Change directory to TRAIN directory and read data files
#
setwd("./train")                                                # change directory to subdirectory: train
X_train <- read.table(file = "X_train.txt")                     # Read file X_train
subject_train <- read.table(file = "subject_train.txt")         # Read file subject_train
y_train <- read.table(file = "y_train.txt")                     # Read file y_train
train_data <- cbind(X_train, subject_train, y_train)            # Combine training files
rm(list = "X_train", "y_train", "subject_train")                # Remove working files
#
# Change directory to TEST directory and read data files
#
setwd("../test")                                                # change directory to subdirecotory: test
X_test <- read.table(file = "X_test.txt")                       # Read file X_test
y_test <- read.table(file = "y_test.txt")                       # Read file y_test
subject_test <- read.table(file ="subject_test.txt")            # Read file subject_test
test_data <- cbind(X_test, subject_test, y_test)                # Combine testing files
rm(list = "X_test", "y_test", "subject_test")                   # Remove working files
#
# Create a column to denote if the data came from train or test dataset
#
train_data[dim(train_data)[2] + 1] <- rep("train", dim(train_data)[1])
test_data[dim(test_data)[2] + 1] <- rep("test", dim(test_data)[1])
#
# Change working directory to store final file
#
setwd("../")
#
# Combine train and test datasets and place labels on the file
#
data <- rbind(train_data, test_data)        # Combine data train and test datasets
rm(list = "test_data", "train_data")        # remove working files
# Create coln to combine variable names and subject, activity and train-test variables for column names
coln <- rbind(features, as.data.frame(cbind(1:3, rbind("subject", "activity", "train_test"))))[, 2]
colnames(data) <- coln
# Change activity from number (1-6) to activity type (e.g., walking, etc.)
data$activity <- mapvalues(data$activity, from = as.character(1:6), to = activity)
# remove working files
rm(list = "activity", "features", "coln")
# create data2 which only has variables that are "mean" or "standard deviation" 
data2 <- data[, c(grep(pattern = "mean()|std()", x = names(data), value = FALSE), 562:564)]
# cleanup column names to remove "()" and dash marks - in lieu of "()" use underscore "_"
colnames(data2) <- gsub("_$", "", gsub("\\)", "", (gsub("\\(", "_", tolower(gsub("-", "", colnames(data2)))))))
# create long data formate so each line has information on subject, activity and whether it is train or test
# each row will have the corresponding mean or standard deviation of a variable
data2.melt <- melt(data = data2, id.vars = c("subject", "activity", "train_test"), measure.vars = names(data2)[1:79])
# remove working files
rm(list = "data", "data2")
# take the mean of the variables based on subject, activity and whether it is a train or test
# train and test are mutually exclusive - subjects who did the train did not test and vice versa 
ans <- dcast(data = data2.melt, formula = subject + activity + train_test ~ variable, fun.aggregate = mean)
# remove working file
rm(list = "data2.melt")
# write the final file in txt format without row names
write.table(x = ans, file = "mean_activitybysubject.txt", row.names = FALSE)
# end of file