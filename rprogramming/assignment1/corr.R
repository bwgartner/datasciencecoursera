corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
        if(file.exists(directory) && file.info(directory)[1,"isdir"]) {
        } else {
                stop("Cannot find data directory : ", directory)
        }
        #print("directory")

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0
        #print(threshold)

        # setup input data frame, data vector
        temp <- data.frame()
        result <- numeric()
        options(digits=4)

        # ready file handle list
        fh_list <- list.files(directory, full.names=TRUE)
        #print(length(fh_list))

        #for( i in 1:2) {
        for( i in 1:length(fh_list)) {
                temp <- na.omit(read.csv(file=fh_list[i]))
                #print(temp)
                #print(nrow(temp))
                if(nrow(temp) > threshold) {
                        temp
                        result <- c(result,cor(temp[["sulfate"]], temp[["nitrate"]]))
                }
        }
        result

}
