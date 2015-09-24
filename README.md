This file provides an overview of how the run_analysis.R works.

1. All the training and test data are imported into R.
2. The test data is then appended to the bottom of the training data.
3. The mean and standard deviation are calculated for each measurement.
4. All variables are combined under one data frame and given names.
5. The mean of each variable is calculated for each subject-activity pair and saved under a second data frame in data2.txt file.