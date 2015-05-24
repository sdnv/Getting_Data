
  cat(sprintf("\n  Press <ENTER> to start. Processing will take a while... "))
  readline()

# Build the Train and Test datasets
  source("train_test_datasets.R")

  cat(sprintf("\n  Train and Test datasets builded successfully."))
  cat(sprintf("\n"))
  cat(sprintf("\n  Press <ENTER> to continue... "))
  readline()

# STEP 1:
# Merge the Train and the Test datasets to create one data set.
  DatasetComplete <- rbind(TestDataset, TrainDataset)

# Remove the original datasets to release memory
  remove(TestDataset,TrainDataset)

# STEP 2:
# Extract only the measurements on the MEAN and STANDARD DEVIATION for each
# measurement. 

  MeasurementNames <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, colClasses=c("character"))[,2]

  IndexesMean <- grep("mean[(][)]",MeasurementNames)
  IndexesStd  <- grep("std[(][)]" ,MeasurementNames)
  Indexes     <- append(IndexesMean,IndexesStd)

  DatasetMeanStd <- DatasetComplete[,c(1:4,Indexes+4)]

# Remove 'DatasetComplete' to release memory
  remove(DatasetComplete)

# STEP 3:
# Use descriptive ACTIVITY NAMES to name the activities in the dataset.

# This was already done when building the Train and Test datasets that were
# merged to create 'DatasetComplete' and 'DatasetMeanStd'. Check this by typing
# 'head(DatasetMeanStd[,3:4],10)' and 'tail(DatasetMeanStd[,3:4],10)'

# STEP 4:
# Appropriately label the dataset with descriptive VARIABLE NAMES.

# The file 'features_info.txt' provides useful descriptions about the meaning
# of the variables in the dataset. It was created a file 'descriptive_names.txt'
# with descriptive names for each variable, according to the descriptions from
# the file 'features_info.txt'.
# The variable names defined in file 'descriptive_names.txt' are a bit long
# in order to be really descriptive.

  DescriptiveNames <- read.table("descriptive_names.txt", header=TRUE, colClasses=c("character"))[,1]

  names(DatasetMeanStd) <- append(names(DatasetMeanStd[,1:4]),DescriptiveNames)

# STEP 5:
# From the dataset in STEP 4, create a second, independent TIDY dataset with
# the average of each variable for each ACTIVITY and each SUBJECT.

  DatasetAveraged <- aggregate(. ~ Subject + Activity, data=DatasetMeanStd[,-2], mean)

  write.table(DatasetAveraged, file="Final_Dataset.txt", row.names=FALSE, sep="\t")

  cat(sprintf("\n  Final tidy dataset 'DatasetAveraged' written to file Final_Dataset.txt.\n\n"))
