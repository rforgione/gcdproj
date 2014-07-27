## ReadMe

### Author: Rob Forgione
### Course: Getting and Cleaning Data

The focus of this project is the run_analysis.R script. The core functionality of the script is as follows. 

First the training and test data are imported using the read.table command. Both the training and test sets are merged with their respective y-values using the cbind function and then are bound together using the rbind function. 

The feature names are imported by using the read.table function on data/features.txt. The relevant columns are identified using regex with the grep function, where we identify all columns that contain the sequences "mean()", "std()", or "Activity" ("Activity" is the column name given to the y-values, identiying which activity was being performed). We use the relcol logic vector to index our data table by calling features\[relcol\]. 

The gsub function is then used to perform several replacements using regex in order to rename the columns and make them easier to understand for users. The adjusted column names are then applied to the dataset using the colnames function.

The subject numbers are imported using read.table and fused using rbind, then bound to the main dataset using cbind. Once the subjects are bound to the dataset, the data are ordered by subject number, as this tends to be easier to read/analyze. 

A new data set is created with 180 rows (30 subjects x 6 activities per user) and 68 columns (which matches the main dataset). The new dataset, called new_data, uses the aggregate function to fill the data set. The aggregate function is very similar to the tapply function, except it is optimized for iterating through rows based on filters in multiple columns, and performing a function on each grouping. In the main dataset, the function iterates over every combination of subject and activity (i.e. subject 1 activity 1, subject 1 activity 2, ..., subject 1 activity 6, subject 2 activity 1, subject 2 activity 2, etc., all the way through subject 30 and activity 6), and performs the mean function on each grouping (so that we get a mean in each column for every subject and every activity). 

Finally, the activity numbers are renamed to words that accurately reflect the given activities (i.e. 1 becomes "walking", 2 becomes "walking_upstairs", etc.) The as.factor function is run to ensure that the "Activity" column is of type 'factor'. The write.table function is used to write the new tidy dataset to 'tidyData.txt', and the dataset is returned by the function. 

The resulting dataset is 180 rows by 68 columns, and meets the following requirements:

* Merges training and test sets to create one data set
* Extracts the measurements for the mean and standard deviation for each measurement
* Uses descriptive activity names to label the activities in the dataset
* Is labeled with descriptive variable names
* new_data dataset is a new tidy dataset with the average of each variable for each activity and each subject
