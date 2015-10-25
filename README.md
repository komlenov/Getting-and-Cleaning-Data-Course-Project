The run_analysis.R script reads data from the UCI HAR dataset:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

and it produces a tidy dataset which can be used for further analysis.

The description of the "tidy_data.txt" is in the "CodeBook.md".  
  
The run_analysis.R script loads the R packages "reshape2", "dplyr", "tidyr" using library function. Then it reads all the required txt files of the given datasets. Appropriate "activity_id"'s and "subject_id"'s are appended to the "training" and the "test" data, and then they are combined into one single data frame. Afterwards the mean() and std() values are extracted using "grep" function and new data frame including activity_id and subject_id with mean() and std() is created. Using the "merge" fuction one dataset with activity names is created. Finally using "melt" and "dcast" functions the data is converted into a table containing mean values of all the included features and the data is written to the "tidy_data.txt" file.
