library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels and features
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
ActivityLabels[,2] <- as.character(ActivityLabels[,2])
Features <- read.table("UCI HAR Dataset/features.txt")
Features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
FilteredFeatures <- grep(".*mean.*|.*std.*", features[,2])
FilteredFeatures.names <- features[FilteredFeatures,2]
FilteredFeatures.names = gsub('-mean', 'Mean', FilteredFeatures.names)
FilteredFeatures.names = gsub('-std', 'Std', FilteredFeatures.names)
FilteredFeatures.names <- gsub('[-()]', '', FilteredFeatures.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[FilteredFeatures]
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainY, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[FilteredFeatures]
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testY, test)

# Merge datasets and add labels
MergeData <- rbind(train, test)
colnames(MergeData) <- c("subject", "activity", FilteredFeatures.names)

# Factorise activities and subjects
MergeData$activity <- factor(MergeData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
MergeData$subject <- as.factor(MergeData$subject)

# Labels the data set with descriptive variable names
MergeData.melted <- melt(MergeData, id = c("subject", "activity"))
MergeData.mean <- dcast(MergeData.melted, subject + activity ~ variable, mean)
# Output average of each variable for each activity and each subject
write.table(MergeData.mean, "result.txt", row.names = FALSE, quote = FALSE)