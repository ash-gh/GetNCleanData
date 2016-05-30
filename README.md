# GetNCleanData
Getting and cleaning data project assignment

The data for this project has been taken from the courseera website. It represents data collected from the accelerometers from the Samsung Galaxy S smartphone. It was downloaded into local folder for collecting and cleaning and creating a new dataset. The dataset was divided into two sets, training and testing, which we have combined together to create a new dataset using the run_analysis.R script in Rstudio. The working directory was set to the local folder of UCI HAR dataset and the require libraries were installed and loaded. 

1. Merged the training and the test sets to create one dataset. 

  A.Read the list of features and activities into 2 data frames called featureVector and activityLabels.
  B.  Read the training and testing files into 6 data frames called subjectTrain subjectTest, activityTrain, activityTest, featuresTrain and featuresTest.
  C.  Merged them using rbind and cbind functions to get mergedData. 
  
2. Extracted only the measurements on the mean and standard deviation for each measurement.

  A.Grep function was used on the mergedData for extracting columns with mean and standard deviation, which was assigned to object, MeanStdCols.
  B.The activity and subject were added to the MeanStdCols and assigned to combinedData.
  
3. Used descriptive activity names to name the activities in the dataset.
  The activities in activityLables are assigned to combinedData through a loop function.

4. Appropriately labeled the dataset with descriptive variable names.
     The variables names in the combinedData were edited using gsub function. For example, Acc with Accelerometer, Gyro with Gyroscope, Mag with Magnitude, etc

5.  From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.
  
   A. The tidy dataset, tidyDAta, is created using aggregate and order functions.
   B. The tidyData is written to a txt file using write.table function.
