## This R script is created as part of the Cousera course "Getting and Cleaning Data" asignment.
## Please read the Readme.md before running the script. The ReadMe.Md contains the requirements for this assignment.
## It is assumed that all required data can be located in the R working directory/folder before this script is run.
## From time to time you will see nrow and ncol functions appear on the script. These are checkers to
##   ensure the data is reading and transforming correctly.     
##
##
## This run_analysis.R does the following. 
##  1.  Merges the training and the test sets to create one data set.
##  2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3.  Uses descriptive activity names to name the activities in the data set
##  4.  Appropriately labels the data set with descriptive variable names. 
##  5.  From the data set in step 4, creates a second, independent tidy data set with the average of 
##      each variable for each activity and each subject.


## remove all varibles
##  load dplyr package
rm(list=ls())
library(dplyr)

## Task 1. Merges the training and the test sets to create one DATA SET. -- (not data frame)
## The final set of data contains allxdata, allydata, allsubjectdata and featuredata
## Use str(--dataobject--) to check all 561 columns are loaded
## use all(colSums(is.na(--dataobject--))==0)  to check any NA in the columns. 
##   The boolean value of TRUE should be returned if no missing values are found.
##

xtestdata<- read.table("x_test.txt")
ytestdata<- read.table("y_test.txt")
subjecttestdata<- read.table("subject_test.txt")

xtraindata<- read.table("x_train.txt")
ytraindata<- read.table("y_train.txt")
subjecttraindata<- read.table("subject_train.txt")

featuredata<- read.table("features.txt")

##   check all rows are read successfully
nrow(xtestdata)
nrow(ytestdata)
nrow(subjecttestdata)
nrow(xtraindata)
nrow(ytraindata)
nrow(subjecttraindata)
nrow(featuredata)

##
##  append train data rows to test data
##
allmeasdata <- rbind(xtestdata,xtraindata)				## measurements data
allactidata <- rbind(ytestdata,ytraindata)				## activities  data
allsubjectdata <- rbind(subjecttestdata,subjecttraindata)		## subjects data

##  check all rows appended successfully
nrow(allmeasdata)
nrow(allactidata)
nrow(allsubjectdata)

##  Task 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
##       
##  use the feature names to identify the columns by adding these descriptions to the dataset as a row
##   and then use the combination of which(), apply() and grepl() to extract the required columns
##   i.e. only those mean and std columns.  
##  Also insert the feature description as the column headings at this stage to simplify task 4 later
##  
##


## transpose the feature dataset and append allmeasdata rows to the feature decriptions.

xtemp <- t(featuredata)
allmeasdata <- rbind(xtemp[2,],allmeasdata)				## add feature descriptions as a row in allmeasdata

ncol(xtemp)
ncol(allmeasdata)

for(i in 1:561)
{colnames(allmeasdata)[i] <- as.character(featuredata[i,2])}		## use feature descriptions as the columns header


allmeasdata<-allmeasdata[,which(apply(allmeasdata,2,function(x) any(grepl("mean",x)|grepl("std",x))))]		## extract those mean and std columns

allmeasdata <- allmeasdata[2:nrow(allmeasdata),]			## remove the feature descriptions row - the first row

nrow(allmeasdata)
ncol(allmeasdata)


##  Task 3.  Uses descriptive activity names to name the activities in the data set
##  Add the Activity and Subject columns to the data frame.
##  Activity descriptions are found on activity_labels.txt
##

allactilabels <- mutate(allactidata,label = ifelse(V1==1,"WALKING",ifelse(V1==2,"WALKING_UPSTAIRS",ifelse(V1==3,"WALKING_DOWNSTAIR",ifelse(V1==4,"SITTING",ifelse(V1==5,"STANDING",ifelse(V1==6,"LAYING","NA")))))))		## add label against activity data


alldata  <- cbind(allmeasdata,Activity=allactilabels[,2])				## append activity labels column to allmeasdata

alldata  <- cbind(alldata,Subject=allsubjectdata[,1])					## append subject column to alldata



##  Task 4.  Appropriately labels the data set with descriptive variable names. 
##   The labels were almost done on previous step. Just a little tidy up to do here
##


colnames(alldata) <- sub("\\()","",names(alldata),)					## remove the bracket () in the column name description
colnames(alldata) <- gsub("-","_",names(alldata),)

names(alldata)[2]




##  Task 5.  From the data set in step 4, creates a second, independent tidy data set with the average of 
##      each variable for each activity and each subject.



part2data <- alldata

for (i in 1:79) 
{ part2data[i] <- as.numeric(part2data[[i]])
  colnames(part2data)[i] <- paste("AVG",colnames(part2data)[i],sep="")			## prefix the column names with AVG
}


part2data_tbl <- tbl_df(part2data)
by_subject_activity <- group_by(part2data_tbl,Subject,Activity)				## set up group by table

##summarise_each(by_subject_activity, funs(mean))  - calculate the average/mean and produce the output txt file

write.table(summarise_each(by_subject_activity, funs(mean)),file="GetDataAssignmentPart2.txt",row.name=FALSE)


