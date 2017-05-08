#run_analysis script

#The data provided contains various files / folders 
#and will achieve objectives as listed out in the assignment

#Objective1: Merges the training and the test sets to create one data set.

#The training and test datasets are in different folders.
#First read the respective datasets

#Training datasets

train.subject.df <- read.table("train\\subject_train.txt", sep = "", header = FALSE)
train.X561 <- read.table("train\\X_train.txt", sep = "", header = FALSE)
train.act <- read.table("train\\y_train.txt", sep = "", header = FALSE)

#Read the Inertial signals datasets

body.acc.x <- read.table("train\\Inertial Signals\\body_acc_x_train.txt", sep = "", header = FALSE)
body.acc.y <- read.table("train\\Inertial Signals\\body_acc_y_train.txt", sep = "", header = FALSE)
body.acc.z <- read.table("train\\Inertial Signals\\body_acc_z_train.txt", sep = "", header = FALSE)


body.gyro.x <- read.table("train\\Inertial Signals\\body_gyro_x_train.txt", sep = "", header = FALSE)
body.gyro.y <- read.table("train\\Inertial Signals\\body_gyro_y_train.txt", sep = "", header = FALSE)
body.gyro.z <- read.table("train\\Inertial Signals\\body_gyro_z_train.txt", sep = "", header = FALSE)

total.acc.x <- read.table("train\\Inertial Signals\\total_acc_x_train.txt", sep = "", header = FALSE)
total.acc.y <- read.table("train\\Inertial Signals\\total_acc_y_train.txt", sep = "", header = FALSE)
total.acc.z <- read.table("train\\Inertial Signals\\total_acc_z_train.txt", sep = "", header = FALSE)

#cbind all the training datasets into a single dataframe

#Order of cbind
#1. subject (1 column)
#2. activity (1 column)
#3. total_acc_x & y & z (128 * 3 = 384)
#4. body_acc_x & y & z (128 * 3 = 384)
#5. body_gyro_x & y & z (128 * 3 = 384)
#6. T&F domain (561 columns)
#Total number of columns = 1715

train.df <- cbind(train.subject.df, train.act,
			total.acc.x, total.acc.y, total.acc.z,
			body.acc.x, body.acc.y, body.acc.z,
			body.gyro.x, body.gyro.y, body.gyro.z,
			train.X561)
#Remove all the other dataframes
rm(train.subject.df, train.act,
	total.acc.x, total.acc.y, total.acc.z,
	body.acc.x, body.acc.y, body.acc.z,
	body.gyro.x, body.gyro.y, body.gyro.z,
	train.X561)

#str(train.df)

#Read the test datasets now.

test.subject.df <- read.table("test\\subject_test.txt", sep = "", header = FALSE)
test.X561 <- read.table("test\\X_test.txt", sep = "", header = FALSE)
test.act <- read.table("test\\y_test.txt", sep = "", header = FALSE)

#Read the Inertial signals datasets

body.acc.x <- read.table("test\\Inertial Signals\\body_acc_x_test.txt", sep = "", header = FALSE)
body.acc.y <- read.table("test\\Inertial Signals\\body_acc_y_test.txt", sep = "", header = FALSE)
body.acc.z <- read.table("test\\Inertial Signals\\body_acc_z_test.txt", sep = "", header = FALSE)


body.gyro.x <- read.table("test\\Inertial Signals\\body_gyro_x_test.txt", sep = "", header = FALSE)
body.gyro.y <- read.table("test\\Inertial Signals\\body_gyro_y_test.txt", sep = "", header = FALSE)
body.gyro.z <- read.table("test\\Inertial Signals\\body_gyro_z_test.txt", sep = "", header = FALSE)

total.acc.x <- read.table("test\\Inertial Signals\\total_acc_x_test.txt", sep = "", header = FALSE)
total.acc.y <- read.table("test\\Inertial Signals\\total_acc_y_test.txt", sep = "", header = FALSE)
total.acc.z <- read.table("test\\Inertial Signals\\total_acc_z_test.txt", sep = "", header = FALSE)

