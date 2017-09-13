# Source Data
The original data for this assignment was retrieved from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#### Data Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we 
captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments 
have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two 
sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor 
signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width 
sliding windows of 2.56 sec and 50% overlap (128 readings/window). 

The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth
low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency 
components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was 
obtained by calculating variables from the time and frequency domain.

#### Attribute Information
For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

# Processing
All processing is completed through the run_analysis.R script (uploaded to GitHub)
#### Preprocessing (Downloading and pre-cleaning source data)
* Training data is downloaded from source and read to x_train, y_train, and subject_train variables
* Test data is downloaded from source and read to x_test, y_test, and subject_test variables
* Activity labels, and feature names are downloaded from source
* Feature names has the index column removed to make the names column the only column
* The column names are set for the activity_labels dataframe (V1 for consistency, and "Activity" for tidiness)
* The mean and standard deviation columns are identified using GREP and stored in meanstdColumns

#### Merging the training and test sets
* The x_train and x_test dataframes are merged into x_total
* The y_train and y_test dataframes are merged into y_total
* The subject_train and subject_test dataframes are merged into subject_total
* There is only one column in subject_total, for tidiness, it is renamed "Subject"
* The x_total dataset has its columns renamed from the feature_names dataframe (which is why it was cleaned earlier.)

#### Extracting only the mean and standard deviation columns
* Using the meanstdColumns, x_total is clipped to only those columns containing mean or standard deviation, stored to x_total_extract

#### Descriptive Activity Names
* activity labels are merged (using common column V1) with the column-bound subject, y_total, and x_total_extract dataframes, stored to xyz_combined
* xyz_combined is rearranged so that subject comes first, then activity, then the remaining measured columns (activity number removed)

#### Descriptive Variable Names
* using gsub, abbreviations are replaced by full words in xyz_combined (^t > time, ^f > frequency, Acc > Accelerometer, Gyro > Gyroscope, Mag > Magnitude, BodyBody > Body)

#### Tidy Data Set Creation
* using ddply (from plyr) the xyz_combined is summarized by subject and activity (columns are averaged (mean)), stored to activity_subject_averages
* the tidy dataset is written to tidydata.txt
