The raw data for this database comes from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
A full discription of this data is avaliable at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The files were downloaded, and unzipped into a folder called
"UCI HAR Dataset" in my working directory

These variables were created to read raw data files into an R objects from the "UCI HAR Dataset".

  xTest: "x_test.txt"
	yTest: "y_test.txt"
	subjectTest: "subject_test.txt"
	xTrain:  "x_train.txt"
	yTrain:  "y_train.txt"
	subjectTrain:  "subject_train.txt"
	features:  "features.txt"
	activities:  "activity_labels.txt"

These functions were used to transpose header names from features into xTest, and xTrain.

	colnames(xTest) <- t(features[2])
	colnames(xTrain) <- t(features[2])

This veriable was used to create a new combined dataset of xTest and xTrain.

	allData

These varibles were created to store a vector of all instances of "mean()" 
or "std()" as well as "assignment and "participants" in allData.

	getMean
	getStDev
	assignment
	participants

This varibable creates a new dataset that combines only participants, assignments,
and any observed instanse of a varible the contains the string "Mean()" or "std()".

	statData

This variable creates a new dataset of which is a sorted version of statData.

	cleanStatData

These varibles are character vecorts that store string values of activities, and 
and names for participants.

	namedassignments
	namedParticipants

This variable creates a datatable from cleanStatData.

	allData.dt

This variable creates a final dataset that sorts allData.dt by first by participants
and then by activity.

	tidyData
