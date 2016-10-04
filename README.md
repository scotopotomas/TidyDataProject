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
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
This description walks through how the R script works and notes how the process meets the requirements listed above.

### Step 1: Load Libraries and Data

  * First I load the necessary libraries: dplyr and readr, these are assumed to already be installed on the user's computer, if not they should be installed before running the script.

  * Next I check if a Data directory already exists in the current working directory, if not I create the directory, download the data to that location and unzip the data file.

  * The next step is to read-in the data files I'll need to complete the analysis.  The data files I use include the raw data and files that contain the feature and activity names.  The raw data is split into training and test sets and within each set split into the x, y, and subject files.  The files are listed below, only files used in the analysis are listed:

    - X_train.txt: contains the feature data for the training set (7,352 observations of 561 variables)
    - X_test.txt: contains the feature data for the test set (2,947 observations of 561 variables)
    - Y_train.txt: contains the activity data for the training set (7,352 observations of 1 variable)
    - Y_test.txt: contains the activity data for the test set (2,947 observations of 1 variable)
    - subject_train.txt: contains the subject data for the training set (7,352 observations of 1 variable)
    - subject_test.txt: contains the subject data for the test set (2,947 observations of 1 variable
    - features.txt: contains the identifier/name combination for each feature (561 observations of 1 variable)
    - activity_labels.txt: contains the names and identifier for each activie (6 observations of 2 variables)
  
### Step 2: Combine test and train data sets.

  * I start by using the bind_rows command to replace each of the individual train and test data sets with a combined test and train data set.  This process is repeated for the x, y and subject data sets.
  
  * After combining the data sets I remove the original data sets to clear up memory.
  
  * Once this step is completed I have merged the training and test data sets, though the resulting data set is still in three different pieces: x, y and subject.
  
### Step 3: Label and filter data sets.

  * Add meaningful labels to the y and subject data sets.  I label the variable in the y data set "activityid" (since it contains the id associated with each specific activity) and I label the variable in the subject data set "subject" (since it indicates which of the 30 subjects the observation reflects.)
  
  * Add feature labels to the x data set.  I start by assigning the feature names data to the column names of the x data set.  
  
  * The assignment asks that only measurements on the mean and standard deviation for each measurement are used.  To ensure that I only include those measurements I filter the x data to only include variables with "mean()" or "std()" in the variable name.  I assume the additional variables (gravityMean, tBodyAccMean, tBodyAccJerkMean, tBodyGyroMean and tBodyGyroJerkMean) should be excluded from the data as these are based on angle measurements rather than means.  I also exclude the meanFreq() estimates as they represent a weighted average of the frequency components rather than an average of the raw data components.  After filtering the data I'm left with 66 of the 561 features, with names included.

  * Clean up the feature names.  I remove the identifier number at the beginning of the feature name using the strsplit and sapply functions.  I also remove the parentheses and replace the dashes with underscores.  As an example:
    
     - 1 tBodyAcc-mean()-X -> tBodyAcc_mean_X
     
  * Lastly I bind together the x, y and subject data sets using bind_cols into a single data set.  This data set consists of a column of subject identifiers, activityids and the 66 mean and std features of the x data set.  This data set meets requirements 2 and 4 as all variables have descriptive names that identify what is being measured and only mean and std features are included.  I consider the variable names descriptive since they relate directly to the original data that was recorded and using the code book their meaning can be understood.
  
### Step 4: Add activity labels and reorder data set.

  * Add names to the activity labels file with the first variable named activityid and the second activity for the actual name of each activity.
  
  * Merge the combined data file with the activity labels using the activityid as the key using the left_join method.  This creates an additional column in the main data set that includes the name of each activity (where before only the activityid was included).
  
  * Remove the activityid (as it is no longer needed) and move the activity name to the second column using subsetting from the base R package.
  
  * After this step is completed I've met requirement 3, each activity in the data set has a descriptive name based on the activity names that were originally used in the experiment.
  
### Step 5: Create tidy data and write tidy data set.

  * Our full data set includes multiple observations of all of the features for each combination of subject and activity.  The tidy data set should include a single observation for each subject and activity combination that represents the average of all of the observations for that subject and activity in the full data set.  In terms of tidy data, I treat a subject and activity combination as a single observation and then collect the 66 features for that observation as the variables.
  
  * I use group_by to make future summarize commands apply for each unique combination of subject and activity.  Since there are 30 subjects and 6 activities, this means there are 180 groups to calculate the features by.
  
  * I use summarize_each with a function of mean to calculate the mean of each feature for each unique combination of subject and activity.  This will be our tidy data set with one row for each observation and one variable in each column.
  
  * Lastly, as outlined in the project submission guidelines I write the table using the write.table function with row.name=FALSE.
  
  * After this step is done, I've completed the fifth requirement and have a tidy data set with the average of each variable for each unique combination of activity and subject.
