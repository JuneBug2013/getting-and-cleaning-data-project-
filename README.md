This is the project for getting and cleaning data Coursera course.The R script, run_analysis.r,dose the following: 

1.preparation the data.
 1)set the local directory
 2)download and unzip the dataset
 3)Unzip dataSet to /data directory

2.Merges the training and the test sets to create one data set
 1)read the training tables
 2)read the test tables
 3)read feature vector 
 4)concatenate the data tables by row
 5)add column names 
 6)merge all data in one set

3.Extracts only the measurements on the mean and standard deviation for each measurement and uses descriptive activity names to name the activities in the data set.
 1)taken Names of Features with “mean()” or “std()”
 2)read activity labels
 3)facorize Variale activity in the data frame Data using descriptive activity names
 4)turn activities & subjects into factors


4. Appropriately labels the data set with descriptive variable names.
 
5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 make second tidy data set - the result is shown in the tidy.txt file.
