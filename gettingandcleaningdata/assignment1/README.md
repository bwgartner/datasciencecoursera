# Wearable Computing and Activity Tracking

Using 30 volunteer subjects, broken down into a smaller training group and a larger test group, each performed a set of normal, everyday activities, while equipped with a cell phone. Using the embedded motion detection devices, a significant volume of data was captured. The following article, "[Data Science, Wearable Computing and the Battle for the Throne as World's Top Sports Brand](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/)" provides the background for, and possible usage of such data going forward.

The [actual data set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) from the study can be found here.

While invaluable in it's raw form, it becomes more useful if merged, converged and manipulated towards becoming a [tidy data set](http://vita.had.co.nz/papers/tidy-data.pdf) to be shared for further review and analysis.

This repository contains the following artifacts:

* the [CodeBook.md](./CodeBook.md) file
	* explanation of the resulting tidy data, including column numbers, variable names, and descriptions
* the [run_analysis.R](./run_analysis.R) file
	* an R program/script, taking as input the raw data, and delivering as output the tidy data set
* a reference copy of the resulting tidy data output named [reference_output.txt](./reference_output.txt)

For reproducibility, the following steps can be utilized to exactly replicate and validate the process:

1. Go to a suitable working directory
2. Download the [raw data](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/) from the "Data Folder" link
3. Unpack the downloaded "UCI HAR Dataset.zip" file
	* this should create a "UCI HAR Dataset" sub-directory in your working directory with all the raw data and explanatory information
3. Download the [run_analysis.R](./run_analysis.R) script from this site into your working directory
4. Using R or R-Studio in your working directory
	* source("run\_analysis.R")
	* run\_analysis()
5. The resulting tidy data summary should be written into a file in your working directory names ""
	* you can then compare with the "reference_output.txt" file from this site to validate that the process was successful

For transparency purposes, one can certainly review the [run_analysis.R](./run_analysis.R) script itself, but the following provides a pseudo-code overview of the various operations performed (assuming the script and the unzipped raw data are present in the working directory):
	* NOTE: you can validate each step by running "run_analysis(step=X) and looking at the resulting Xoutput.txt file

1. Merge the training and test data together into one large data set
	* first creating a data from the columns of (in order)
		* ./train/subject_train.txt
		* ./train/y_train.txt
		* ./train/X_train.txt
	* next create a data frame from the columns of (in order)
		* ./test/subject_test.txt
		* ./test/y_test.txt
		* ./test/X_test.txt
	* and then row bind (or append) these two data frames together
	* which results in **10299** observations with **563** variables

2. Subset the merged data (from the previous step) to only contain the *mean* and *standard deviation* measurements
	* resulting in **10299** observations with **81** variables

3. Apply description names to the activites (versus the simple numberic coded values from "activity\_labels.txt"

4. Update the generic variable (column) names to descriptive values

5. Create a summary data set from the previous step's output that averages each of the values for a given activity and subject



This codebook provides the following information about the resulting tidy data set:

Information about the variables (including units!) in the data set not contained in the tidy data

Information about the summary choices you made

Information about the experimental study design you used
