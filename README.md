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

  * First I load the necessary libraries: dplyr and readr, these are assumed to already be installed on the user's computer, if not they should be installed before running the script.

  * Next I check if a Data directory already exists in the current working directory, if not I create the directory, download the data to that location and unzip the data file.

  * The next step is to read-in the data files I'll need to complete the analysis.  The data files I use include the raw data and files that contain the feature and activity names.  The raw data is split into training and test sets and within each set split into the x, y, and subject files.  The files are listed below, only files used in the analysis are listed:

    - X_train.txt: contains the feature data for the training set (7,352 observations of 561 variables)
    - X_test.txt: contains the feature data for the test set (2,947 observations of 561 variables)
    - Y_train.txt: contains the activity data for the training set (7,352 observations of 1 variable)
    - Y_test.txt: contains the activity data for the test set (2,947 observations of 1 variable)
    - subject_train.txt: contains the subject data for the training set (7,352 observations of 1 variable)
    - subject_test.txt: contains the subject data for the test set (2,947 observations of 1 variable
    - features.txt: contains the names and identifier for each feature (561 observations of 2 variables)
    - activity_labels.txt: contains the names and identifier for each activie (6 observations of 2 variables)
  
### Step 2: Combine test and train data sets.

  * I start by using the bind_rows command to replace each of the individual train and test data sets with a combined test and train data set.  This process is repeated for the x, y and subject data sets.
  
  * After combining the data sets I remove the original data sets to clear up memory.
  
  * Once this step is completed I have merged the training and test data sets, though the resulting data set is still in three different pieces: x, y and subject.
  
### Step 3: Label data sets.

  * Add meaningful labels to the y and subject data sets.  I label the variable in the y data set "activityid" (since it contains the id associated with each specific activity) and I label the variable in the subject data set "subject" (since it indicates which of the 30 subjects the observation reflects.)
  
  * Add feature labels to the x data set.  I start by assigning the feature names data to the column names of the x data set.  
  
  * The assignment asks that only measurements on the mean and standard deviation for each measurement are used.  To ensure that I only include those measurements I filter the x data to only include variables with "mean()" or "std()" in the variable name.  I assume the additional variables (gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean and tBodyGyroJerkMean) should be excluded from the data as these are based on angle measurements rather than means.  After filtering the data I'm left with 66 of the 561 features, with names included.

  * Clean up the feature names.  I remove the identifier number at the beginning of the feature name using the strsplit and sapply functions.  I also remove the parentheses and replace the dashes with underscores.  As an example: 
  1 tBodyAcc-mean()-X -> tBodyAcc_mean_X
