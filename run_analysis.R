library(dplyr)
library(datasets)
library(reshape2)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt",col.names=c("activity_id","activity_name"))
features <- read.table("./UCI HAR Dataset/features.txt")
feature_names <-  features[,2]

train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(train_data) <- feature_names
train_subject_id <- read.table("./UCI HAR Dataset/train/subject_train.txt")
colnames(train_subject_id) <- "subject_id"
train_activity_id <- read.table("./UCI HAR Dataset/train/Y_train.txt")
colnames(train_activity_id) <- "activity_id"

test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(test_data) <- feature_names
test_subject_id <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(test_subject_id) <- "subject_id"
test_activity_id <- read.table("./UCI HAR Dataset/test/Y_test.txt")
colnames(test_activity_id) <- "activity_id"

traindata <- cbind(train_subject_id , train_activity_id , train_data)
testdata <- cbind(test_subject_id , test_activity_id , test_data)
all_data <- rbind(traindata,testdata)

mean_col_idx <- grep("mean",names(all_data),ignore.case = TRUE)
mean_col_names <- names(all_data)[mean_col_idx]
std_col_idx <- grep("std",names(all_data),ignore.case = TRUE)
std_col_names <- names(all_data)[std_col_idx]
meanstddata <-all_data[,c("subject_id","activity_id",mean_col_names,std_col_names)]
descrnames <- merge(labels,meanstddata,by.x="activity_id",by.y="activity_id",all=TRUE)
data_melt <- melt(descrnames,id=c("activity_id","activity_name","subject_id"))
mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)
write.table(mean_data,"./UCI HAR Dataset/tidy_data.txt", row.names = FALSE)
