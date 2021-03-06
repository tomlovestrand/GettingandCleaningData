codebook.md	Tom Lovestrand	06 August, 2016

Project Description

This project presents several sets of position and motion data from sensors in smart phones worn by 30 test subjects as they 
performed 6 different activities. The initial data sets, representing 561 recorded and calculated variables, are collected, 
combined and cleaned then modified to create a tidy output file by the R script, “run_analysis.R”.  The output tidy file is 
a table of mean values calculated from the initial variables with “mean” or “std” (standard deviation) in their names once 
the variable values have been grouped by subject and activity. 
Additional information about the input files is found at the link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and in the file “features_info.txt” in the folder UCI HAR Dataset at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Study design and data processing
The methodology by which the raw data was collected from the subjects and processed is described in the file README.txt at 
the cloudfront link listed above.  The compressed file at that url was downloaded to a local folder “R/data” and unzipped.  
The file structure was not altered. Most notably, the folder “UCI HAR Dataset” contains two subfolders, “training” and “test”,
representing a 70% - 30% division of the collected raw data. Within each of these folders are three files: 

• “X_test.txt”, containing the smartphone data records, 

• “subject_test.txt”, identifying the subject for each record by integer, and

• “Y_test.txt”, identifying the activity for each record by integer.  

“_training” was used in place of “_test” in the files names of the training data.  

Two additional files are included in the compressed download.  

• “activity_labels” contains character labels for the 6 activities identified by integer value in the data files and 

• “features” lists the names of the variables. 

Creating the tidy data file “meansBySubjectActivity.csv”
The first step to create the tidy data output file is to read the appropriate files from the uncompressed “UCI HAR Dataset”
folder with the read.table() function and default arguments. The resulting six files and their sources are:

• testSubject (test/subject_test.txt)

• testData (test/X_test.txt)

• testActivity (test/y_test.txt)

• trainSubject (train/subject_train.txt)

• trainData (train/X_train.txt)

• trainActivity (train/y_train.txt)

• features (features.txt)

• activityLabels (activity_labels.txt)

Next, for the three files types, the “training” and “test” files are combined using the rbind() function with the resulting
data frames:

• allSubject

• allActivity

• allData
Column names are applied to the single column data frames, “allSubject” and “allActivity” with the colnames() function and 
also to the 561 column data frame,  “allData” with colnames() and the “features” file.  These labels are needed for tidy 
data. The three files are then combined with cbind() to create:

•  fullData Merge
 containing all the input data.
The next step reduces the variables to only those with names that include the string “mean” or “std” (standard deviation).  
This is done using the grep() function, ignoring columns 1 (subject) and 2 (activity), and writing the output to a numeric 
vector, “columnIndex” containing the column indices.  “columnIndex” is then used to subset “fullDataMerge” and create the 
data frame “subsetData”, reducing the number of columns (variables) from 563 to 88. 
To replace the integer values of “activity” column of “subsetData”, they are first converted to character with the 
as.character() function as are the factor values of the data frame “activityLabels”.  The function mapvalues() substitutes 
the character strings of “activityLabels” into “subsetData”.
The variable names in “subsetData” are then modified with gsub() to make them more readable, in keeping with tidy data 
principles.  The specific changes made were:

•“()-X” replaced by “(X)”

•“{}-Y” replaced by “(Y)”

• “()-Z” replaced by “(Z)”

• “std” replaced by “StDev” [standard deviation]

• “mean” replaced by “Mean”

• “^t” replaced by “TD” [time domain]

• “^f” replaced by “FD” [frequency domain]

The data is now in a tidy format and the “run_analysis.R” script continues by grouping and calculating means of the variables.
Grouping is done with the aggregate() function using the names “Subject” and “Activity” as its list arguments.  This is applied
to columns 3:88 of subsetData and the function mean() is the FUN argument.   The output of aggregate() is sent to the data 
frame:

“meansBySubjectActivity” 

with dimension 180 x 88.  Since all the initial variables were normalized (-1<=x<=1), the values of the calculated variable 
means are also bounded by +/- 1.

The R script concludes by writing the tidy data frame “meansBySubjectActivity” to the file “meansBySubjectActivity.txt” in 
the folder "./data/UCI HAR Dataset”.  
