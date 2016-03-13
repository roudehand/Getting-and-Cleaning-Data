# Description of the script 

run_analysis.r is a script that does the steps required int he final course project of Gettingand Cleaning Data (see Readme)

The training and test data in combined with rbind, lookg at columns with equal entities.
The script uses only st dev and mean. Correct names are added, using features text file
Activity names and ID's are used from activity_labels.txt
Also, column names are correct
Finally, we generate a new dataset with all the average measures for each subject and activity type.

# Description of the variables the script used
- xTrain, yTrain, activityType, subjectTrain, subjectTest: variables containing data from the downloaded files (e.g. subject_text.txt, features.txt,..)
- finalTest: column binds all the Test variables
- finalTraining: column binds all the Training variables
- mergedData: rowbinds the combined Test and combined Training files
- mergedData2: variable that selects only the std dev and mean from the mergedData
- finalData: variable that uses mergedData2 and adds the activity names
- tidyData: uses finalData, uses only mean
