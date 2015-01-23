# Coursera-GetandCleanDataAssignment
Coursera course -Getting and Cleaning Data Assignment

This README file highlights some of the assumptions and ommissions that have taken along the way while working on the Coursera "Getting and Cleaning Data" course assignment.

The data used for the assignment can be obtained via this link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data set is an extract of the Human Activity Recognition experiments by Smartlab. (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). In brief,
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

In the original dataset from Smartlab; for each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The assignment requires the extraction of columns from the dataset with "mean" or "std" as part of the column description. The assumption I have made in here is that the wording "mean" and "std" is case sensitive. Therefore where column description with "Mean" of "Std" will be ignored.
Because we are only interested in the mean and std columns, the data files in the Inertial Signals folder are ignored also.
With the above assumptions, we only need a subset of these datafiles.  

They are :
activity_labels.txt
features.txt
subject_test.txt
subject_train.txt
x_test.txt
x_train.txt
y_test.txt
y_train.txt

CodebookAssignmentPart2.txt
GetDataAssignmentPart2.txt

For convenient, I have zipped these data files and the run_analysis.R file into "coursefiles.zip" and place it in the repo.

Except the two AssignmentPart2 files if all the other data files and the run_analysis.R script are in the R working folder/directory, running the run_analysis.R will generate the  final dataset file "GetDataAssignmentPart2.txt" which is required by the assignment.

The assignment requires us to produce a R script called run_analysis.R and the script should do the following.
 1.  Merges the training and the test sets to create one data set.
 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
 3.  Uses descriptive activity names to name the activities in the data set
 4.  Appropriately labels the data set with descriptive variable names. 
 5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Once the R script has loaded in the R console, it can be 'run all' to produce the final data file.
Or it can be run a section at a time by copy and paste the requireed task section.  I have divided the script into 5 tasks. Mainly they are task 1 to task 5 which correspond to the 5 steps above.

For the requirement 1 above, 
I have interpreted that "Merges the training and the test sets to create one data set" does not mean everything in one data frame. Hence I have just merged x_test and x_train data together, y_test and y_train data together and subject_test and subject_train data together.  It is further down the tasks(task 3) that these y(activity) and subject data is merged into the final set of data frame.

For requirement 5 above,
 to help traceability and to avoid misinterpretation during the processing of extracting the required columns, the variables in GetDataAssignmentPart2.txt  are mainly prefixed with AVG to original column names, the removal of the parenthesis and the replacement of dash with underscore. (i.e. for tBodyAcc-mean()-X  will become AVGtBodyAcc_mean_X).

The run_analysis.R has added comments to explain what the code is doing. 



