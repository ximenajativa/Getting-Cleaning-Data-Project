# Getting and Cleaning Data - Course Project 
# CODEBOOK"


## Data and project description

This course project is an exercise in collecting and cleaning data. It uses data from the UCI Machine Learning Repository: Human Activity Recognition and Smart Phone Data site (see [this website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) for a detailed description of the dataset). 

Data for the project can be downloaded here: [Zip Archive](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

This code book describes the data, the variables and all transformations needed to obtained a tidy dataset. It relies on the source code book listed in the README.txt of the zip archive and available at the UCI link for definitions and descriptions.

## Processing

The R script "run_analysis.R" performs the data preparation (downloading and loading all necessary files), followed by the 5 steps required as described in the course project’s definition.

#### Download the dataset

Dataset downloaded and extracted under the folder called *UCI HAR Dataset*

#### Load all data files

* **features** The features in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.  
* **activities** Links the class labels with their activity name.
* **subject_test** Contains test data of volunteer test subjects being observed
* **x_test** Test set
* **y_test** Test labels
* **subject_train** Contains train data of volunteer subjects being observed
* **x_train** Training set
* **y_train** Training labels


#### Step 1: Merge the training and the test sets to create one data set

* **X** is created by merging `x_train` and `x_test` using the `rbind()` function
* **Y** is created by merging `y_train` and `y_test` using the `rbind()` function
* **subject** is created by merging `subject_train` and `subject_test` using the `rbind()` function
* **merged_data** is created by merging `subject`, `Y` and `X` using the `cbind()` function

#### Step 2: Extract only the measurements on the mean and standard deviation for each measurement

A new data selection (`tdata`) is created by subsetting `merged_data`, selecting the following columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement using the `select()` function

#### Step 3: Use descriptive activity names to name the activities in the data set

The numbers in the code column of the `tdata` are replaced by their corresponding labels in the `activities` dataset. 

#### Step 4: Appropriately label the data set with descriptive variable names

One part of the work was performed already while loading the data prior to step 1. 
This section performs further  cleaning, namely: the code column  in `tdata` was renamed "activities", BodyBody in column’s name replaced by Body, capital letters where applied when appropriate, punctuation was removed, abbreviations "t" and "f" were changed to time and frequency, tBody was changed to TimeBody

#### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

- `finaldata` is created by sumarizing `tdata` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
- Export `finaldata` into `finaldata.txt` file.




