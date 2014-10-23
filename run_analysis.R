# Coursera Getting and Cleaning Data course project

# read the datasets
subject_test <- read.table("subject_test.txt", col.names = "subject")
subject_train <- read.table("subject_train.txt", col.names = "subject")
subject_combined <- rbind(subject_test, subject_train)
remove(subject_test) # clean up data no longer needed
remove(subject_train)

features <- read.table("features.txt") # V2 contains the variable names for X_*
X_test <- read.table("X_test.txt", col.names = features$V2)
X_train <- read.table("X_train.txt", col.names = features$V2)
X_combined <- rbind(X_test, X_train)
remove(X_test) # don't need X_test or X_train anymore, delete them to free up memory
remove(X_train)

Y_test <- read.table("Y_test.txt", col.names = "activity_label")
Y_train <- read.table("Y_train.txt", col.names = "activity_label")
Y_combined <- rbind(Y_test, Y_train)
remove(Y_test) # don't need Y_test or Y_train anymore, delete them to free up memory
remove(Y_train)
activity_labels <- read.table("activity_labels.txt",
                              col.names = c("activity_label", "activity"))
# replace activity_labels (numbers) with descriptive terms
Y_combined <- merge(Y_combined, activity_labels) # activity_labels is the lookup table
Y_combined <- subset(Y_combined, select = "activity") # keep only the activity descriptor

# merge X_combined and Y_combined to make a single unified dataset
data <- cbind(X_combined, Y_combined, subject_combined)
remove(X_combined) # clean up no longer needed variables
remove(Y_combined)
remove(subject_combined)

# keep only the variables with names containing mean(), std(), activity, or subject
# but parens were changed to periods, so really look for mean.., std.., activity, or subject
data <- subset(data, select = grep("mean\\.\\.|std\\.\\.|activity|subject", names(data)))

library(reshape)
molten <- melt(data, id.vars = c("activity", "subject"))
my_tidy_output <- cast(molten, activity + subject ~ variable, mean)
write.table(my_output, "my_tidy_output.txt", row.names = FALSE)