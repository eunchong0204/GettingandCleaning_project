# Project in Getting and Cleaning data class

This repository is made for the project in the Getting and Cleaning data class.

The data for the project is UCI HAR Dataset.
A full description is available at the site below.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The website for downloading the data is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I binded the main datas(X_train) with subject datas(subject_train) and activity number datas(y_train). Also I used features data as the column names.

I also combined the datas for the test set in the same way. And then, I joined the two dataset. The completed data set is tidydata.txt.

I calculated the mean values by label and subject id, and saved as tidydata_mean.txt.