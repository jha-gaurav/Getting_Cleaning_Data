# Getting_Cleaning_Data
Repository for getting and cleaning data exercise
The scripts run_analysis.R does the following tasks.

Objective 1: Merge the training and the test sets to create one data set.

There are 9 different files each for training and test data respectively. The objective was to first merge all the training data initi one dataframe and test data into anothere dataframe. Then merge the training and test dataframes into a single dataframe. The resultant dataframe consists of 10299 rows and 1715 columns.
The merge was done using cbind() and rbind() commands.

#Objective 2: Extracts only the measurements on the mean and standard deviation for each measurement.

The column names are provided only for the 561 element vector, which includes the various statistics of the measurements. The mean and standard deviation are included in the column names as (Mean, mean) and (Std, std) respecively. Two separate grep functions used on the column names vector returns the locations of the occurances of mean and std respectively. The resultant vectors of these grep functions is sorted and merged together and a singe vector created. Using this vector, a subset of the dataframe is created which includes only the mean and standard deviation measurements only. The Subject and activity details are also attached as the first two columns of the resultant dataframe.

#Objective 3: Uses descriptive activity names to name the activities in the data set

There are 6 distinct activity names provided in a separate file. The activity names are extracted into a vector from this file. This file contains the index numbers as well which correspond to the occurance of the activity names, hence the index numbers are dropped.

Using this activity vector, the activity numbers in the dataframe are replaced with the activity names from the vector.

#Objective 4: Appropriately labels the data set with descriptive variable names.

ASSUMPTION: I assume that this means providing appropriate column names to the 561 columns (a bit of descriptive objective this is)

I will tidy the column names as:
1. Convert colnames to lower case
2. Replace - with _

#Objective 5: 	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To achieve this, two for loops are used, one each with the subjects and other with activities. Using the specific values for subject and activity, a sunset of the dataframe is taken, then using sapply function with the 561 colun numbers and using function mean to calculate the average of the values provided. This results in a 561 length vector. Combining the subject and activity values with these 561 valuers creates one row of the output dataframe. Repeating this operation for all the subjects and activities results in an output dataframe with 180 rows and 563 columns(subject, activity and 561 values.)
