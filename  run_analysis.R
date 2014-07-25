run_analysis <- function() {
    # function to merge train and test sets
    X_train <- read.table("data/train/X_train.txt")
    y_train <- read.table("data/train/y_train.txt")
    
    X_test <- read.table("data/test/X_test.txt")
    y_test <- read.table("data/test/y_test.txt")
    
    all_train <- cbind(X_train, y_train)
    all_test <- cbind(X_test, y_test)
    
    complete_set <- rbind(all_train, all_test)
    
    # function to extract only mean and standard deviation for each measurement
    features <- c(as.character(read.table("data/features.txt")[,2]), "Activity")
    
    relcol <- grep("mean\\(\\)|std\\(\\)|Activity", features)
    
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
    new_data_rows <- length(unique(reduced_set$User))*length(unique(reduced_set$Activity))
    
    new_data <- matrix(nrow=new_data_rows, ncol=new_data_cols)
    new_data <- as.data.frame(new_data)
    
    for (i in 1:length(new_data)) {
        new_data[[i]] <- aggregate(reduced_set[[i]], list(reduced_set$User, reduced_set$Activity), mean)[[3]]
    }
    
    colnames(new_data) <- colnames(reduced_set)
    
    new_data$Activity <- as.character(new_data$Activity)
    new_data$Activity[new_data$Activity == 1] <- "walking"
    new_data$Activity[new_data$Activity == 2] <- "walking_upstairs"
    new_data$Activity[new_data$Activity == 3] <- "walking_downstairs"
    new_data$Activity[new_data$Activity == 4] <- "sitting"
    new_data$Activity[new_data$Activity == 5] <- "standing"
    new_data$Activity[new_data$Activity == 6] <- "laying" 
    
    new_data <- new_data[order(new_data$User, new_data$Activity),]
    
    new_data
}