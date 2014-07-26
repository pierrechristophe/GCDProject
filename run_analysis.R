##### Run_analysis.R #####
##### Make tiny Data #####

#   Step 0. Some initialization
##  Files Paths and names
library(reshape2)
library(data.table)
FileDirectory<-"UCI HAR Dataset"
FeatureFile<-"features.txt"
TrainFile<-"train/X_train.txt"
TestFile<-"test/X_test.txt"
TrainSubjectFile<-"train/subject_train.txt"
TestSubjectFile<-"test/subject_test.txt"
TrainLabelFile<-"train/y_train.txt"
TestLabelFile<-"test/y_test.txt"
ActivityLabelFile<-"activity_labels.txt"

#   Step 1. Merge the training and the test sets to create one dataset
#   Note: this will do step 4. as well.
##  Load data into r
### Feature: Read first column and remove column 1 (empty column)
Feature<-read.table(paste(FileDirectory,FeatureFile,sep="/"),stringsAsFactors=FALSE)[,-1]
### Read Train and Test and set name for column (Step 4.)
Train<-read.table(paste(FileDirectory,TrainFile,sep="/"))
names(Train)<-Feature
Test<-read.table(paste(FileDirectory,TestFile,sep="/"))
names(Test)<-Feature
###  Read and add column for subject and activity label
TrainSubject<-read.table(paste(FileDirectory,TrainSubjectFile,sep="/"))
names(TrainSubject)<-c("Subject")
TrainLabel<-read.table(paste(FileDirectory,TrainLabelFile,sep="/"))
names(TrainLabel)<-c("Label")
TestSubject<-read.table(paste(FileDirectory,TestSubjectFile,sep="/"))
names(TestSubject)<-c("Subject")
TestLabel<-read.table(paste(FileDirectory,TestLabelFile,sep="/"))
names(TestLabel)<-("Label")
Train<-cbind(Train,TrainSubject)
Train<-cbind(Train,TrainLabel)
Test<-cbind(Test,TestSubject)
Test<-cbind(Test,TestLabel)
## merge
Data<-rbind(Train,Test)
#reorganize a bit so we have Activity and subject as first columns
Data<-Data[,c(562,563,1:561)]
##  Write the output
write.table(Data,file="MergedData.txt",row.names=FALSE)

#   Step2. Take only measurements on the mean and standard deviation
TestOnColumn<-grepl("mean()",names(Data))|grepl("std()",names(Data))|grepl("Subject",names(Data))|grepl("Label",names(Data))
DataExtract<-Data[,TestOnColumn]

#   Step3. Describe activities
##  Read activity
ActivityLabel<-read.table(paste(FileDirectory,ActivityLabelFile,sep="/"),stringsAsFactors=FALSE)
names(ActivityLabel)<-c("Label","Activity")
##  Merge with ActivityLabel so we can label activity
DataMerged<-merge(DataExtract,ActivityLabel)
##  Reorganize a bit so we have Activity and subject as first columns
DataMerged<-DataMerged[,c(2,82,3:81)]

#   Step 4. is done previously

#   Step 5. Compute mean
##  Names of the column to be averaged
MeasureExtract<-names(DataMerged)[-c(1:2)]
##  Melt the data by activity and subject
DataMelted<-melt(DataMerged,id=c("Subject","Activity"),measure.vars=MeasureExtract)
##  Cast the data with the mean
DataCast<-dcast(DataMelted,Activity + Subject~variable,mean)
##  Write the output
write.table(DataCast,file="Tidydata.txt",row.names=FALSE)
