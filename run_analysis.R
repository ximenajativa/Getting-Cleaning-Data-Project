###############################################
#Getting and Cleaning Data 
#Course Project
###############################################

#Remove previous data files in the environment
rm(list=ls( )) 

#Load Packages
library(dplyr)
library(data.table)
library(tidyr)

#############################################
# Download the dataset
#############################################

#Set working directory
setwd("/Users/ximena.jativa/Documents/Data Science Specialization/Getting and Cleaning Data/CourseProject/")

#Download data and checking if archive already exists

filename <- "Coursera_projectdata.zip"

if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists , if not, unzip it 
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#############################################
#Load all datasets
#############################################

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


##############################################################################################
#Step 1: Merge the training and the test sets to create one data set
##############################################################################################

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, Y, X)

###############################################################################################
#Step 2: Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################################

tdata <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

###########################################################################################
#Step 3: Use descriptive activity names to name the activities in the data set
###########################################################################################

tdata$code <- activities[tdata$code, 2]

###########################################################################################
#Step 4: Appropriately label the data set with descriptive variable names
###########################################################################################
#Note that this was done when loading the datasets
#I will make some additional changes here. I will not use the full names for  some words
#because tidy datasets should have short variable names

names(tdata)[2] ="activity"
names(tdata)<-gsub("BodyBody", "Body", names(tdata))
names(tdata)<-gsub("[-()]", "", names(tdata))
names(tdata)<-gsub("[[:punct:]]", "", names(tdata))
names(tdata)<-gsub("-mean()", "Mean", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("-std()", "Std", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("-freq()", "Frequency", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("^t", "Time", names(tdata))
names(tdata)<-gsub("^f", "Frequency", names(tdata))
names(tdata)<-gsub("tBody", "TimeBody", names(tdata))

###########################################################################################
#Step 5: From the data set in step 4, creates a second, independent tidy data set with the 
#average of each variable for each activity and each subject
###########################################################################################

finaldata <- tdata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(finaldata, "finaldata.txt", row.name=FALSE)


