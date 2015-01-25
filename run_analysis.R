#==========================================
#Getting and Cleaning Data - Course Project
#==========================================

#1. Merges the training and the test sets to create one data set.
#================================================================

#Define folder involved
dataFolder <- "UCI HAR Dataset"
spe <- "/"
trainFolder <- paste(dataFolder, "train", sep=spe)
testFolder <- paste(dataFolder, "test", sep=spe)

#Read activityType and features
activityType <- read.table(paste(dataFolder, "activity_labels.txt", sep=spe))
features <- read.table(paste(dataFolder, "features.txt", sep=spe))

#Read and combine train data
xTrain <- read.table(paste(trainFolder, "X_train.txt", sep=spe))
yTrain <- read.table(paste(trainFolder, "y_train.txt", sep=spe))
subjectTrain <- read.table(paste(trainFolder, "subject_train.txt", sep=spe))
train <- cbind(xTrain, yTrain, subjectTrain)

#Read and combine test data
xTest <- read.table(paste(testFolder, "X_test.txt", sep=spe))
yTest <- read.table(paste(testFolder, "y_test.txt", sep=spe))
subjectTest <- read.table(paste(testFolder, "subject_test.txt", sep=spe))
test <- cbind(xTest, yTest, subjectTest)

#Merge train and test data into one dataset 'data'
data <- rbind(train, test)

#Add colume names to 'data'
colnames(data) <- features[, 2]
colnames(data)[562] <- "activity"
colnames(data)[563] <- "subject"

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#==========================================================================================

colSelected<- c(grep("-(mean|std)\\(\\)", colnames(data)), 562, 563)
data <- data[, colSelected]

#3. Uses descriptive activity names to name the activities in the data set
#=========================================================================

data$activity <- activityType[data$activity, 2]

#4. Appropriately labels the data set with descriptive variable names. 
#=====================================================================

names(data) <- gsub("^t", "time", names(data))
names(data) <- gsub("^f", "frequency", names(data))
names(data) <- gsub("-mean\\(\\)", "-mean", names(data))
names(data) <- gsub("-std\\(\\)", "-standardDeviation", names(data))
names(data) <- gsub("Acc", "Accelerometer", names(data))
names(data) <- gsub("BodyBody", "Body", names(data))
names(data) <- gsub("Gyro", "Gyroscope", names(data))
names(data) <- gsub("Mag", "Magnitude", names(data))

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#=================================================================================================================================================

library(plyr)
tidy <- aggregate(. ~ activity + subject, data, mean)
tidy <- tidy[order(tidy$activity, tidy$subject),]
write.table(tidy, file="tidyData.txt", row.names=FALSE)
