## DATA Dictionary
## Wearable Computing and Activity Tracking Tidy Data
### reference_output.txt

***
Information about the variables (including units!) in the data set not contained in the tidy data

* ColumnNumber VariableName
	* Description

***

1. SubjectID
	* identifies the subject who performed the activity for each window sample.
	* Its range is from 1 to 30
		> Note: this maps directly back to the entry found in the raw data from 'test/subject\_train.txt' or 'train/subject\_train.txt'

2. ActivityType
	* identifies the activity performed for the measurements. It has the values of
		* Walking
		* WalkingUpstairs
		* WalkingDownstairs
		* Sitting
		* Standing
		* Laying
			> Note: corresponds to the coded entry found in the raw data mapping of 'activity\_labels.txt'

The remaining columns (3-68) correspond to the arithmetic mean across all feature vector samples to their corresponding raw data labels from 'features\_info.txt'. The units for these values are the same as for their raw data counterparts.

	* Mean-tBodyAcc-mean()-X
	* Mean-tBodyAcc-mean()-Y
	* Mean-tBodyAcc-mean()-Z

	* Mean-tBodyAcc-std()-X
	* Mean-tBodyAcc-std()-Y
	* Mean-tBodyAcc-std()-Z

	* Mean-tGravityAcc-mean()-X
	* Mean-tGravityAcc-mean()-Y
	* Mean-tGravityAcc-mean()-Z

	* Mean-tGravityAcc-std()-X
	* Mean-tGravityAcc-std()-Y
	* Mean-tGravityAcc-std()-Z

	* Mean-tBodyAccJerk-mean()-X
	* Mean-tBodyAccJerk-mean()-Y
	* Mean-tBodyAccJerk-mean()-Z

	* Mean-tBodyAccJerk-std()-X
	* Mean-tBodyAccJerk-std()-Y
	* Mean-tBodyAccJerk-std()-Z

	* Mean-tBodyGyro-mean()-X
	* Mean-tBodyGyro-mean()-Y
	* Mean-tBodyGyro-mean()-Z

	* Mean-tBodyGyro-std()-X
	* Mean-tBodyGyro-std()-Y
	* Mean-tBodyGyro-std()-Z

	* Mean-tBodyGyroJerk-mean()-X
	* Mean-tBodyGyroJerk-mean()-Y
	* Mean-tBodyGyroJerk-mean()-Z

	* Mean-tBodyGyroJerk-std()-X
	* Mean-tBodyGyroJerk-std()-Y
	* Mean-tBodyGyroJerk-std()-Z

	* Mean-tBodyAccMag-mean()
	* Mean-tBodyAccMag-std()

	* Mean-tGravityAccMag-mean()
	* Mean-tGravityAccMag-std()

	* Mean-tBodyAccJerkMag-mean()
	* Mean-tBodyAccJerkMag-std()

	* Mean-tBodyGyroMag-mean()
	* Mean-tBodyGyroMag-std()

	* Mean-tBodyGyroJerkMag-mean()
	* Mean-tBodyGyroJerkMag-std()

	* Mean-fBodyAcc-mean()-X
	* Mean-fBodyAcc-mean()-Y
	* Mean-fBodyAcc-mean()-Z

	* Mean-fBodyAcc-std()-X
	* Mean-fBodyAcc-std()-Y
	* Mean-fBodyAcc-std()-Z

	* Mean-fBodyAccJerk-mean()-X
	* Mean-fBodyAccJerk-mean()-Y
	* Mean-fBodyAccJerk-mean()-Z

	* Mean-fBodyAccJerk-std()-X
	* Mean-fBodyAccJerk-std()-Y
	* Mean-fBodyAccJerk-std()-Z

	* Mean-fBodyGyro-mean()-X
	* Mean-fBodyGyro-mean()-Y
	* Mean-fBodyGyro-mean()-Z

	* Mean-fBodyGyro-std()-X
	* Mean-fBodyGyro-std()-Y
	* Mean-fBodyGyro-std()-Z

	* Mean-fBodyAccMag-mean()
	* Mean-fBodyAccMag-std()

	* Mean-fBodyBodyAccJerkMag-mean()
	* Mean-fBodyBodyAccJerkMag-std()

	* Mean-fBodyBodyGyroMag-mean()
	* Mean-fBodyBodyGyroMag-std()

	* Mean-fBodyBodyGyroJerkMag-mean()
	* Mean-fBodyBodyGyroJerkMag-std()