#cbind all the testing datasets into a single dataframe

#Order of cbind
#1. subject (1 column)
#2. activity (1 column)
#3. total_acc_x & y & z (128 * 3 = 384)
#4. body_acc_x & y & z (128 * 3 = 384)
#5. body_gyro_x & y & z (128 * 3 = 384)
#6. T&F domain (561 columns)
#Total number of columns = 1715

test.df <- cbind(test.subject.df, test.act,
			total.acc.x, total.acc.y, total.acc.z,
			body.acc.x, body.acc.y, body.acc.z,
			body.gyro.x, body.gyro.y, body.gyro.z,
			test.X561)
#Remove all the other dataframes
rm(test.subject.df, test.act,
	total.acc.x, total.acc.y, total.acc.z,
	body.acc.x, body.acc.y, body.acc.z,
	body.gyro.x, body.gyro.y, body.gyro.z,
	test.X561)

#str(test.df)


#Objective 1: Merges the training and the test sets to create one data set.

merge.df <- rbind(train.df, test.df)

rm(train.df, test.df)

#Objective 2: Extracts only the measurements on the mean and standard deviation for each measurement.

#Extract the subject, activity and T&F domain columns from the merged dataframe

merge.df <- merge.df[, c(1:2, 1155:1715)]
#str(merge.df)

#Read the features.txt file to get the colnames
feat.col <- read.table("features.txt", sep = "", header = FALSE, stringsAsFactor = FALSE)

#This will result in 2 column dataframe. We will need just the second column.
feat.col <- feat.col[, 2]

#Create colnames for first two columns
first_two <- c("Subject", "Activity")
colnames(merge.df) <- c(first_two, as.vector(feat.col))

#Extract columns with mean and std on them

cstd <- grep("[Ss]td", as.vector(feat.col))
cmean <- grep("[Mm]ean", as.vector(feat.col))
new.col <- sort(c(cstd, cmean))
new.col <- new.col + 2 #to account for "Subject" and "Activity" columns

extract.df <- merge.df[, c(1:2, new.col)]

#str(extract.df)

#Objective 3: Uses descriptive activity names to name the activities in the data set

#Extract the activity names

act.names <- read.table("activity_labels.txt", sep = "", header = FALSE, stringsAsFactor = FALSE)

merge.df$Activity <- act.names$V2[merge.df$Activity]

#Objective 4: Appropriately labels the data set with descriptive variable names.

#ASSUMPTION: I assume that this means providing appropriate column names to the 561 columns (a bit of descriptive objective this is)

#I will tidy the column names as:
#1. Convert colnames to lower case
#2. Replace - with _

#Get the column names for the dataframe

name.col <- colnames(merge.df)
#print(name.col)
name.col <- tolower(name.col)
name.col <- gsub("-", "_", name.col)


colnames(merge.df) <- name.col

#print(name.col)


#Objective 5: 	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

print("In Objective 5")
output.df <- data.frame(matrix(0, ncol = 561, nrow = 0))
output.val <- data.frame(matrix("", ncol = 2, nrow = 0))
colnames(output.df) <- paste0("hello", c(1:561))
colnames(output.val) <- paste0("hello", c(1:2))

act.uniq <- unique(merge.df$activity)

for(subj in 1:30){
	for(act in act.uniq){
		
		temp.df <- merge.df[merge.df$subject == subj & merge.df$activity == act, ]
		temp.vec <- sapply(temp.df[, 3:563], mean)
		temp.row <- c(as.character(subj), act)
		output.df <- rbind(output.df, temp.vec, stringsAsFactors = FALSE)
		output.val <- rbind(output.val, temp.row, stringsAsFactors = FALSE)
	}
}

final.df <- cbind(output.val, output.df)

colnames(final.df) <- colnames(merge.df)

str(final.df)