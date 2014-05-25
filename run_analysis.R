# read "columnID,name" of interesting columns
interesting_columns <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/interesting_features.txt", 
                                header=FALSE,
                                col.names = c('colID', 'measurementName'),
                                sep = ' ');

activity_names <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/activity_labels.txt", 
                   header=FALSE, 
                   col.names = c('activityID','activityName'),
                   sep = ' ');

#===============================================================================
# parse TEST dataset

# read activities
y_test <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/test/y_test.txt", 
        header=FALSE, 
        col.names = c('activityID'));

# read subjects
subject_test <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/test/subject_test.txt", 
        header=FALSE, 
        col.names = c('subjectID'));

# read dataset with ALL measurements
test_dataset <- read.fwf("~/projects/R/assignment3/UCI HAR Dataset/test/X_test.txt",
        header=FALSE,
        buffersize = 100, # with this value the mem consumption is reduced
        widths=rep(16,561));
# subset only the intersting measurements
test_dataset2 <- test_dataset[, interesting_columns$colID];
# use descriptive names for measurements
colnames(test_dataset2) <- interesting_columns$measurementName;

# final TEST dataset
test_dataset3 <- cbind(subject_test, y_test, test_dataset2)


#===============================================================================
# parse TRAIN dataset

# read activities
y_train <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/train/y_train.txt", 
                    header=FALSE, 
                    col.names = c('activityID'));

# read subjects
subject_train <- read.csv("~/projects/R/assignment3/UCI HAR Dataset/train/subject_train.txt", 
                          header=FALSE, 
                          col.names = c('subjectID'));

# read dataset with ALL measurements
train_dataset <- read.fwf("~/projects/R/assignment3/UCI HAR Dataset/train/X_train.txt",
                          header=FALSE,
                          buffersize = 100, # with this value the mem consumption is reduced
                          widths=rep(16,561));
# subset only the intersting measurements
train_dataset2 <- train_dataset[, interesting_columns$colID];
# use descriptive names for measurements
colnames(train_dataset2) <- interesting_columns$measurementName;

# final train dataset
train_dataset3 <- cbind(subject_train, y_train, train_dataset2)

#===============================================================================
# "merge" the TEST and TRAIN dataset
dataset <- rbind(train_dataset3,test_dataset3)

# caclulate the mean of each variable by subject and by activity
aggdata <-aggregate(dataset, by=list(dataset$subjectID,dataset$activityID), FUN=mean);

# add column with descriptive name for the activity id
aggdata$activityName <- apply(aggdata,1,function(row) activity_names[ row[4], 'activityName'] );

# save the final dataset
write.csv(aggdata, file = "~/projects/R/assignment3/git_repo/aggdata.csv");