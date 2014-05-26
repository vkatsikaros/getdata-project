# CodeBook

## For the Coursera course [Getting and Cleaning Data](https://www.coursera.org/course/getdata)

Directory `UCI HAR Dataset` contains 2 sub-directories `train` and `test` that
hold the train and test datasets accordingly.

The following files describe:

* `features.txt`: List of all columns (561) in train and test datasets, files `<dataset>/X_<dataset>.txt`.

* `features_info.txt`: Describes detailed information about the way the 561 colunes, 
listed in  `features.txt`, where gathered, and naming conventions for the column names.

* `activity_labels.txt` maps activity IDs with activity names (6 rows)

The dataset files contain:
* File `<dataset>/y_<dataset>.txt`: 1 column with the activity ID

* File `<dataset>/subject_<dataset>.txt` 1 column with the subject ID

* File `<dataset>/X_<dataset>.txt` with 561 columns, 1 column for each measurement ()
