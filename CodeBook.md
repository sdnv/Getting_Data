## COURSERA/JHU Data Science Specialization
## Getting and Cleaning Data (May 2015) - Course Project

# Code Book

### 1. Purpose

This code book describes the datasets, variables, and transformations used to build the final tidy dataset with averaged values of **Human Activity Recognition (HAR)** variables taken from a specific set of data files.


### 2. Data Files

The data files used in this project are located in the folder **"/UCI HAR Dataset"**.

#### 2.1. Files in folder "/UCI HAR Dataset":

  - **activity_labels.txt**: contains the activity identification numbers along with their respective activity names.

  - **features.txt**: identifies the 561 feature variables about the activities. For example, feature 10 is the *maximum body acceleration over time in the X direction*.

  - **features_info.txt**: explains the meaning of the features in file **features.txt**.

#### 2.2. Files in folder "/UCI HAR Dataset/train":

  - **X_train.txt**: contains 7352 train observations of the 561 features (predictor variables) indicated in file **features.txt**.

  - **y_train.txt**: contains 7352 train observations of the activity (outcome variable).

  - **subject_train.txt**: identifies each of the 30 subjects who performed the 7352 train observations.

#### 2.3. Files in folder "/UCI HAR Dataset/test":

  - **X_test.txt**: contains 2947 test observations of the 561 features (predictor variables) indicated in file **features.txt**.

  - **y_test.txt**: contains 2947 test observations of the activity (outcome variable).

  - **subject_test.txt**: identifies each of the 30 subjects who performed the 2947 test observations.


The above files contain all the raw data that should be loaded into R and processed/transformed to build the final tidy dataset.

Additionally, an user-defined text file **descriptive_names.txt** was created to specify descriptive names for some features of interest.


### 3. Script Files (Instruction List)

The script files for this project are: the master script **run_analysis.R** and the auxiliary script **train_test_datasets.R**. The **README.md** in this repository describes how do these files work.

The script files constitute the **instruction lists** of all the computations performed in the raw data files to generate the final tidy dataset. for better understanding of the users, the scripts contain several comments along with the code lines.


### 4. Transformations Performed on the Datasets

The following transformations were made in each step:

  - In building **DatasetTrain**: The transformation used is simply the concatenation of the contents from the raw data files **X_train.txt**, **y_train.txt**, and **subject_train.txt**.

  - In building **DatasetTest**: The transformation used is simply the concatenation of the contents from the raw data files **X_test.txt**, **y_test.txt**, and **subject_test.txt**.

  - In Step 1: The transformation used is simply the concatenation of **DatasetTrain** and **DatasetTest** to generate **DatasetComplete**

  - In Step 2: After reading file **features.txt** into a data frame, its measurement names are transformed to a character vector.

  - In Step 3: No specific transformation is performed.

  - In Step 4: The "name" attribute of **DatasetMeanStd** is transformed (replaced) by the descriptive variable names read from file **descriptive_names.txt**.

  - In Step 5: The variable "TrainTest" is excluded since it is meaningless for averaged variable values computed with both Train and Test observations. The variable values are transformed into average values for each Subject and each Activity by aggregation, using the function **aggregate()**.


### 5. Information about the Variables

#### 5.1. Variables in Dataset **DatasetComplete** (See Figure 1 in the Annexes)

  - **Subject** (integer; dimensionless): Identification number of each of the 30 subjects that performed the observations. It ranges from 1 to 30.

  - **TrainTest** (string factor; dimensionless): Identifies whether the observation came from the Train or Test data files. It can assume only two values: "Train" or "Test".

  - **Y** (integer; dimensionless): Identification number of the activity in the observations, according to file **activity_labels.txt**. It ranges from 1 to 6.

  - **Activity** (string; dimensionless): Name of the activity in the observations, according to file **activity_labels.txt**.

  - **Variables in columns 5 to 565** (numerical): data from 3-axial accelerometer and gyroscope signals, in the time domain (unit: m/s2) or in the frequency domain (unit: rad/s). Detailed description of those variables is provided in the data file **features_info.txt**.

No summarization is done on the variables in **DatasetComplete**. All the variables are simply taken from their source data files and concatenated in the dataset.

#### 5.2. Variables in Dataset **DatasetMeanStd** (See Figure 2 in the Annexes)

Since **DatasetMeanStd** is a subset of **DatasetComplete**, its variables are essentially the same corresponding variables from **DatasetComplete**, described in Section 5.1 above, with the same data types and units.

No summarization is done on the variables in **DatasetMeanStd**. It's simply a subset of **DatasetComplete**.

#### 5.3. Variables in Dataset **DatasetAveraged** (See Figure 3 in the Annexes)

Variables "Subject", "Activity", and "Y" are the same as in the previous datasets. However, the 66 feature variables (columns 4 to 72) in **DatasetAveraged** are mean values of the corresponding columns in **DatasetMeanStd** grouped by "Subject" and "Activity". The units of those variables remain the same for **DatasetMeanStd**.

Two kinds of summarization are done: the average calculation of the variables, and the agrregation of the averaged values by Subject and Activity. Both summarizations are done in a straight way by the function **aggregate()**. 


### 6. Study Design

#### 6.1. Data Source

The data source of all variables are the data files provided in the course. The data files are also available publicly from the the UCI Machine Learning Repository:

  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

All the data files were in text format, so that they could be easily load into R using the function **read.table()**.

#### 6.2. Related Researches

The data used in this project relates to **Human Activity Recognition (HAR)** also referred as **Weareable Computing**. Some links about this field of research are:

  - http://en.wikipedia.org/wiki/Activity_recognition
  - http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/


### 7. Annexes: Structure of the Datasets



![Figure 1](F1_DatasetComplete.png)
**Figure 1**: Structure of the complete dataset **DatasetComplete**.

_

![Figure 2](F2_DatasetMeanStd.png)
**Figure 2**: Structure of the dataset **DatasetMeanStd**.

_

![Figure 3](F3_DatasetAveraged.png)
**Figure 3**: Structure of the final dataset **DatasetAveraged**.

_
