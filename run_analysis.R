

getSummarizedDataSet <- function() 
{
  library(data.table)
  library(dplyr)
  library(plyr)
  
  #get list of measures (18 means and standard deviations)
  #merging data from training and test data sets
  measures   <- getMeasures()
  
  #get descriptive activity names associatted to each measure
  activities <- getActivities()
  
  #idenfiy the subject associatted to each measure
  subjects   <- getSubjects()
  
  #merge the three data sets above into one table
  intermediateResult <- cbind(activities, subjects, measures)
  
  # summazie the measures by acivity name and subject
  sumData <- group_by(intermediateResult, activityName, subject)
  
  #obtain approrpriate names for each measure column
  #exclude activity and subject (keep those names)
  cols <- names(sumData)[-(1:2)]
  dots <- sapply(cols,function(x) substitute(mean(x), list(x=as.name(x))))
  result <- do.call(dplyr::summarize, c(list(.data=sumData), dots))
  
  #write dataset to csv file
  write.csv(result,"tidyDataSet.csv")
  # write as txt per assignment
  write.table(result,"tidyDataSet.txt", row.name=FALSE)
}


getActivities <- function() 
{
  setwd("E:/Documents/education/RData")
  activities <- rbind(dplyr::rename(data.table(read.table("./UCI HAR Dataset/train/y_train.txt")),activityId=V1),
                      dplyr::rename(data.table(read.table("./UCI HAR Dataset/test/y_test.txt")),activityId=V1))
  
  select(join(activities, getActivityLabels()),2)
}

getActivityLabels <- function() 
{
  setwd("E:/Documents/education/RData")
  activitytLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  dplyr::rename(data.table(activitytLabels),activityId=V1, activityName=V2)
}

getSubjects <- function() 
{
  setwd("E:/Documents/education/RData")
  subjects <- rbind(read.table("./UCI HAR Dataset/train/subject_train.txt"),
                    read.table("./UCI HAR Dataset/test/subject_test.txt"))
  dplyr::rename(data.table(subjects),subject=V1)  
}

getMeasures <- function() 
{
  setwd("E:/Documents/education/RData")
  newColNames <- getFeatureNames()
  measures <- rbind(data.table(read.table("./UCI HAR Dataset/train/X_train.txt")),
                    data.table(read.table("./UCI HAR Dataset/test/X_test.txt")))
  
  renanmedMeasures <- setnames(measures, colnames(measures), newColNames)
  meanMeasures <- select(renanmedMeasures,contains("mean"))
  stdMeasures  <- select(renanmedMeasures,contains("std"))
  cbind(meanMeasures, stdMeasures)
}

getFeatureNames <- function() 
{
  setwd("E:/Documents/education/RData")
  measures <- read.table("./UCI HAR Dataset/features.txt")
  t(select(data.table(measures),2))
}
