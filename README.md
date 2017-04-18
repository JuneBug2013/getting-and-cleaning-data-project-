This is the project for getting and cleaning data Coursera course.The R script, run_analysis.r,dose the following: 

1 preparation the data.
 set the local directory
 download and unzip the dataset
 Unzip dataSet to /data directory

2 Merges the training and the test sets to create one data set
 read the training tables
 read the test tables
 read feature vector 
 concatenate the data tables by row
 add column names 
 merge all data in one set

3 Extracts only the measurements on the mean and standard deviation for each measurement and uses descriptive activity names to name the activities in the data set.
 taken Names of Features with “mean()” or “std()”
 read activity labels
 facorize Variale activity in the data frame Data using descriptive activity names
 turn activities & subjects into factors


4. Appropriately labels the data set with descriptive variable names.
 
5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  make second tidy data set - the result is shown in the tidy.txt file.












Y