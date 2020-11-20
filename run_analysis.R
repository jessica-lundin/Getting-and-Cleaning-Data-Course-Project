
### Getting and Cleaning data Course Project
### Nov 20, 2020

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data 
#    set with the average of each variable for each activity and each subject.

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# 1. Merges the training and the test sets to create one data set.
# read train, test, and subject csv files and merge datasets 
# train data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# test data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# merge data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
s_data <- rbind(s_train, s_test)


## Load feature file 
# feature info
feature <- read.table("UCI HAR Dataset/features.txt")
feature[,2] <- as.character(feature[,2])

# Add features to colnames
colnames(x_data) <- feature$V2

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# extract feature columns with names 'mean OR std'
selectedCols <- grep("-(mean|std).*",names(x_data))
x_data <- x_data[selectedCols]

# 3. Uses descriptive activity names to name the activities in the data set
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)

# merge all data together and pull in all column names
allData <- cbind(s_data, y_data, x_data)

# 4. Appropriately labels the data set with descriptive variable names.
colnames(allData) <- c("Subject", "Activity", selectedColNames)


# Load activity labels
a_label <- read.table("UCI HAR Dataset/activity_labels.txt")
a_label[,2] <- as.character(a_label[,2])

# Format activity and subject vars
allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


# 5. Create an independent tidy data set with the average of each variable 
# for each activity and each subject.
library(reshape2)
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)
View(tidyData)

#read.table("C:/Users/jessica.lundin/Desktop/Personal/COURSERA/Getting and Cleaning data/tidy_dataset.txt",header=T)
