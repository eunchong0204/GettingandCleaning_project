## 1. Merges the training and the test sets to create one data set.
#Package install and load.
install.packages("data.table")
install.packages("dplyr")
install.packages("plyr")
install.packages("stringr")
library(data.table)
library(plyr)
library(dplyr)
library(stringr)

#download file.

if(!file.exists("data")){
        dir.create("data")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./data/UCI HAR Dataset.zip")
dateDownload <- data()



#Unzip the file.
unzip("./data/UCI HAR Dataset.zip", exdir="./data")


#load the 'train' data files
features_train <- data.table::fread("./data/UCI HAR Dataset/features.txt"
                              , col.names=c("num", "name"))

data_train <- data.table::fread("./data/UCI HAR Dataset/train/X_train.txt"
                                , col.names=features_train$name)

subject_train <- data.table::fread("./data/UCI HAR Dataset/train/subject_train.txt"
                             , col.names="id")

activity_train <- data.table::fread("./data/UCI HAR Dataset/train/y_train.txt"
                              , col.names="activitynum")

#Bind the loaded 'train' data.
combined_train <- cbind(subject_train, activity_train, data_train)

#Add the 'origin' column
combined_train$origin <- "train"

#load the 'test' data files
data_test<- data.table::fread("./data/UCI HAR Dataset/test/X_test.txt"
                                , col.names=features_train$name)

subject_test <- data.table::fread("./data/UCI HAR Dataset/test/subject_test.txt"
                                   , col.names="id")

activity_test <- data.table::fread("./data/UCI HAR Dataset/test/y_test.txt"
                                    , col.names="activitynum")

#bind the loaded 'test' data.
combined_test <- cbind(subject_test, activity_test, data_test)

#Add the 'origin' column
combined_test$origin <- "test"


#Bind the train and test data.
combined_data <- rbind(combined_train, combined_test)



## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
data <- select(combined_data, id, activitynum, matches("mean\\(\\)|std\\(\\)"))



## 3. Uses descriptive activity names to name the activities in the data set

#Load the activity_labels file.
activitylabel <- data.table::fread("./data/UCI HAR Dataset/activity_labels.txt"
                              , col.names=c("activitynum", "label"))

#Merge data and activitylabel.
data_descriptive <- join(activitylabel,data)



## 4.Appropriately labels the data set with descriptive variable names. 
#The Column names are already assigned.



## 5.From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
data_modified <- data_descriptive %>%
        group_by(label, id) %>%
        summarise(across(.cols=matches("mean\\(\\)|std\\(\\)"), mean))

data.table::fwrite(data_modified, file = "./data/tidyData.txt", quote = FALSE)

