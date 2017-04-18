### data preparation
# set the local directory
getwd()
setwd("/Users/jwang/Documents")
setwd("/Users/jwang/Documents/Coursera/Cleaningdata")

# download and unzip the dataset
# data link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# save and unzip in local directory 
if(!file.exists("./week4")){dir.create("./week4")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./week4/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./week4/Dataset.zip",exdir="./week4")

### Merges the training and the test sets to create one data set
# read the training tables
x_train <- read.table("./week4/UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("./week4/UCI HAR Dataset/train/y_train.txt",header=FALSE)
subject_train <- read.table("./week4/UCI HAR Dataset/train/subject_train.txt",header=FALSE)

# read the test tables
x_test <- read.table("./week4/UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("./week4/UCI HAR Dataset/test/y_test.txt",header=FALSE)
subject_test <- read.table("./week4/UCI HAR Dataset/test/subject_test.txt",header=FALSE)

# read feature vector 
featuresname <- read.table('./week4/UCI HAR Dataset/features.txt',header=FALSE)

# concatenate the data tables by row
subject <- rbind (subject_train, subject_test)
activity <- rbind (y_train,y_test) 
features <- rbind (x_train, x_test)

str(subject)
str(activity)
str(features)

# add column names 
names(subject) <- c("subject")
names(activity) <- c("activity")
names(features) <- featuresname$V2

# merge all data in one set
merge <- cbind(subject, activity)
data <- cbind(features, merge)
 
### Extracts only the measurements on the mean and standard deviation for each measurement.
## taken Names of Features with “mean()” or “std()”
subdataFeaturesNames <- featuresname$V2[grep("mean\\(\\)|std\\(\\)", featuresname$V2)] 
subdataFeaturesNames 
selectedNames <- c(as.character(subdataFeaturesNames), "subject", "activity" )
selectedNames
newdata <-subset(data,  select = selectedNames)
   
 

### Uses descriptive activity names to name the activities in the data set.
# read activity labels
activityLabels = read.table('./week4/UCI HAR Dataset/activity_labels.txt')
## facorize Variale activity in the data frame Data using descriptive activity names
# turn activities & subjects into factors
newdata$activity <- factor(newdata$activity, levels = activityLabels[,1], labels = activityLabels[,2])
newdata$subject <- as.factor(newdata$subject)
head(newdata$activity,50)

### Appropriately labels the data set with descriptive variable names.
names(newdata)<-gsub("^t", "time", names(newdata))
names(newdata)<-gsub("^f", "frequency", names(newdata))
names(newdata)<-gsub("Acc", "Accelerometer", names(newdata))
names(newdata)<-gsub("Gyro", "Gyroscope", names(newdata))
names(newdata)<-gsub("Mag", "Magnitude", names(newdata))
names(newdata)<-gsub("BodyBody", "Body", names(newdata))
head(newdata)
names(newdata)
### creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# make second tidy data set
tidydata <- aggregate(. ~ subject + activity, newdata, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]
# write second tidy data in txt file 
write.table(tidydata,"tidydata.txt",row.names = FALSE)

