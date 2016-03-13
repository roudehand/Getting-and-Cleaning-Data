# Let's begin with a clean workspace
rm(list=ls()) 
 
# 1. I will firt work on the training dataset and then the test dataset, and finally merge them into one dataset

 # Use read.table to get the files from the training set 
 features     = read.table('./features.txt',header=FALSE); #imports features.txt 
 xTrain       = read.table('./train/x_train.txt',header=FALSE); #imports x_train.txt 
 yTrain       = read.table('./train/y_train.txt',header=FALSE); #imports y_train.txt 
 activityType = read.table('./activity_labels.txt',header=FALSE); #imports activity_labels.txt 
 subjectTrain = read.table('./train/subject_train.txt',header=FALSE); #imports subject_train.txt

  # Next, I will assign column names to the data sets 
 colnames(activityType)  = c('activityId','activityType'); 
 colnames(subjectTrain)  = "subjectId"; 
 colnames(xTrain)        = features[,2];  
 colnames(yTrain)        = "activityId";

 # Finally, I will create a final trainingset, using merge to merge yTrain, subjectTrain, and xTrain 
 finalTraining = cbind(yTrain,subjectTrain,xTrain);

 # Now I continue with the test dataset  
 subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
 xTest       = read.table('./test/x_test.txt',header=FALSE);  
 yTest       = read.table('./test/y_test.txt',header=FALSE);
 
 # Now the same as with training data, insert column names for test data 
 colnames(subjectTest) = "subjectId"; 
 colnames(xTest)       = features[,2];  
 colnames(yTest)       = "activityId";

 # Now I will create a merged dataset with both xTest and yTest and subjectTest 
 finalTest = cbind(yTest,subjectTest,xTest);

 # Finally, the datasets from training and test are binded by rowbind to derive at the final data set 
 mergedData = rbind(finalTraining,finalTest); 
 
 # Now I will create a vector to only select the mean and standard deviation
 colNames  = colnames(mergedData); 

 # Extract only standard deviation and the mean through a logical vector that's TRUE for std and mean
 logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames)); 
 
 # Subset finalData table based on the logicalVector to keep only desired columns 
 mergedData2 = mergedData[logicalVector==TRUE]; 
 
  # Merge the mergedData2 set withacitivityType table to get activity names 
 finalData = merge(mergedData2,activityType,by='activityId',all.x=TRUE); 
 
 # Add column names 
 colNames  = colnames(finalData);  
 
 # Add descriptive activity names, first by cleaning variable names  
 for (i in 1:length(colNames))  
 { 
   colNames[i] = gsub("\\()","",colNames[i]) 
   colNames[i] = gsub("-std$","StdDev",colNames[i]) 
   colNames[i] = gsub("-mean","Mean",colNames[i]) 
   colNames[i] = gsub("^(t)","time",colNames[i]) 
   colNames[i] = gsub("^(f)","freq",colNames[i]) 
   colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i]) 
   colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i]) 
   colNames[i] = gsub("[Gg]yro","Gyro",colNames[i]) 
   colNames[i] = gsub("AccMag","AccMagnitude",colNames[i]) 
   colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i]) 
   colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i]) 
   colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i]) 
 };

# Now I use these column names in finalData set 
colnames(finalData) = colNames; 
 
# The last part of this script is to export a tidy dataset with the averages. First Create a new table, finalDataNoActivityType without the activityType column 
finalData3= finalData[,names(finalData) != 'activityType'];

# Then use finalData3 to include only the mean 
tidyData    = aggregate(finalData3[,names(finalData3) != c('activityId','subjectId')],by=list(activityId=finalData3$activityId,subjectId = finalData3$subjectId),mean);

# Now, I combine the tidyData with activityType for descriptive acitvity names 
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE); 
 
# The tidy dataset is now exported to the course project folder   
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')
