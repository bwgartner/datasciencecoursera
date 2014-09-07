complete <- function(directory, id = 1:332) {

        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        if(file.exists(directory) && file.info(directory)[1,"isdir"]) {
        } else {
                stop("Cannot find data directory : ", directory)
        }

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        stopifnot(length(id) > 0)
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases

        # setup result data frame
        df <- data.frame(id=1:length(id), nobs=1:length(id), row.names=NULL)

        # ready file handle list
        fh_list <- list.files(directory, full.names=TRUE)
        #print(fh_list)

        for( i in 1:length(id)) {
                #print(i)
                fh_id <- id[i]
                #print(fh_id)
                fh_nobs <- sum(complete.cases(read.csv(fh_list[fh_id])))
                #print(fh_nobs)
                df[i,"id"] <- fh_id
                df[i,"nobs"] <- fh_nobs
        }
	df
        
}
