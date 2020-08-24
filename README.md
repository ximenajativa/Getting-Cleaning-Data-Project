
# Getting and Cleaning Data - Course Project
# README FILE


## Dataset

This project uses data from the [UCI Machine Learning Repository: Human Activity Recognition and Smart Phone Data site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Files 

- `CODEBOOK.md` : It is a file that provides a description of the data and project, the files/data used, and all transformations that was performed to obtained a tidy dataset. 

- `run_analysis.R` It is an R script that downloads the necessary data, performs the data preparation and then follows the 5 steps required in the course project:        
  + 1. Merges the training and the test sets to create one data set.
  + 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  + 3. Uses descriptive activity names to name the activities in the data set
  + 4. Appropriately labels the data set with descriptive variable names.
  + 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- `finaldata.txt` is the exported final data after going through all the sequences described above.


