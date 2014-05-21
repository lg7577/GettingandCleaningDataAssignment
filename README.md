## Subject: Getting and Cleaning Data - Final assignment

Instructions for executing the run_analysis.R file

### General info:
*	Date created: May 20th 2014
*	Author: Lior Ginzberg
*	Date last updated: May 21th 2014

### Pre-execution requirements:

1. The data for the project is in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip       
2. Extract the data to your local machine            
3. Ensure that you have UCI HAR Dataset folder with two additional sub folders (test and train) where the data was      
    extracted          
4. Check for the availability of the following files:    
4.1 **.//features.txt**      
   	  File description: Include column headers (561 columns) for all measurements. The measurements are in files (4.4)          and (4.7)              
4.2 **.//activity_labels.txt**        
      _File description_: Reference Data to label the activities in each rows of the files mentioned in files (4.4) and 
      (4.7) as: 1. LAYING 2. SITTING 3. STANDING 4.WALKING 5. WALKING_DOWNSTAIRS and 6. WALKING_UPSTAIRS
4.3 **.//test//subject_test.txt** 
      File description: Contain the ID of the volunteers who performed the measurements for each of the rows in the 
      X_train file (4.4)      
4.4 **.//test//X_test.txt**       
      File description: Contain measurements for 30% of the population        
4.5 **.//test//Y_test.txt**       
      File description: Contain the activity ID for the (4.4) file. See also (4.2)     
4.6 **.//train//subject_train.txt**       
      File description: Contain the ID of the volunteers who performed the measurements for each of the rows in the 
      X_train file (4.7)      
4.7 **.//train//X_train.txt**     
      File description: Contain measurements for 70% of the population        
4.8 **.//train//Y_train.txt**     
      File description: Contain the activity ID for the (4.7) file. See also (4.2)     

5. Set you work directory (setwd()) to the same folder you extracted the zip file      
5. Install the packages sqldf, reshape and reshape2 prior to code execution        

### Execution flow:

1.	Row bind files (4.4) & (4.7) (date frame: Xall)  
2.	Update the column headers of the data frame from step 1 with the values from file (4.1)            
3.	Create another data frame, from the data frame in step 1 & 2, only with columns that have mean() and std() 
    calculations (date frame: Xall_mean_std)        
4.	Row bind files (4.5) & (4.8) (data frame: AllActivity)  
5.	Join the data frame from the previous step with the file from (4.2) to add column header and activity description 
    (data frame: AllActivity_Desc)  
6.	Join the data frame from the previous step with the data frame from step 3 (data frame: Xall_mean_std_act_desc)  
7.	Row bind files (4.3) & (4.6) (data frame: AllSubjects)    
8.	Join the data frame from the step 6 with the data frame from step 7 to add column header and subject ID (data 
    frame: Xall_mean_std_act_desc_SubjectID)        
9.	Melt the data frame from the previous step (data frame: xAllmelt)       
10.	Calculate average and group the averages by Subject ID and Activity Description (Final data frame: xAlldata)    
11.	Write the data frame from the last step to a txt file (final_assignment_tidy_data.txt)  

The file from step 11 was pushed to github under the link: https://github.com/lg7577/GettingandCleaningDataAssignment   

