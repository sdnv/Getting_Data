
# Read the Activity Labels
  ActivityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

#-------------------------
# Build the Train Dataset

# Initialize TrainDataset as SubjectTrain
  TrainDataset <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE)
  colnames(TrainDataset)[1] <- "Subject"

# Create an additional column to indicate whether the data is for Train or Test
  TrainDataset$TrainTest <- rep("Train",nrow(TrainDataset))

# Append Ytrain to TrainDataset
  TrainDataset <- cbind(TrainDataset, read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, dec = "."))
  colnames(TrainDataset)[3] <- "Y"

# Include a column with the activity names of the values in column Y
  TrainDataset$Activity <- ActivityLabels[TrainDataset$Y,2]

  ni <- ncol(TrainDataset)

# Append Xtrain to TrainDataset
  TrainDataset <- cbind(TrainDataset, read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE, dec = "."))

  nf <- ncol(TrainDataset)

# Set ordered names for the variables taken from Xtrain
  names(TrainDataset)[(ni+1):nf] <- paste(replicate(nf-ni,"X"), as.character(1:(nf-ni)), sep="")

#-------------------------
# Build the Test Dataset

# Initialize TestDataset with SubjectTest
  TestDataset <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE)
  colnames(TestDataset)[1] <- "Subject"

# Create an additional column to indicate whether the data is for Train or Test
  TestDataset$TrainTest <- rep("Test",nrow(TestDataset))

# Append Ytest to TestDataset
  TestDataset <- cbind(TestDataset, read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, dec = "."))
  colnames(TestDataset)[3] <- "Y"

# Include a column with the activity names of the values in column Y
  TestDataset$Activity <- ActivityLabels[TestDataset$Y,2]

  ni <- ncol(TestDataset)

# Append Xtest to TestDataset
  TestDataset <- cbind(TestDataset, read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE, dec = "."))

  nf <- ncol(TestDataset)

# Set ordered names for the variables taken from Xtest
  names(TestDataset)[(ni+1):nf] <- paste(replicate(nf-ni,"X"), as.character(1:(nf-ni)), sep="")

  remove(ni,nf)
