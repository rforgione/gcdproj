run_analysis <- function() {
    # function to merge train and test sets
    X_train <- read.table("data/train/X_train.txt")
    X_test <- read.table("data/test/X_test.txt")
    
    complete_set <- rbind(X_train, X_test)
    dim(complete_set)
    
    # function to extract only mean and standard deviation for each measurement
    features <- as.character(read.table("data/features.txt")[,2])
    
    relcol <- grep("mean\\(\\)|std\\(\\)", features)
    
    reduced_set <- complete_set[,relcol]
    dim(reduced_set)
    
    # Use descriptive activity names to name the activities in the data set
    features <- features[relcol]
    
#     features <- gsub("tBodyAccJerk", "timeSignalAccelerometerJerk", features)
#     features <- gsub("tBodyAccMag", "timeSignalBodyAccelerometerMagnitude", features)
#     features <- gsub("tBodyAcc", "timeSignalBodyAccelerometer", features)
#     
#     features <- gsub("tGravityAccMag", "timeSignalGravityAccelerometerMagnitude", features)
#     features <- gsub("tGravityAcc", "timeSignalGravityAccelerometer", features)
#     
#     features <- gsub("tBodyGyroJerkMag", "timeSignalGravityGyroscopeJerkMagnitude", features)
#     features <- gsub("tBodyGyroJerk", "timeSignalBodyGyroscopeJerk", features)
#     features <- gsub("tBodyGyroMag", "timeSignalGravityGyroscopeMagnitude", features)
#     features <- gsub("tBodyGyro", "timeSignalBodyGyroscope", features)
#     
#     features <- gsub("fBodyAccJerk", "fourierBodyAccelerometerJerk", features)
#     features <- gsub("fBodyAccMag", "fourierBodyAccelerometerMagnitude", features)
#     features <- gsub("fBodyAcc", "fourierBodyAccelerometer", features)
#     
#     features <- gsub("fBodyGyroJerkMag", "fourierBodyGyroscopeJerkMagnitude", features)
#     features <- gsub("fBodyGyroMag", "fourierBodyGyroscopeMagnitude", features)
#     features <- gsub("fBodyGyro", "fourierBodyGyroscope", features)
#     
#     features <- gsub("fBodyAccJerkMag", "fourierBodyAccelerometerJerkMagnitude", features)
#     
#     features <- gsub("fBodyBodyAccJerkMag", "fourierBodyBodyAccelerometerJerkMagnitude", features)
#     features <- gsub("fBodyBodyGyroAccJerkMag", "fourierBodyBodyGyroscopeAccelerometerJerkMagnitude", features)
#     features <- gsub("fBodyBodyGyroMag", "fourierBodyBodyGyroscopeMagnitude", features)
#     features <- gsub("fBodyBodyGyroJerkMag", "fourierBodyBodyGyroscopeJerkMagnitude", features)
#     
#     features <- gsub("-mean\\(\\)", "Mean", features)
#     features <- gsub("-std\\(\\)", "StandardDeviation", features)
#     
#     features <- gsub("-X", "XAxis", features)
#     features <- gsub("-Y", "YAxis", features)
#     features <- gsub("-Z", "ZAxis", features)
    
    features <- gsub("^t", "timeSignal", features)
    features <- gsub("^f", "fourierSignal", features)
    features <- gsub("Acc", "Accelerometer", features)
    features <- gsub("Mag", "Magnitude", features)
    features <- gsub("Gyro", "Gyroscope", features)
    
    features <- gsub("-mean\\(\\)", "Mean", features)
    features <- gsub("-std\\(\\)", "StandardDeviation", features)
    
    features <- gsub("-X", "XAxis", features)
    features <- gsub("-Y", "YAxis", features)
    features <- gsub("-Z", "ZAxis", features)
    
    features
    
    # Appropriately label the data set with descriptive variable names
    
    
    # Create a second, independent tidy data set with the average of each variable for each activity and each subject
}