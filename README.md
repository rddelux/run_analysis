RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR
-----------------------------------------------------------------------------------------------------------------------------------
Coursera: Getting and Cleaning Data  
Week 3
Course Project:  run_analysis.R
README.txt file
-----------------------------------------------------------------------------------------------------------------------------------
22 Apr 2015
-----------------------------------------------------------------------------------------------------------------------------------
RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR



-----------------------------------------------------------------------------------------------------------------------------------
Project Description:
-----------------------------------------------------------------------------------------------------------------------------------

Create one R script called run_analysis.R that does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
for each activity and each subject.


-----------------------------------------------------------------------------------------------------------------------------------
Getting the files
-----------------------------------------------------------------------------------------------------------------------------------

Set up a working directory, which contains the downloaded, unzipped data file
ie, download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
I found it was easier to just manually download and unzip the file into my working directory.
setwd("C:/Users/Admin/Documents/Coursera/Getting and Cleaning/Cource Project/")

-----------------------------------------------------------------------------------------------------------------------------------
Reading the files
-----------------------------------------------------------------------------------------------------------------------------------


Open the following librarys to allow data.table operations, and sorting commands.

library(data.table)
library(dplyr)

Once these are open read the test.txt data into the R objects
Read the train .txt data into the R objects
Read the features, and activity_labels .txt files into the R objects


-----------------------------------------------------------------------------------------------------------------------------------
PART 1: 
-----------------------------------------------------------------------------------------------------------------------------------
Merge the training and the test sets to create one data set.
Create a new data.table that binds the 2 sets


-----------------------------------------------------------------------------------------------------------------------------------
PART 2:
-----------------------------------------------------------------------------------------------------------------------------------
Extract only the measurements on the mean and standard deviation for each measurement. 
Use grep to search the headers of the newly created table for instances of "mean()", and "std()"
Clean and sort the extracted data into a new data.table.


-----------------------------------------------------------------------------------------------------------------------------------
PART 3:  
-----------------------------------------------------------------------------------------------------------------------------------
Use descriptive activity names to name the activities in the data set
Use the names from the activity_labels.txt files to rename the varibles in assignments column of allData.
Note I tried to do this with a parsed object created by reading from the activity object created earlier,
but I ran into problems matching data types, so I just created a vector with names in quotation marks.  
Next a loop was used to look for a number 1 - 6 and matches it with a the corresponding activity.


-----------------------------------------------------------------------------------------------------------------------------------
PART 4:
-----------------------------------------------------------------------------------------------------------------------------------
Appropriately label the data set with descriptive variable names. 
This was accomplished by transposing the names from features file to the headers of xTest and xTrain
Since only numbers were listed for participants, I decided to get creative and make a vector with 30 names,
I tried to be representative of all nationalities.  The for loop looks for the numbers 1 - 30 and matches it 
with a corresponding name from the namedParticipants vector.


-----------------------------------------------------------------------------------------------------------------------------------
PART 5: 
-----------------------------------------------------------------------------------------------------------------------------------
Create a second, independent tidy data set with the average of each variable for each activity and each subject.
The following creates a new data.table, and applys the .SD (standard deviation) and mean (average) to all 
the elements of the column.


-----------------------------------------------------------------------------------------------------------------------------------
Write the Data to a .txt file
-----------------------------------------------------------------------------------------------------------------------------------
The tidyData data.table in finally written to a text file.
