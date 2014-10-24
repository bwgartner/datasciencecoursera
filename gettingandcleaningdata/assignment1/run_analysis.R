run_analysis <- function(directory="Dataset") {  ## FIXME dir with spaces in it

    ## Prep

        print(directory)
        # 'directory' is a character vector of length 1 indicating
        # the location of the extracted machine learning files
        if(file.exists(directory) && file.info(directory)[1,"isdir"]) {
        } else {
                stop("Cannot find data directory : ", directory)
        }
        setwd(directory)
        print(getwd())
        print(directory)

        # expected files/sub-directories within the extracted machine learning data

        #mapActivityFileName <- c("activity_labels.txt")
        #if(!file.exists(mapActivityFileName)) {
        #        stop("Cannot find activity map file: ", mapActivityFileName)
        #}

        #mapFeaturesFileName <- c("features.txt")
        #if(!file.exists(mapFeaturesFileName)) {
        #        stop("Cannot find features map file: ", mapFeaturesFileName)
        #}

        subDirs <- c("test", "train")
        #for(sd in subDirs) {
        #        if(!file.exists(sd) || !file.info(sd)[1,"isdir"]) {
        #                stop("Cannot find expected sub-directory for data : ", sd)
        #        }
        #}

        # setup input data frame, data vector
        testDF <- data.frame()
        trainDF <- data.frame()
        mergeDF <- data.frame()
        #result <- numeric()
        #options(digits=4)

    ## Step 1

        # loop through data (sub-directories) to accumulate data
        # with ordered binding of subjectID, activityID, Data
        for(sd in subDirs) {

                print(sd)
                sID <- paste0(sd, "/", list.files(path=sd, pattern = "^subject"))
                aID <- paste0(sd, "/", list.files(path=sd, pattern = "^y_"))
                data <- paste0(sd, "/", list.files(path=sd, pattern = "^X_"))

                if( sd == "test" ) {
                        testDF <- read.table(sID, header=FALSE, sep="")
                        testDF <- cbind(testDF, read.table(aID, header=FALSE, sep=""))
                        testDF <- cbind(testDF, read.table(data, header=FALSE, sep=""))
                        dim(testDF)
                }

                if( sd == "train" ) {
                        trainDF <- read.table(sID, header=FALSE, sep="")
                        trainDF <- cbind(trainDF, read.table(aID, header=FALSE, sep=""))
                        trainDF <- cbind(trainDF, read.table(data, header=FALSE, sep=""))
                        dim(trainDF)
                }
        }
        mergeDF <- rbind(testDF, trainDF)
        str(mergeDF)


    ## Step 2

        # restrict subset to regular expressions of features measured
        # 

        # extract only those columns associatelabel all columns with human readable values (and to provide
        # easy handles for later manipulation

        # extract a cluster of data for each combination of
        # subjectID, testID, to calculate the means

    ## Step 3

        # map testID from numerical designation to human readable values

    ## Step 4

        # label all columns with human readable values (and to provide

    ## Step 5

        # create summary tidy set, averaging each variable/column
        # across subjectID, testID clusters

}
