README.md
==============

Project work for cleaning data Coursera
by kaveht
===============

The script: run_analysis.R is intended to create a tidy data of the mean and standard deviation of the data collected as part of the Human Activity Recognition Using Smartphones Dataset.  In particular, the script calculates the mean of the mean and standard deviation of the sensor data for both time and frequency domains.

The original dataset and information about the experiment can be obtained from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset contains the following files:
==========================================
- 'ReadME.md : basic information about the files and how the script
- run_analysis.R : script to run to create the mean of the mean and standard deviation of original dataset
- CodeBook.md : code book containing general description of the variables and explanation of data transformation
- mean_activitybysubject.txt :  Each row identifies the subject who performed the activity (coded from 1 to 30),
                            type of activity,
                             whether it was for training or test purpose,
                             mean of corresponding variable (accelerometer or gyroscope triaxial data along with time
                             and frequency domain - see CodeBook.md for further detail).


Notes:
===========================================
- Features are normalized and bounded within [-1, 1] per Readme.txt file contained in the original dataset.
- The following libraries were used in the script:
     plyr
     reshape2
- The dataset should be in the working directory so that when invoking list.files() the following is presented:
 "activity_labels.txt" "features.txt"  "features_info.txt"   "README.txt"  "test"    "train"
