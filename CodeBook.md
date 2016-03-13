# Description of the script 

run_analysis.r is a script that does the steps required int he final course project of Gettingand Cleaning Data (see Readme)

The training and test data in combined with rbind, lookg at columns with equal entities.
The script uses only st dev and mean. Correct names are added, using features text file
Activity names and ID's are used from activity_labels.txt
Also, column names are correct
Finally, we generate a new dataset with all the average measures for each subject and activity type.

# Description of the variables the script used
- x_train, y_train, x_test, y_test, subject_train and subject_test: contain the data from the downloaded files.
- x_data, y_data and subject_data: merge the previous datasets to further analysis.
- Features: contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.

A similar approach is taken with activity names through the activities variable.
- all_data merges x_data, y_data and subject_data in a big dataset.
