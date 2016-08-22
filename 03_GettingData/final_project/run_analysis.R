# 1. Merge the training and the test sets to create one data set.

## Set up
if (!dir.exists('./data')) {
  dir.create('./data')
}

fileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile = './data/dataset.zip', method = 'curl')
unzip('./data/dataset.zip', exdir = './data')

dataPath <- file.path('./data', 'UCI HAR Dataset')
files <- list.files(path = dataPath, recursive = TRUE)

## Read files
featuresTest <- read.table(file = file.path(dataPath, 'test', 'X_test.txt'), header = FALSE)
featuresTrain <- read.table(file = file.path(dataPath, 'train', 'X_train.txt'), header = FALSE)

activityTest <- read.table(file = file.path(dataPath, 'test', 'y_test.txt'), header = FALSE)
activityTrain <- read.table(file = file.path(dataPath, 'train', 'y_train.txt'), header = FALSE)

subjectTest <- read.table(file = file.path(dataPath, 'test', 'subject_test.txt'), header = FALSE)
subjectTrain <- read.table(file = file.path(dataPath, 'train', 'subject_train.txt'), header = FALSE)

## Merge train and test sets by dataset type
features <- rbind(featuresTest, featuresTrain)
activity <- rbind(activityTest, activityTrain)
subject <- rbind(subjectTest, subjectTrain)

## Set variable names
featureNames <- read.table(file = file.path(dataPath, "features.txt"))
names(features) <- featureNames$V2

names(activity) <- c("activity")
names(subject) <- c("subject")

## Merge everything into one data frame
df <- cbind(subject, activity, features)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.
relevantIndices <- grep("mean|std", names(df))

## Make sure the subject and activity columns are not left out.
relevantIndices <- c(1, 2, relevantIndices)
df <- df[, relevantIndices]


# 3. Use descriptive activity names to name the activities in the data set
activityNames <- read.table(file = file.path(dataPath, "activity_labels.txt"))

## Rename activity indices into corresponding activity names
df$activity <- cut(df$activity, breaks = c(0, 1, 2, 3, 4, 5, 6), labels = activityNames$V2)
df$subject <- as.factor(df$subject)



# 4. Appropriately label the data set with descriptive variable names.
names(df) <- gsub('^t', 'Time', names(df))
names(df) <- gsub('^f', 'Frequency', names(df))
names(df) <- gsub('Acc', 'Accelerometer', names(df))
names(df) <- gsub('Gyro', 'Gyroscope', names(df))
names(df) <- gsub('Mag', 'Magnitude', names(df))
names(df) <- gsub('BodyBody', 'Body', names(df))
###names(df) <- gsub('-', '', names(df))


# 5. Create a second, independent tidy data set with the average
#    of each variable for each activity and each subject.
tidy <- aggregate(. ~ subject + activity, data = df, FUN = 'mean')
tidy <- tidy[order(tidy$subject, tidy$activity), ]
write.table(tidy, file = "tidy.txt", row.names = FALSE)