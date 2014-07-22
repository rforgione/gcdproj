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
    
    # Appropriately label the data set with descriptive variable names
    
    colnames(reduced_set) <- features
    
    # Create a second, independent tidy data set with the average of each variable for each activity and each subject
    
    train_users <- read.table("data/train/subject_train.txt")
    test_users <- read.table("data/test/subject_test.txt")
    
    users <- rbind(train_users, test_users)
    colnames(users) <- "User"
    
    reduced_set <- cbind(users, reduced_set)
    reduced_set <- reduced_set[order(reduced_set$User),]
    
    new_data_cols <- dim(reduced_set)[2]
    new_data_rows <- length(unique(reduced_set$User))
    
    new_data <- matrix(nrow=new_data_rows, ncol=new_data_cols)
    new_data <- as.data.frame(new_data)
    
    for (i in 1:length(new_data)) {
        new_data[[i]] <- tapply(reduced_set[[i]], reduced_set$User, mean)
    }
    
    colnames(new_data) <- colnames(reduced_set)
    
    print(colnames(new_data))
    dim(new_data)
}