---
title: "Codebook"
author: "kaveht"
date: "Sunday, August 24, 2014"
output:
  html_document: default
---
### Variable Names:
The following is a list of variables contained in *mean_activitybysubject.txt* file. This file contains the calculated mean of each of the variables with the exception of *subject, activity, and train_test.*     
<table class = "table">
<tr>
    <th>Variable Name</th> 
    <th>Description</th>
</tr>
<tr>
    <td>subject</td>
    <td>number corresponding the person who performed the activity</td>
</tr> 
<tr>
    <td>activity</td>
    <td>type of activity:  walking, walking_upstairs, walking_downstairs. sitting, standing, laying</td>
</tr>
<tr>
    <td>train_test</td>
    <td>Indicator denoting whether the data is from training or test session: train, test</td>
</tr>
<tr>
    <td>BodyAcc</td>
    <td>Body acceleration signal</td>
</tr>
<tr>
    <td>GravityAcc</td>
    <td>Gravity acceleration signal</td>
</tr>
<tr>
    <td>BodyAccJerk</td>
    <td>Body Jerk signal</td>
</tr>
<tr>
    <td>BodyGyro</td>
    <td>Body angular velocity</td>
</tr>
<tr>
    <td>BodyGyroJerk</td>
    <td>Body angular velocity Jerk signal</td>
</tr>
<tr>
    <td>BodyAccMag</td>
    <td>Body acceleration Magnitude of three dimensional signals</td>
</tr>
<tr>
    <td>GravityAccMag</td>
    <td>Gravity acceleration Magnitude of three dimensional siganls</td>
</tr>
<tr>
    <td>BodyAccJerkMag</td>
    <td>Body acceleration Jerk Magnitude of three dimensional siganls</td>
</tr>
<tr>
    <td>BodyGyroMag</td>
    <td>Body angular velocity Magnitude of three dimensional siganls</td>
</tr>
    <td>BodyGyroJerkMag</td>
    <td>Body angular velocity Jerk signal</td>
</tr>
<tr>
    <td>t</td>
    <td>Time Domain</td>
<tr>
    <td>f</td>
    <td>Fast Fourier Transform of Variable</td>
</tr>
<tr>
    <td>mean_</td>
    <td>calculated mean of the variable</td>
</tr>
<tr>
    <td>*mean* (within a variable name)</td>
    <td>mean variable of original dataset</td>
</tr>
<tr>
    <td>*std* (within a variable name)</td>
    <td>standard deviation variable of the original dataset</td>
</tr>
</table>
---
### Transformation Procedure:
---
#### Special Note:
The following libraries were used to transform the data:    
* plyr   
* reshape2    
Also, set the working directory above the *UCI HAR Dataset* folder - this is the folder when the default folder is selected when the file is unzipped.    
---
#### Transformation Steps:

<ol> 1. Change working directory to where activity labels and features files are located
2.  Read activity, features and variable names for sensor files
3.  Change text case for **activity** to lowercase
4.  Change directory to **train** subdirectory
5.  Read ``` X_train, subject_train and y_train ``` files
6.  Combine training files into ```train_data``` file
7.  Change directory to **test** subdirectory
8.  Read ```X_test, subject_test and y_test ``` files
9.  Combine test files into ```test_data ``` file
10. Create a column to denote if the data is from **test** or **train** files in ```test_data``` and ```train_data```, respectively
11. Combine **test** and **train** datasets
12. Create ```coln``` to combine variable names along with *subject, activity,* and *train_test* variables (this will be used for column names of combined dataset)
13. Change activity from number to factor (1-6) to walking, etc.
14. Subset data based on pattern in column name that matches *mean()* or *std()*
15. Clean column names to remove dash marks and "()" and replace with underscore ("_").  Remove contigous words such as "BodyBody".
16. Create long data fromat using **reshape2** library - each line contains subject, activity, train or test, and measure variables;  also calculate the mean.
17. write file in  *txt* format ```mean_activitybysubject.txt``` with ```row.name = FALSE``` option.