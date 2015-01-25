###Code Book for Course Project of Getting and Cleaning Data
This code book describes the variables, the data, and any transformations or work that I performed to clean up the data.

####The Data
The raw data is download from:  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
To reproduce the work, you can unzip the file and place the folder **UCI HAR Dataset** inside your working directory and follow the code in **run_analysis.R**.

####The Variable
- **activityType** - Activity code table that loaded from activity_labels.txt
- **features** - Name of the features/column in xTrain/xText that loaded from features.txt
- **xTrain** - Train data that loaded from train/x_train.txt
- **yTrain** - Activity type ID of **train** data that loaded from train/y_train.txt
- **subjectTrain** - Contains ID of the **train** subject who carried out the experiment. It's loaded from train/subject_train.txt
- **train** - The combined **train** data
- **xTest** - Test data that loaded from test/x_test.txt
- **yTest** - Activity type ID of **test** data that loaded from test/y_test.txt
- **subjectTest** - Contains ID of the **test** subject who carried out the experiment. It's loaded from test/subject_test.txt
- **test** - The combined **test** data
- **data** - Data frame that combines both **train** and **test** data
- **colSelected** - Number vector that contains column numbers of measurements on mean or standard deviation only
- **tidy** - The second, independent tidy data set with the average of each variable for each activity and each subject

####The Transformation or Work
1. Merges the training and the test sets to create one data set.
  - Read **activityType** and **features**
  - Read and combine ""train** data
  - Read and combine **test** data
  - Merge **train** and **test** data into one dataset **data**
  - Add colume names to **data**
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent **tidy** data set with the average of each variable for each activity and each subject.
6. Order **tidy** dataset by **activity** and **subject** then write it to text file with write.table() using row.name=FALSE
