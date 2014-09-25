rankall <- function(outcome, num = "best") {

        ## initialize 
        inputFile <- c("outcome-of-care-measures.csv")
        hospitalColumn <- 2
        stateColumn <- 7

        ## Read outcome data
        if(file.exists(inputFile)) {
                df <- (read.csv(inputFile,
                       na.strings="Not Available",
                       colClasses = "character"))
        } else {
                stop("Cannot find input file : ", inputFile)
        }

        ## Check that outcome and num are valid
        if(outcome == "heart attack") {
                outcomeColumn <- 11
        } else if(outcome == "heart failure") {
                outcomeColumn <- 17
        } else if(outcome == "pneumonia") {
                outcomeColumn <- 23
        } else {
                stop("invalid outcome")
        }

        if(num == "best" | num == "worst" | is.numeric(num)) {

        } else {
                stop("invalid num")
        }

        ## For each state, find the hospital of the given rank

        odf <- data.frame()
        stateV <- sort(unique(unlist(df[,stateColumn])))
        #print(stateV)
        for (i in 1:length(stateV)) {
                # confine to desired state
                statedf <- subset(df, State==c(stateV[i]), select=c(hospitalColumn,stateColumn,outcomeColumn))
                #str(statedf)
                # sort by outcome then hospital, strip NA
                statedf <- na.omit(statedf[ order(as.numeric(statedf[,3]), statedf[,1]), ])
                statedf <- na.omit(statedf[ order(as.numeric(statedf[,3]), statedf[,1]), ])
                #str(statedf)
                if(num == "best") {  # grab first row (since ordered from above)
                        odf[i,1] <- c(statedf[1,1])
                        #print(statedf[1,1])
                } else if (num == "worst") {  # grab "last" row's element
                        odf[i,1] <- c(statedf[NROW(statedf),1])
                        #print(statedf[NROW(statedf),1])
                } else {  # deliver the specified rank (or NA if too few items)
                        if(NROW(statedf) < num) {
                                odf[i,1] <- c("NA")
                        } else {  
                                odf[i,1] <- c(statedf[num,1])
                                #print(statedf[num,1])
                        }
                }
                odf[i,2] <- c(stateV[i])
                #str(odf)
        }

        ## Return a data frame with the hospital names and the
        ## (abbreviated) state name
        colnames(odf) <- c("hospital", "state")
        odf <- odf[ order(odf[,2]), ]
        #head(odf)
        return(odf)

}
