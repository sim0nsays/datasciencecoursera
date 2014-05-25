Getting and Cleaning Data course project
===================

# Running transform

Run run_analysis.R script in the directory containing data downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

(note you should run it inside "UCI HAR Dataset" folder)

## Transforms

Script processes source data and does following transformations:
* Removes all of the quntitative variables not representing std or mean
* Merges train and test data into one dataset
* Records activity as string based on activity_labels.txt
* Processes activity labels to be more human-friendly (removes underscore, converts to CamelCase)

In addition, it averages quantitative data for each activity and each subject to produce secondary data set.

# Result

Script should generate two files:
  * proccesedMeanStddata.txt - contains tidy data set with columns describing mean and std data of the research

  * averageMeanStddata.txt - contains tidy data set with averaged data for each activity and each subject

# Codebook

CodeBook.MD explains meaning and possible values of resulting columns.


