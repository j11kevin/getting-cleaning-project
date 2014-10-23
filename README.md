Getting and Cleaning Data class project
=======================================

The file run_analysis.R reads the files subject_test.txt, subject_train.txt,
X_test.txt, X_train.txt, Y_test.txt, Y_train.txt, and features.txt from the
local directory. These data were retrieved from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

and are described here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The R script uses rbind and cbind to merge the training and test sets into a
single dataset, and uses grep to extract only the measurements on the mean
(variable name contains "mean()") and standard deviation (variable name
contains "std()") for each measurement. The script names the activities in
the dataset based on the lookup table in activity_labels.txt. The script then
uses melt and cast from the reshape library to create a second tidy dataset
containing the average of each variable for each activity and each subject.
This dataset is written to the file "my_tidy_output.txt" using write.table
with the row.names = FALSE option.
