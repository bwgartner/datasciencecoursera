run_analysis <- function(directory="./UCI HAR Dataset", step=5) { 
#run_analysis <- function(directory="Dataset", step=5, DEBUG=FALSE) {  ## FIXME dir with spaces in it

    ## Prep / Error Checking

	# 'directory' is a character vector of length 1 indicating
	# the location of the extracted machine learning files
	if(!file.exists(directory) || !file.info(directory)[1,"isdir"]) {
		stop("Cannot find data directory : ", directory)
	}

	# start in the data top-level directory (to shorten path references)
	setwd(directory)

	# expected files/sub-directories within the extracted machine learning data

	mapActivityFileName <- c("./activity_labels.txt")
	if(!file.exists(mapActivityFileName)) {
	        stop("Cannot find activity map file: ", mapActivityFileName)
	}

	mapFeaturesFileName <- c("./features.txt")
	if(!file.exists(mapFeaturesFileName)) {
	        stop("Cannot find features map file: ", mapFeaturesFileName)
	}

	subDirs <- c("test", "train")
	for(sd in subDirs) {
	        if(!file.exists(sd) || !file.info(sd)[1,"isdir"]) {
	                stop("Cannot find expected sub-directory for data : ", sd)
	        }
	}

	# setup input data frame, data vector
	calcDF <- data.frame()
	testDF <- data.frame()
	trainDF <- data.frame()
	mergeDF <- data.frame()
	reducedDF <- data.frame()
	outputDF <- data.frame()
	myStep <- as.numeric(1)
	myOutputFileName <- c("output.txt")
	myStatus <- c("Merge the training and test data together into one large data set",
		      "Subset the merged data to only contain the *mean* and *std* variables",
		      "Apply descriptive names to the activites",
		      "Update the generic variable names to descriptive values",
		      "Create a summary data set that averages each of the values for a given activity and subject")

    ## Step 1

	if(step >= 1) {

		myOFN <- paste0("../", myStep, myOutputFileName)
		cat("Step ", myStep," : ", myStatus[myStep], ", see ", paste0(myStep, myOutputFileName), "\n")

        	# loop through data (sub-directories) to accumulate data
        	# with ordered binding of subjectID, activityID, Data
        	for(sd in subDirs) {

                	sID <- paste0(sd, "/", list.files(path=sd, pattern = "^subject"))
                	aID <- paste0(sd, "/", list.files(path=sd, pattern = "^y_"))
                	data <- paste0(sd, "/", list.files(path=sd, pattern = "^X_"))

                	if( sd == "test" ) {
                        	testDF <- read.table(sID, header=FALSE, sep="")
                        	testDF <- cbind(testDF, read.table(aID, header=FALSE, sep=""))
                        	testDF <- cbind(testDF, read.table(data, header=FALSE, sep=""))
                	}

                	if( sd == "train" ) {
                        	trainDF <- read.table(sID, header=FALSE, sep="")
                        	trainDF <- cbind(trainDF, read.table(aID, header=FALSE, sep=""))
                        	trainDF <- cbind(trainDF, read.table(data, header=FALSE, sep=""))
                	}
        	}
        	mergeDF <- rbind(testDF, trainDF)
		try(write.table(mergeDF,file=myOFN, row.name=FALSE, col.name=FALSE))
		myStep <- myStep + 1
	}


    ## Step 2

	if(step >= 2) {

		myOFN <- paste0("../", myStep, myOutputFileName)
		cat("Step ", myStep," : ", myStatus[myStep], ", see ", paste0(myStep, myOutputFileName), "\n")

		# read in feature naming scheme
		featuresDF <- read.table(mapFeaturesFileName, header=FALSE, sep="")

		# label all columns for easier manipulation
                cv <- union(c("SubjectID", "Activity"), featuresDF$V2)
		colnames(mergeDF) <- c(cv)

        	# find subset of columns of features to be retained
        	# using regexps for *mean()* and/or *sd()*
		# should end up with 79 variables
		colExtractDF <- subset(featuresDF, grepl("\\-mean\\(\\)", V2) | grepl("\\-std\\(\\)", V2))

		# reduce the merged matrix to items of interest
		ev <- union(c("SubjectID", "Activity"), colExtractDF$V2)
		reducedDF <- subset(mergeDF, select = c(ev))

		try(write.table(reducedDF,file=myOFN, row.name=FALSE, col.name=FALSE))
		myStep <- myStep + 1
	}

    ## Step 3

	if(step >= 3) {

		myOFN <- paste0("../", myStep, myOutputFileName)
		cat("Step ", myStep," : ", myStatus[myStep], ", see ", paste0(myStep, myOutputFileName), "\n")

		# read in activity naming scheme
		activityDF <- read.table(mapActivityFileName, header=FALSE, sep="")

        	# replace activity codes with Activity name
		for(target in c(activityDF$V1)) {
			reducedDF$Activity <- sapply(reducedDF$Activity, sub, pattern=target, replacement=activityDF[target,2])
		}

		try(write.table(reducedDF,file=myOFN, row.name=FALSE, col.name=FALSE))
		myStep <- myStep + 1
	}

    ## Step 4

	if(step >= 4) {

		myOFN <- paste0("../", myStep, myOutputFileName)
		cat("Step ", myStep," : ", myStatus[myStep], ", see ", paste0(myStep, myOutputFileName), "\n")

        	# label all columns with human readable values
		# (already completed in memory via step2, so now just include in output)

		try(write.table(reducedDF,file=myOFN, row.name=FALSE, col.name=TRUE))
		myStep <- myStep + 1
	}

    ## Step 5

	if(step >= 5) {

		myOFN <- paste0("../", myStep, myOutputFileName)
		cat("Step ", myStep," : ", myStatus[myStep], ", see ", paste0(myStep, myOutputFileName), "\n")

		# capture column names for later update
		newCN <- names(reducedDF)

        	# create summary tidy set, averaging each measured variable/column
        	# across subjectID, testID clusters (reusing a lot of previous intermediate vectors)
		for(sid in unique(reducedDF$SubjectID)) {
			for(aid in unique(reducedDF$Activity)) {

				# respective subset
				calcDF <- subset(reducedDF, reducedDF$SubjectID == sid & reducedDF$Activity== aid)

				# for respective subset calculate column means
				newCM <- c(sid, aid, colMeans(calcDF[,3:ncol(calcDF)],na.rm=TRUE))
				attributes(newCM) <- NULL
				newCM<-data.frame(as.list(newCM))
				colnames(newCM) <- newCN
				outputDF <- rbind(outputDF,newCM)

			}
		}

		# update respective column label with new designation according to calculation
		for(colnum in 3:ncol(reducedDF)) {
			newCN[colnum] <- paste0("Mean-",newCN[colnum])
		}
		colnames(outputDF) <- newCN

		# sort output for aesthetic reasons
		outputDF<-outputDF[order(as.numeric(as.character(outputDF$SubjectID)),outputDF$Activity),]

		try(write.table(outputDF,file=myOFN, row.name=FALSE, col.name=TRUE))
	}

    ## return to working directory to where we started
	setwd("../")

    ## return the result
	return(outputDF)

}
