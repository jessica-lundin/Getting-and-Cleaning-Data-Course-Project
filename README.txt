Getting and Cleaning data course project - update of README.txt from original file

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with mean and standard deviation of the time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The tidy_dataset.txt was made using the UCI HAR Dataset using the following files:
1. features.txt - decriptions of the features measures (described in detail below)
2. train/X_train.txt - measurements of the features in the train set (1 row per measurement for 561 features)
3. test/X_test.txt - measurements of the features in the test set
4. train/subject_train.txt - subject for each measurement from the train set
5. test/subject_test.txt - subject from each measuremet from the test set
6. train/y_train.txt - activity for each measurement from the train set
7. test/y_test.txt - activity for each measurement from the test set
8. activity_labels.txt - data labels for levels of activity variable

The run_analysis.R script makes the following changes to the data.

1. Data is downloaded, the training, test, activity, and subject dataset are pulled into R.
   The test and train files are merged for feature (x_data), activity (y_data), and subject (s_data)
2. and 3. The names of the features are assigned to the columns of the feature dataset (x_data)
   The dataset is refined to only include measurements of the mean or standard deviation
   of each measurement
   All data is merged together
4. Approriate labels are given to all columns  (subject, activity, and feature)
   Activity labels are applied and formatted
5. An independent tidy data set is created with the average of each variable for each activity and subject
   New dataset "tidy_dataset.txt"
