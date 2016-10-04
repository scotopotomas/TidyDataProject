## 1. Merge training and test data sets

## Load required libraries to be used in R script.

library(dplyr)
library(readr)

## Create directory, download and unzip file.

 if(!file.exists("./data")){dir.create("./data")}
 fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
 download.file(fileUrl, destfile="./data/ZippedData.zip")
 unzip("./data/ZippedData.zip")
 rm(fileUrl)

## At this point you will have a file with all of the relevant datasets saved in the file location:
## "./UCI HAR Dataset".  Now will load the datasets needed for our first task.

## Code to read in all of the data files.

xtrain <- read_fwf("./UCI HAR Dataset/train/X_train.txt", fwf_widths(rep(16,561)))
ytrain <- read_delim("./UCI HAR Dataset/train/Y_train.txt", delim="\r\n", col_names=F)
subjecttrain <- read_delim("./UCI HAR Dataset/train/subject_train.txt", delim="\r\n", col_names=F)
xtest <- read_fwf("./UCI HAR Dataset/test/X_test.txt", fwf_widths(rep(16,561)))
ytest <- read_delim("./UCI HAR Dataset/test/Y_test.txt", delim="\r\n", col_names=F)
subjecttest <- read_delim("./UCI HAR Dataset/test/subject_test.txt", delim="\r\n", col_names=F)
featurenames <- read_delim("./UCI HAR Dataset/features.txt", delim="\r\n", col_names=F)
activitylabels <- read_delim("./UCI HAR Dataset/activity_labels.txt", delim=" ", col_names=F)

## Combine the test and train datasets.  Delete the separate datasets.

x <- bind_rows(xtrain, xtest)
y <- bind_rows(ytrain, ytest)
subject <- bind_rows(subjecttrain, subjecttest)
rm(subjecttest, subjecttrain, xtest, xtrain, ytest, ytrain)

## 2. Extract only the measurements on the mean and standard deviation for each measurement.
## Note: This also achieves 4. Appropriately labels the data set with descriptive variable names.

## Add meaningful labels to the y and subject variables.

names(y) <- "activityid"

names(subject) <- "subject"

## Bring in the identifiers for the features in the x dataset.  Note, these will be in the same order (e.g. X1 from
## the x dataset is the first value in the features file: "tBodyAcc-mean()-X").

names(x) <- featurenames$X1 

## Remove all of the columns of data from the x dataset that are not showing mean() or std() data.
## This is done through regular expressions.

x <- select(x, matches("mean\\(\\)|std\\(\\)"))

## Some manipulation is done to remove the numbers in front of each name in x.

splitnames <- strsplit(names(x), " ")

finalnames <- sapply(splitnames, secondelement <- function(x) {x[2]})
rm(secondelement)

names(x) <- finalnames

rm(featurenames, splitnames, finalnames)

## Replace the "-" and "()" in the column names of the data set to make it more readable.

names(x) <- gsub("-","_",names(x))

names(x) <- gsub("\\(\\)","",names(x))

## Bind together all the data (x,y,subject).

data <- bind_cols(subject, c(y,x))

rm(x, y, subject)

## 3. Use descriptive activity names to name the activities in the data set.

## Name the activitylables dataset appropriately to prepare for joining the data sets.

names(activitylabels) <- c("activityid", "activity")

## Join the data and activity names data sets.

data <- left_join(data, activitylabels, by="activityid")
rm(activitylabels)

## Reorder the columns so that activity is the second column and remove the activityid variable.

data <- data[, c(1,69,3:68)]

## After this step we have a data set with information on the subject, the activity and the set of mean and std variables
## for each observation.

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject.

## We'll need to summarize the data by the subject and activity identifier.

## After this is completed there should be one row for each unique subject * activity combination.  Or 30 * 6 = 180 rows.
## The value for each variable will be the average value from all of the rows for that subject * activity combination
## in the original data set.

## This is the "wide" version of the data that treats each subject * activity combination as an observation and all of
## the averages as variables attached to that observation.

data <- group_by(data, subject, activity)

tidydata <- summarize_each(data, funs(mean))

write.table(tidydata, "Scott_Fry_tidydata.txt", row.name=FALSE)




