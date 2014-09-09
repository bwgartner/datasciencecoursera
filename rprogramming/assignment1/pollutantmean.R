pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        if(file.exists(directory) && file.info(directory)[1,"isdir"]) {
        } else {
                stop("Cannot find data directory : ", directory)
        }
        #print(directory)

        ## 'pollutant' is a character vector of length 1 indicating
        ## the name of the pollutant for which we will calculate the
        ## mean; either "sulfate" or "nitrate".
        #stopifnot(pollutant = "sulfate" || pollutant = "nitrate")
        #print(pollutant)

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        stopifnot(length(id) > 0)
        #print(id)

        ## Return the mean of the pollutant across all monitors list
        ## in the 'id' vector (ignoring NA values)

        # setup input data frame, data vector
        df <- data.frame()
        monitor <- numeric(0)

        # ready file handle list
        fh_list <- list.files(directory, full.names=TRUE)
        #print(fh_list)

        for( i in 1:length(id)) {
                #print(i)
                fh_id <- id[i]
                #print(fh_id)
                #print(fh_list[fh_id])
                df <- rbind(df,read.csv(file=fh_list[fh_id],head=TRUE))
                #print(NROW(df))
        }
        monitor <- na.omit(df[[pollutant]])
        #print(monitor)
        result <- round(mean(monitor),digits=3)
        result


}
