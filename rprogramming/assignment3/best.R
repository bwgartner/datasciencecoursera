best <- function(state, outcome) {

        ## initialize 
        inputFile <- c("outcome-of-care-measures.csv")
        hospitalColumn <- 2
        
        df <- data.frame()  # complete data frame from input file
        sd <- data.frame    # subset data from based upon parameters
        ov <- c()           # output character vector for results

        ## Read outcome data
        if(file.exists(inputFile)) {
                df <- na.omit(read.csv(inputFile,
                               na.strings="Not Available",
                               colClasses = "character"))
        } else {
                stop("Cannot find input file : ", inputFile)
        }

        ## Check that state and outcome are valid, or bail out
        if(is.element(state, df[ ,"State"])) {
                stateColumn <- 7
        } else {
                stop("invalid state")
        }
        if(outcome == "heart attack") {
                outcomeColumn <- 11
        } else if(outcome == "heart failure") {
                outcomeColumn <- 17
        } else if(outcome == "pneumonia") {
                outcomeColumn <- 23
        } else {
                stop("invalid outcome")
        }

        ## for specified state, restrict data frame into needed columns
        sd <- subset(df, State == state, select=c(hospitalColumn,stateColumn,outcomeColumn))
        #head(sd)
        #str(sd)

        ## order data frame by rate and then hospital name
        sd <- sd[ order(as.numeric(sd[,3]), sd[,1]), ]
        #head(sd)
        #str(sd)

        ## Return hospital name in that state with lowest 30-day death
        ## rate (since ordered from above)
        ov <- c(sd[1,1])
        ov
}
