# DataCleaningAssignment
This is the course project for the Getting and Cleaning Data.
Explaination for R script "run_analysis.R" included below:

1. Download the dataset - check if it is already existed in the working directory
2. Load the activity and feature info
3. Loads both the training and test datasets, filtered on columns which
   reflect a mean or standard deviation
4. Loads and Merges the two datasets
6. Converts the "activity" and "subject" columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

The end output is shown in the file "result.txt".
