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
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")

### Merges the training and the test sets to create one data set
# read the training tables
x_train <- read.table("./week4/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./week4/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./week4/UCI HAR Dataset/train/subject_train.txt")

# read the test tables
x_test <- read.table("./week4/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./week4/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./week4/UCI HAR Dataset/test/subject_test.txt")

# read feature vector 
features <- read.table('./week4/UCI HAR Dataset/features.txt')

# concatenate the data tables by row
subject <- rbind (subject_train, subject_test)
activity <- rbind (y_train,y_test) 
features <- rbind (x_train, x_test)
# add column names 
names(subject) <- c("subject")
names(activity) <- c("activity")
names(features) <- dataFeaturesNames$V2

# merge all data in one set
merge <- cbind(subject, activity)
data <- cbind(features, merge)

### Extracts only the measurements on the mean and standard deviation for each measurement.
## taken Names of Features with “mean()” or “std()”
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)] 
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
data <- subset(data,select=selectedNames)
str(data)

### Uses descriptive activity names to name the activities in the data set.
# read activity labels
activityLabels = read.table('./week4/UCI HAR Dataset/activity_labels.txt')
## facorize Variale activity in the data frame Data using descriptive activity names
# turn activities & subjects into factors
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])
data$subject <- as.factor(data$subject)
head(data$activity,50)

### Appropriately labels the data set with descriptive variable names.
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
head(data)

### creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# make second tidy data set
tidydata2 <- aggregate(. ~ subject + activity, data, mean)
tidydata2 <- tidydata2[order(tidydata2$subject, tidydata2$activity),]
# write second tidy data in txt file 
write.table(tidydata2,"tidydata2.txt",row.names = FALSE)







