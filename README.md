==================================================================
Getting and Cleaning Data
--Coursera Data Science Specilization Course
==================================================================

The dataset includes the following files:
=========================================
- 'README.md'

- 'run_analysis.R': Scripts that eventually generate tidy data that are submitted.

- 'features.txt': List of all features.
- 'codebook.txt': description of the contents of the tidy data file

=========================================
Steps to generate tidy data (explained in 'run_analysis.R' as well):
- step 1: merge the training and test sets to create one data set
  Since both training and test sets contain same three files: X data with 561 features, 
  Y data: actual activity label, subject label, traning and test data can be bound using rbind().
  Features are then used to label these 561 features. The three pieces are then bound using cbind(), 
  so that the merged dataset contain 563 variables: the first is the subject lable, tha last one is the activity 
  label, while the middle variables are th original features.
  
- Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
  Regular expression is used to match column names with the pattern of '-mean()' or '-std()'.
  All the variables that match the pattern above (66 variables), together with the first and last column from Step 1 
  are kept. The number of columns are 68.
 
- Step 3: Uses descriptive activity names to name the activities in the data set.
  The last variable is label from 1 to 6 standing for (1 WALKING, 2 WALKING_UPSTAIRS, 3 WALKING_DOWNSTAIRS
  4 SITTING, 5 STANDING, 6 LAYING). These numbers are converted into these descriptive activities.
  
- Step 4: Appropriately labels the data set with descriptive variable names.
  The operations including: change 't' at the begining of the variables into 'time'; beginning 'f' into 'frequency';
  "-" are removed; 'Acc' into'acceleration'; 'Gyro' into 'gyroscope'; () is removed; all characters are changed into lower case.
  
- Step 5: Creates a second, independent tidy data set with the average of each.
  Data are aggregated based on subject and activity using aggregate(). There are 180 records after this operation. 
 
  
  
  
  