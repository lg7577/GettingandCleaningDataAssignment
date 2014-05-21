#Set the work directory

#setwd("C:\\Personal\\Coursera\\Getting and cleaning data\\UCI HAR Dataset")

# Download all the relevant files. Relevant files are:
#1. feature.txt: header for all 561 measurement fields
#2. X_train.txt: represent results for 70% of population
#3. X_test.txt: represent results for 30% of population
#4. subject_train.txt: train volunteer ID
#5. subject_test.txt: test volunteer ID
#6. Y_train.txt: Activity ID for train measurements
#7. Y_test.txt: Activity ID for test measurements
#8. activity_label.txt: description of activity ID (files mentioned in #6 & #7)

FeatureFile <- read.table(".//features.txt", header = FALSE)
ActivityLabels <- read.table(".//activity_labels.txt", header = FALSE)

SubjectTest <- read.table(".//test//subject_test.txt", header = FALSE)
Xtest <- read.table(".//test//X_test.txt", header = FALSE)
Ytest <- read.table(".//test//Y_test.txt", header = FALSE)

SubjectTrain <- read.table(".//train//subject_train.txt", header = FALSE)
Xtrain <- read.table(".//train//X_train.txt", header = FALSE)
Ytrain <- read.table(".//train//Y_train.txt", header = FALSE)

#Union all measurements into one data frame
Xall <- rbind(Xtest, Xtrain)

#Add column names to the Xall data frame

names(Xall) <- FeatureFile$V2

# extract columns with "-mean()" or "-std()" in their name

Xall_mean_std <- Xall[,grep("*-mean()*|*-std()*", colnames(Xall))]

#Union Y_test and Y_train as to have one data frame with activity code that will 
#corrrspond to the data frame (Xall_mean_std) with all the measurements. 
#ensure meaningful column name and merge it with the Xall_mean_std data frame.

#require(sqldf)
AllActivity <- rbind(Ytest, Ytrain)
AllActivity_Desc <- sqldf("select AA.V1, AL.V2 from AllActivity AA, ActivityLabels AL where AA.V1 = AL.V1")
names(AllActivity_Desc) <- c("Activity_ID", "Activity_Desc")
Xall_mean_std_act_desc <- cbind(Xall_mean_std, AllActivity_Desc$Activity_Desc)
colnames(Xall_mean_std_act_desc)[80] <- "Activity_Desc"

#Union SubjectTest and SubjectTrain as to have one data frame with the ID of all 
#volunteers that will corrrspond to the data frame (Xall_mean_std_act_desc) with all the measurements. 
#ensure meaningful column name and merge it with the Xall_mean_std_act_desc data frame.

AllSubjects <- rbind(SubjectTest, SubjectTrain)
names(AllSubjects) <- c("Subject_ID")
Xall_mean_std_act_desc_SubjectID <- cbind(Xall_mean_std_act_desc, AllSubjects$Subject_ID)
colnames(Xall_mean_std_act_desc_SubjectID)[81] <- "Subject_ID"

#Create the 2nd tidy data set to show the average of all mean() and std() columns group
#by activity description and subject ID.Write the tidy data set to a file.

#require(reshape)
#require(reshape2)
var_name <- colnames(Xall_mean_std_act_desc_SubjectID[,1:79])
xAllmelt <- melt(Xall_mean_std_act_desc_SubjectID,id=c("Activity_Desc","Subject_ID"),measure.vars=var_name)
xAlldata <- dcast(xAllmelt, Subject_ID + Activity_Desc ~ variable, mean)

write.table(xAlldata, file="final_assignment_tidy_data.txt", row.names=FALSE, col.names=TRUE, sep=",", quote=FALSE)
