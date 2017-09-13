require(plyr)

f(!file.exists("WearableData.zip")){
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "WearableData.zip")
unzip("WearableData.zip", overwrite = TRUE)
}

## Read the training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", stringsAsFactors = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE)

## Read the test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", stringsAsFactors = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE)

## Gathers the activity labels and feature names
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
feature_names <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
feature_names <- feature_names[,2] #Strips out the index column so that the names can be used.
names(activity_labels) <- c("V1", "Activity")

## Identify only the mean or standard deviation columns
meanstdColumns <- grep('mean|std', feature_names)

##################################################################
## 1.  Merge the training and test sets to create one data set. ##
##################################################################
x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)
names(subject_total) <- "Subject"

## Cleans up the header row with nice feature names
names(x_total) <- feature_names

###################################################################################################
## 2. Extract only the measurements on the mean and standard deviation for each measurement.     ##
###################################################################################################
x_total_extract <- x_total[, meanstdColumns]


###################################
## 3. Descriptive Activity Names ##
###################################
xyz_combined <- merge(activity_labels, cbind(subject_total, y_total, x_total_extract), by = "V1")

## Rearranged for tidiness sake.
xyz_combined <- xyz_combined[c(3,2,4:82)]

####################################
## 4.  Descriptive Variable Names ##
####################################
names(xyz_combined) <- gsub("^t", "time - ", names(xyz_combined))
names(xyz_combined) <- gsub("^f", "frequency - ", names(xyz_combined))
names(xyz_combined) <- gsub("Acc", "Accelerometer - ", names(xyz_combined))
names(xyz_combined) <- gsub("Gyro", "Gyroscope - ", names(xyz_combined))
names(xyz_combined) <- gsub("Mag", "Magnitude - ", names(xyz_combined))
names(xyz_combined) <- gsub("BodyBody", "Body - ", names(xyz_combined))

#############################################################################
## 5.  Second independent tidy data set with averages for activity/subject ##
#############################################################################
activity_subject_averages <- ddply(xyz_combined, c("Subject", "Activity"), numcolwise(mean))  ## numwise applies the mean 
                                                                                              ## function to each column
write.table(activity_subject_averages, "tidydata.txt", row.names = FALSE, col.names = TRUE)   ## exports text file