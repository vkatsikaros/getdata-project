# Course Project

## For the Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata)

The working directory is `~/projects/R/assignment3/` (in Linux/Mac `~` is the user's "home" directory)

## Step 0. Data inspection and CodeBook

The following are not performed by the project script, but from us, trying to
examine the data. The outcome is the `CookBook.md` and the file `features_info.txt`

Download dataset

	$ wget https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip -O original.zip

Unzip dataset and change directory

	$ unzip original.zip
	$ cd UCI\ HAR\ Dataset/


We picked a regular expression looking for "mean(" or "std(" because of the 
lines 33-34 of file `features_info.txt`

	The set of variables that were estimated from these signals are:
	
	mean(): Mean value
	std(): Standard deviation
	
Create a list of the labels we are interested in (mean and std deviation) and 
save them in the file `interesting_features.txt`

	$ egrep -i "(mean\(|std\()" features.txt > interesting_features.txt
	
The file `interesting_features.txt` is also added in the git repo.

How many are the interesting columns of data? Answer 66

	$ wc -l interesting_features.txt
	66 interesting_features.txt

How many rows in test dataset? Answer 2947

	# wc -l: counts lines in file
	$ cd test
	$ wc -l y_test.txt 
	2947 y_test.txt
	$ wc -l X_test.txt 
	2947 X_test.txt
	$ wc -l subject_test.txt 
	2947 subject_test.txt

How many rows in train dataset? Answer 7352

	cd ../train
	$ wc -l X_train.txt 
	7352 X_train.txt
	$ wc -l y_train.txt 
	7352 y_train.txt
	$ wc -l subject_train.txt 
	7352 subject_train.txt

So, this means that the merged dataset should have 2947 + 7352 = 10299 lines of data

The [CodeBook](./CodeBook.md) was written after reading the supplied documentation.

## Step 1. Parse Data 

The R script `run_analysis.R` is parsing the train and test dataset. For both the train
and test datasets it performs the following (`<dataset>` is "test" or "train"):

* Read `<dataset>/y_<dataset>.txt` for 1 column named `activityID` (lines 16 & 43)

* Read `<dataset>/subject_<dataset>.txt` for 1 column named `subjectID` (lines 21 & 48)

* Read `<dataset>/X_<dataset>.txt` for 561 columns, 1 for each measurement (lines 26 & 53)

* Subset only the interesting coluns with `[, interesting_columns$colID];` (lines 31 & 58)

* Add descriptive names to columns with `colnames(<list>) <- interesting_columns$measurementName;` 
where `<list>` is the proper list name (lines 33 & 60)

* Merge columns `activityID`, `subjectID` and the 66 columns with descriptive measurement names with `cbind` (lines 36 & 63)

## Step 2. Merge datasets

After the datasets are read, the fololowing occurs:

* Merge the cleaned train and cleand test dataset with `rbind` (line 67)

* Calculates the mean of each measurement per subject and per activity with `aggregate` (line 69)

* Add column with descriptive names for the activity, called `activityName` with `apply` (line 73)

* Finally, sace the cleaned data frame in CSV format (line 76)

The script is commented in order to explain what each line of code does.


