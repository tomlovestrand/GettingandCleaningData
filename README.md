# GettingandCleaningData
README.md	Tom Lovestrand	06 August, 2016

This repository contains the following files:
• README.md
• codebook.md
• run_analysis.R
• meansBySubjectActivity.csv

codebook.md: describes the input data files, the processing performed by run_analysis.R and the tidy output file, meansBySubjectActivity.csv.
"run_analysis.R":  an R script which performs three tasks. First, it creates a single tidy data frame from multiple input files (described below) of 10299 observations of 561 variables. Second, it subsets the variables names to those containing a reference to mean or standard deviation (88 including “Subject” and “Activity”).  Finally, it calculates the mean value of each variable for each of the 180 unique combinations of subject and activity and writes that to the output file, “meansBySubjectActivity.csv”. 
meansBySubjectActivity.csv:  the tidy output file created by run_analysis.R.  More detail is provided in codebook.md. 
The input files used by “run_analysis.R” to create “meansBy SubjectActivity” were downloaded from: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Additional information about the input files are found in codebook.md and at the linl:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The authors of the dataset request the following citation be included in publications:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
