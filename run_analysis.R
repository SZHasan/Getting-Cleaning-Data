## RUN_ANALYSIS TASKS:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## PLEASE MAKE SURE THAT R PACKAGES data.table & reshape2 ARE INSTALLED 

# LOADING ACTIVITY LABELS
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# LOADING DATA COLUMN NAMES
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# TO EXTRACT ONLY THE REQUIRED MEAN & SD Extract FROM EACH MEASUREMENT.
extract_features <- grepl("mean|std", features)

# "TEST DATA" (a) loading (b) processing - X_test, y_test and subject_test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# EXTRACTING THE REQUIRED RELEVANT i.e. MEAN & SD "TEST DATA"
X_test = X_test[,extract_features]

# LOADING ACTIVITY LABELS "TEST DATA"
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# BINDING OF "TEST DATA"
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# "TRAIN DATA" (a) loading (b) processing - X_train, y_train and subject_train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# EXTRACTING THE REQUIRED RELEVANT i.e. MEAN & SD "TRAIN DATA"
X_train = X_train[,extract_features]

# LOADING ACTIVITY LABELS "TRAIN DATA"
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# BINDING OF "TEST DATA"
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# MERGING "TEST DATA" & "TRAIN DATA"
data = rbind(test_data, train_data)

# DATA LABELS ON MERGED DATA
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# FINAL DATASET -APPLYING MEAN USING 'dcast' FUNCTION 
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt", row.name = FALSE)
