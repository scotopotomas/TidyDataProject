# TidyDataProject

  Submission for the Coursera Getting and Cleaning Data - Tidy Data project by Scott Fry

## Files Included

  1. run_analysis.R: The R script that does all the analysis from downloading the data to writing the final tidy data set.
  2. CodeBook.md: The code book that describes the variables, the data and the processing done on the raw data.
  3. README.md: This readme file that describes the files included and how the R script does the analysis.

## How the R script performs the data analysis

  The R script completes the 5 requirements of the project (listed below):
  
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set.
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each      subject.
 
This description walks through how the R script works and notes how the process meets the requirements listed above.

### Step 1: Script Preparation and Load Data

  * First we load the necessary libraries: dplyr and readr, these are assumed to already be installed on the user's computer, if not they should be installed before running the script.

  * Next we check if a Data directory already exists in the current working directory, if not we create the directory, download the data to that location and unzip the data file.

  * The next step is to read-in the data files we'll need to complete the analysis.  The data files we'll use include the raw data and files that contain the feature and activity names.  The raw data is split into training and test sets and within each set split into the x, y, and subject files.  The files are listed below, only files used in the analysis are listed:

    - X_train.txt: contains the feature data for the training set (7,352 observations of 561 variables)
    - X_test.txt: contains the feature data for the test set (2,947 observations of 561 variables)
    - Y_train.txt: contains the activity data for the training set (7,352 observations of 1 variable)
    - Y_test.txt: contains the activity data for the test set (2,947 observations of 1 variable)
    - subject_train.txt: contains the subject data for the training set (7,352 observations of 1 variable)
    - subject_test.txt: contains the subject data for the test set (2,947 observations of 1 variable
    - features.txt: contains the names and identifier for each feature (561 observations of 2 variables)
    - activity_labels.txt: contains the names and identifier for each activie (6 observations of 2 variables)
  
  
