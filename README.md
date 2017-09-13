# GetCleanData
## Assignment - Getting and Cleaning Data (Coursera)

This repo was created to fulfill the requirements of the Coursera Getting and Cleaning Data Course.  

### Data Description
##### Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The data from the source contains information from a controlled experiment involving 30 subjects.  The subjects were asked to perform
a variety of simple activities (standing, walking, going up stairs, etc.) while wearing a Samsung Galaxy SII smartphone recording 
their activities.  The x data include the sensor measurements, the y data indicate which activity, and the subject data contain information about which subject is performing each activity.

### Code
The code downloads the file from the source, draws the data into dataframes, and processes them to produce a tidy dataset containing
only the average values for each subject and activity.

### Assignment Instructions
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set.
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
