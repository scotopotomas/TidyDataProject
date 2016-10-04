# Tidy Data Project: Code Book

This code book describes the data, variables and transformations used with the run_analysis R script to create a tidy data file.

## Data Source

Data is from the UCI Machine Learning Repository and the data set is called the Human Activity Recognition Using Smartphones Data Set.  A website with additional descriptions of the data is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.  

Much of the description of the data is copied or adapted from that website.

Citation: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

Data can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

### Abstract 

Data was collected based on recording 30 subjects performing activity of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

### Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Features

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

I look only at the mean(): Mean value and std(): Standard deviation of the features listed above, the original data collected many additional variables from the signals.

Each of the features was normalized and bounded within the range [-1,1].

## Transformations

In this project I only look at the the mean() and std() variables for each of the features listed above.  All of the features ending with "XYZ" represent 3 different features, one each for the x, y, and z axes.  In total there are 66 variables, one instance each of the mean and std measurement for each feature.

The original data set identifies the subject and activity for each observation in separate files.  In the analysis I combine these files and end up with a data file with 10,299 rows and 68 columns.  The columns are the subject and activity identifier and the 66 variables of interest.  Each row is a different observation of all 66 variables and a specific combination of the subject and activity identifier.

The analysis is interested in the average across all observations for each unique combination of subject and activity.  As there are 30 subjects and 6 activities and every subject had data available for every activity, there are 180 averages (rows) in the tidy data set.  Each row contains a variable with the average of that variable in the larger data set, grouped by activity and subject.

The analysis also performs transformations on feature names to make them more readable from the original data set.

## Variables

 * Variable: Subject
   - Description: Identifies the individual subject in the original experiment which the data refers to.
   - Values: 1-30 (there were 30 subjects in the experiment)
   - Example: 2 - This observation reflects data collected for subject 2 in the experiment.
   
 * Variable: Activity
    - Description: Identifies the activity the subject was doing when the data was recorded.
    - Values: (self-explanatory)
      * WALKING
      * WALKING_UPSTAIRS
      * WALKING_DOWNSTAIRS
      * SITTING
      * STANDING
      * LAYING
    - Example: WALKING - This observation reflects data collected while the subject was walking.
      
 * Variables: All Other Variables
   - Description: Each of the other variables in the dataset represents the average of the same variable in the original data set for the identified subject and activity.  The first part of the variable name (from the start of the variable name to the first underscore) is the underlying feature the variable represents in the original experiment.  For a description of the different features see the description above in the Data Source: Features section of the Code Book above.  The second part of the variable name (after the first underscore) identifies the particular summary method used on the feature, in this case either mean (for the arithmetic average) or std (for the standard deviation).  Some variables also have a third part (after the second underscore) this is for variables with a dimensional component and identifies whether the feature is a measurement of the X, Y or Z direction.
   - Values: All features were normalized and bounded within [-1,1], thus their averages and standard deviations also fall within that range and the averages of multiple observations of averages and standard deviations would also fall within that range.
   - Example: tBodyAcc_mean_X - From the features section above, tBodyACC is the time-domain body acceleration signal.  The mean indicates that we are looking at the average function applied to the signal.  The X at the end indicates we're looking at the acceleration in the X direction.
