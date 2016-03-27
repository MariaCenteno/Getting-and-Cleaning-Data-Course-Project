# Study Design

The data was collected from the web page of the Center for Machine Learning and Intelligent Systems from an experiment called Human Activity Recognition Using Smartphones Data Set.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

# Code Book

Variables and data description:
180 observations of 88 variables that contain the mean and the standard deviation from time and frequency variables from the experiment.

Transformations or work performed to clean up the data:
Download and unzip the dataset, read the files and merges the information to create one data set, rename the variables, extracts only the measurements on the mean and standard deviation, change the numeric values in the activity variable for the name of the activities, rename the variables with the respective word according to its prefix in order to label appropriately the data set with descriptive variable names and calculate the mean of each variable to create and independent tidy data set.
