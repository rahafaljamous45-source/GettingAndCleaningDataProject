Code Book

This document explains the tidy data set, tidy_data_averages.txt, generated from the UCI HAR Dataset, documenting the variables and the transformations performed.

1. Data Source

Original Source: Human Activity Recognition Using Smartphones Dataset (UCI HAR Dataset).

Data: Body movement sensor measurements taken from 30 volunteers while performing six different activities.

2. Final Tidy Data Set

File Name: tidy_data_averages.txt

Description: This data set contains the average of every measurement variable (originally using mean() and std()) for each subject and each activity. It contains 180 rows (30 subjects × 6 activities) and 68 columns.

3. Key Identification Variables

Variable

Description

Values

Subject

The ID of the volunteer who performed the activity.

Integers from 1 to 30.

Activity_Name

The descriptive name of the measured activity.

WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING.

4. Derived Measurement Variables

The final data set contains 66 derived variables, all prefixed with Average_. These values represent the mean of the original corresponding measurement for that subject and activity group.

Example: Average_TimeBodyAccelerometerMeanX is the mean value of the original TimeBodyAccelerometerMeanX for a specific subject while performing a specific activity.

Time/Frequency Prefix

Measurement Type

Description

Time

...

Indicates the measurement was taken in the Time Domain.

Frequency

...

Indicates the measurement was taken in the Frequency Domain (via Fast Fourier Transform - FFT).

Sensor Type & Calculation

Name

Description

BodyAccelerometer

...

Measures the acceleration due to the body's movement.

GravityAccelerometer

...

Measures the acceleration due to gravity.

BodyGyroscope

...

Measures the body's angular velocity.

Mean

...

Represents the mean calculated in the original feature vector.

Std

...

Represents the standard deviation calculated in the original feature vector.

5. Data Processing and Transformation Steps

The final data set was created by executing the following five steps in the run_analysis.R script:

Merge Data Sets: The train and test data sets (X, Y, and Subject) were merged to form one large, complete data set.

Extract Measurements: The large data set was filtered to retain only the Subject and Activity IDs, and only the measurement features that represent the mean (mean()) and standard deviation (std()).

Apply Activity Labels: The numerical activity IDs (1-6) were replaced with descriptive, readable names (e.g., WALKING) using the activity_labels.txt file.

Descriptive Variable Names: Clean and descriptive names were applied to all columns:

t and f prefixes were expanded to Time and Frequency.

Acronyms were expanded (e.g., Acc to Accelerometer, Gyro to Gyroscope).

Special characters (-, (, )) were removed, and capitalization was corrected (mean to Mean, std to Std).

Calculate Final Averages: The tidy data set was grouped by Subject and Activity_Name, and the mean of every remaining numeric column was calculated. This result was saved to the final output file, tidy_data_averages.txt.
