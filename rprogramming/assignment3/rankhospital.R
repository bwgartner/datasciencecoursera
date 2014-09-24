rankhospital <- function(state, outcome, num = "best") {

        ## initialize 
        inputFile <- c("outcome-of-care-measures.csv")
        hospitalColumn <- 2

        ## Read outcome data
        if(file.exists(inputFile)) {
                df <- na.omit(read.csv(inputFile,
                               na.strings="Not Available",
                               colClasses = "character"))
        } else {
                stop("Cannot find input file : ", inputFile)
        }

        ## Check that state, outcome, num are valid
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

        if(num == "best" | num == "worst" | is.numeric(num)) {

        } else {
                stop("invalid num")
        }

        ## for specified state, restrict data frame into needed columns
        sd <- subset(df, State == state, select=c(hospitalColumn,stateColumn,outcomeColumn))
        #head(sd)
        #str(sd)

        ## order data frame by rate and then hospital name
        sd <- sd[ order(as.numeric(sd[,3]), sd[,1]), ]
        #head(sd)
        #str(sd)

        ## Return ranked (via num) hospital name in that state with
        ## lowest 30-day death rate
        if(num == "best") {  # grab first row (since ordered from above)
                ov <- c(sd[1,1])
        } else if (num == "worst") {  # grab last row's element
                ov <- c(sd[NROW(sd),1])
        } else {  # deliver the specified rank (or NA if too few items)
            if(NROW(sd) < num) {
                    ov <- c("NA")
            } else {  # too few rows
                    ov <- c(sd[num,1])
            }
        }
        ov
}
