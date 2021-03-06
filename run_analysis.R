##  Coursera Getting and Cleaning Data
##  
##  Course Project
##  Week 3
##
##  21 Apr 2015
##
##  run_analysis.R
##
##  Project Description:
##
##  Create one R script called run_analysis.R that does the following:
##  1. Merges the training and the test sets to create one data set.
##  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names. 
##  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis() 

##  Set up a working directory, which contains the downloaded, unzipped data file
##  ie, download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
##  I found it easier to just manually download and unzip the file into my working directory.
##  setwd("C:/Users/Admin/Documents/Coursera/Getting and Cleaning/Cource Project/")

##  Open the following librarys to allow data.table operations, and sorting commands.

library(data.table)
library(dplyr)

##  Read the test .txt data into the R objects created below:

xTest<- read.table("UCI HAR Dataset/test/x_test.txt")
yTest<- read.table("UCI HAR Dataset/test/y_test.txt")
subjectTest<- read.table("UCI HAR Dataset/test/subject_test.txt")

##  Read the train .txt data into the R objects created below:

xTrain<- read.table("UCI HAR Dataset/train/x_train.txt")
yTrain<- read.table("UCI HAR Dataset/train/y_train.txt")
subjectTrain<- read.table("UCI HAR Dataset/train/subject_train.txt")

##  Read the features, and activity_labels .txt files into the R objects created below:

features<- read.table("UCI HAR Dataset/features.txt")
activities<- read.table("UCI HAR Dataset/activity_labels.txt")


##  PART 4:  Appropriately label the data set with descriptive variable names. 
##  Transpose the names from features to the headers of xTest and xTrain

colnames(xTest) <- t(features[2]) 
colnames(xTrain) <- t(features[2])

xTest$assignments <- yTest[,1]
xTest$participants <- subjectTest[,1]

xTrain$assignments <- yTrain[,1]
xTrain$participants <- subjectTrain[,1]


##  PART 1  Merge the training and the test sets to create one data set.
##  Create a new data.table that binds xTest, and xTrain

allData<- rbind(xTest, xTrain)


##  PART 2  Extract only the measurements on the mean and standard deviation for each measurement. 
##  Use grep to search the headers of the newly created table for instances of "mean()", and "std()"

getMean<- grep("mean()", colnames(allData))
getStDev<- grep("std()", colnames(allData))
assignment<- grep("assignments", colnames(allData))
participants<- grep("participants", colnames(allData))

##  Clean and sort the extracted data into a new data.table.

statData<- c(participants, assignment, getMean, getStDev)

sortedData<- sort(statData)
cleanStatData<- allData[, c(1,2,sortedData)]



##  PART 3:  Use descriptive activity names to name the activities in the data set
##  Use the names from the activity_labels.txt files to rename the varibles in assignments column of allData.
##  Note I tried to do this with a more activities object created by reading from the activity object created earlier,
##  but I ran into problems matching data types, so I just created a vector with names shown below.  The for loop looks 
##  for a number 1 - 6 and matches it with a the corresponding activity.

namedassignments<- c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")

cleanStatData$assignments<- as.character(cleanStatData$assignments)

	for (i in 1:6) {
			cleanStatData$assignments[cleanStatData$assignments == i] <- namedassignments[i]
			}
cleanStatData$assignments<- as.factor(cleanStatData$assignments)


##  PART 4.  Appropriately label the data set with descriptive variable names. 
##  Since only numbers were listed for participants, I decided to get creative and make a vector with 30 names,
##  I tried to be representative of all nationalities.  The for loop looks for the numbers 1 - 30 and matches it 
##  with a corresponding name from the namedParticipants vector.


namedParticipants<- c("Amy", "Alice", "Arron", "Beth", "Bob", "Chris", "Christy", "Danny", "Devon",
		"Doug", "Ed", "Fred", "Gabe", "Heather", "Hans", "Joe", "Kristina", "Marvin", "Mike", "Nancy",
		"Olivia", "Oscar", "Phil", "Rita", "Svetlana", "Timmy", "Victor", "William", "Ulla", "Zelda")

cleanStatData$participants<- as.character(cleanStatData$participants)

	for (i in 1:30) {
		cleanStatData$participants[cleanStatData$participants == i] <- namedParticipants[i]
		}

cleanStatData$participants<- as.factor(cleanStatData$participants)


##  PART 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
##  The following creates a new data.table, and applys the .SD (standard deviation) and mean (average) to all 
##  the elements of the column.

allData.dt<- data.table(cleanStatData)
tidyData<- allData.dt[, lapply(.SD, mean), by = 'participants,assignments']

##  The tidyData data.table in finally written to a text file.

write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
