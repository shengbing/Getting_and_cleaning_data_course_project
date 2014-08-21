#get fileurl
fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
#download zipfile
download.file(fileUrl, destfile = "C:/Users/Shengbing/Documents/R/getting_cleaning_data/projectData", method ='auto', mode = 'wb')

#mannually exact zipfile

#set working directory
setwd('C:/Users/Shengbing/Documents/R/getting_cleaning_data/projectData~/UCI HAR Dataset')


#read traning date into R
X_train = read.table('./train/X_train.txt')
y_train = read.table('./train/y_train.txt')
subject_train = read.table('./train/subject_train.txt')
dim(X_train)
dim(y_train)
dim(subject_train)

#read testing date into R
X_test = read.table('./test/X_test.txt')
y_test = read.table('./test/y_test.txt')
subject_test = read.table('./test/subject_test.txt')
dim(X_test)
dim(y_test)
dim(subject_test)

#step 1: merge the training and test sets to create one data set
X_data = rbind(X_train, X_test); #
y_data = rbind(y_train, y_test);
names(y_data) = 'activity';
subject = rbind(subject_train, subject_test);
names(subject) = 'subject';
dim(X_data)
dim(y_data)
dim(subject)
#read features
features = read.table('./features.txt')
#names X_data using features
names(X_data) = features[, 2];
data = cbind(subject, X_data, y_data); #'data' is the merged data set; the first collum is the subjects;
#the last collumn is y_data, i.e, activity labels




#step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#using regular expression to match col names with the patter of '-mean()-' or 'std()'
#
#idx_match: character vector containing only the measurements on the mean 
#and standard deviation for each measurement.
idx_match = grep('-(mean|std)\\(\\)', names(data)); 
#col names that need to be kept
col_kept = c(1, idx_match, dim(data)[2]);
#'first_dataset' is extracted  from 'data' and contains 
#subject label (first col), activity label (last col) and
#the measurements on the mean and standard deviation for each measurement
first_dataset = data[, col_kept];



#step 3: Uses descriptive activity names to name the activities in the data set
#the fist column of 'first_dataset' is renames as a factor with activity labels: 
#(1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING)
activity_labels = read.table('./activity_labels.txt');
first_dataset[[names(first_dataset)[length(names(first_dataset))]]] = factor(first_dataset$activity, labels = activity_labels[, 2]);

#step 4: Appropriately labels the data set with descriptive variable names. 
#replace 't' with 'time'
names(first_dataset) = sub('^t', 'time', names(first_dataset));
#replace 'f' with 'frequency'
names(first_dataset) = sub('^f', 'frequency', names(first_dataset));
#remove '-'
names(first_dataset) = gsub('-', '', names(first_dataset));
#replace 'Acc' with 'acceleration'
names(first_dataset) = sub('Acc', 'acceleration', names(first_dataset));
#replace 'Gyro' with 'gyroscope'
names(first_dataset) = sub('Gyro', 'gyroscope', names(first_dataset));
#remove '()'
names(first_dataset) = sub('\\(\\)', '', names(first_dataset));
#to lower case
names(first_dataset) = tolower(names(first_dataset));
names(first_dataset);
dim(first_dataset)


#5: Creates a second, independent tidy data set with the average of each 
#variable for each activity and each subject. 
num_cols = dim(first_dataset)[2];
second_dataset = aggregate(first_dataset[,2:num_cols-1], list(first_dataset[, num_cols], first_dataset[, 1]), mean)
second_dataset$Group.2 = NULL;
names(second_dataset)[1] = 'activity';
write.table(second_dataset, file = './tidydata.txt', row.name = F)

