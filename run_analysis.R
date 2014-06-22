library(plyr)
library(reshape2)

#create the data directory
if(!file.exists("data")) {
        dir.create("data")
}

#download the dataset and unzip it
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "data/dataset.zip")
unzip(zipfile="data/dataset.zip", exdir="data")

#read both datasets test and train
datadir <- "data\\UCI\ HAR\ Dataset\\"
x_test <- read.table(paste(datadir, "test\\x_test.txt", sep = ""), stringsAsFactors = FALSE)
x_train <- read.table(paste(datadir, "train\\x_train.txt", sep = ""), stringsAsFactors = FALSE)

#Name each columns acording to its feature
features <- read.table(paste(datadir, "features.txt", sep = ""), stringsAsFactors = FALSE )

names(x_test) <- features[,2]
names(x_train) <- features[,2]

# read activity
y_test <- read.fwf(paste(datadir, "test\\y_test.txt", sep = ""), widths =c(1))
y_train <- read.fwf(paste(datadir, "train\\y_train.txt", sep = ""), widths =c(1))


# read activity labels
activity_labels <- read.table(
        paste(datadir, "activity_labels.txt", sep = ""), 
        colClasses=c("numeric", "character"))

# associate acitivy label to dataset
x_test$activity <- mapvalues(y_test[,1], from=activity_labels[,1], to=activity_labels[,2])
x_train$activity <- mapvalues(y_train[,1], from=activity_labels[,1], to=activity_labels[,2])


# 1.Merges the training and the test datasets to create one dataset.
x <- rbind(x_test, x_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
std_names <- data.frame(from=names(x)[grep("mean\\(\\)", names(x))], stringsAsFactors = FALSE)
mean_names <- data.frame(from=names(x)[grep("std\\(\\)", names(x))], stringsAsFactors = FALSE)

# For item "4. Appropriately labels the data set with descriptive variable names."
colnames <- rbind(c("activity"),std_names, mean_names)

# Select only the columns we are interested in
x_reduced <-subset(x, select=colnames[,1])

# reshape to the long format
x_long_data<- melt(x_reduced,id.vars<-c("activity"), 
                   variable.name = "original", 
                   factorsAsStrings=TRUE)

# transform factor to chacaracter, for performance reasons
i <- sapply(x_long_data, is.factor)
x_long_data[i] <- lapply(x_long_data[i], as.character)

# Since the names of the columns combine different concepts, 
# we need to parse it and split in different columns. The code below does
# that.

# function that gets the column name and removes "()"
get_colname<- function(colname, idx) {
        tokenized <- unlist(strsplit(colname,"-", fixed=TRUE))
        gsub("()","",tokenized[idx],fixed=TRUE)
}

# Create the subject column parsing the original column
x_long_data$subject <- sapply(x_long_data$original, 
                           function(r){ 
                                   get_colname(r,1) 
                           })


# Create the aggregate_function column parsing the original column
x_long_data$aggregate_function <- sapply(x_long_data$original, 
                           function(r){ 
                                   get_colname(r,2) 
                           })


# Create the axe column parsing the original column
x_long_data$axe <- sapply(x_long_data$original, 
              function(r){ 
                      get_colname(r,3) 
              })

# Reorder columns and get rid of "original" column
x_long_data<-subset(x_long_data, 
                    select=c("activity", 
                             "subject", 
                             "aggregate_function", 
                             "axe", 
                             "value"))

# Write the final dataset
write.table(x_long_data, file="dataset.txt",  row.names = FALSE)

# 6.Creates a second, independent tidy data set with the average 
# of each variable for each activity and each subject. 
# Once our data is in the long format, it is 
# almost too easy to create means by activity + subject + axe. 
wide_data <- dcast(x_long_data, 
                   activity + subject + axe ~  aggregate_function, mean)
write.table(wide_data, file="summary_dataset.txt",  row.names = FALSE)
