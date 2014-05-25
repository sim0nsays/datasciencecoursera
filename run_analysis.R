features = read.table("features.txt", col.names=c("ID", "Name"))

stdMeanFeatures = features[grepl("-mean|-std", features$Name),]

activityLabels = read.table("activity_labels.txt", col.names=c("ID", "Activity"))

# Adapted from http://stackoverflow.com/questions/11672050/how-to-convert-not-camel-case-to-camelcase-in-r
# lowercase & capitalize first letters
activityLabels$Name <- sub('^(\\w?)', '\\U\\1', tolower(activityLabels$Activity), perl=T)
# remove _ and capitalize following letter
activityLabels$Name = gsub('_(\\w?)', '\\U\\1', activityLabels$Name, perl=T)

 
extractData = function (folderName) {
  sourceVariables = read.table(paste0(folderName,"/X_",folderName,".txt"))
  sourceActivity = read.table(paste0(folderName,"/y_",folderName,".txt"),col.names="ID")
  sourceSubjects = read.table(paste0(folderName,"/subject_",folderName,".txt"), col.names="SubjectID")
  sourceSubjects$SubjectID = as.numeric(sourceSubjects$SubjectID)
  
  sourceActivityWithNames = data.frame(Activity=activityLabels$Name[sourceActivity$ID])
  
  sourceStdMeanVariables = sourceVariables[,stdMeanFeatures$ID]
  names(sourceStdMeanVariables) = stdMeanFeatures$Name
  
  cbind(sourceSubjects, sourceActivityWithNames, sourceStdMeanVariables)
}

trainData = extractData("train")
testData = extractData("test")

finalData = rbind(testData, trainData)

write.table(finalData, "proccesedMeanStddata.txt",row.names=F)

library(reshape2)

dataMelt = melt(finalData,id=c("SubjectID", "Activity"))
averageMeanStdData = dcast(dataMelt, SubjectID + Activity ~ variable, mean)

write.table(averageMeanStdData, "averageMeanStddata.txt",row.names=F)