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