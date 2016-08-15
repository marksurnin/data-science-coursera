# Overview

## Source Data

The full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The source data for this project can be found [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


## Dataset information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## Attribute information

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


# `tidy.txt`

## Identifiers

- `subject` – The ID of the test subject.
- `activity` – The type of activity performed when the corresponding measurements were taken.

## Measurements

- `TimeBodyAccelerometer-mean()-X`
- `TimeBodyAccelerometer-mean()-Y`
- `TimeBodyAccelerometer-mean()-Z`
- `TimeBodyAccelerometer-std()-X`
- `TimeBodyAccelerometer-std()-Y`
- `TimeBodyAccelerometer-std()-Z`
- `TimeGravityAccelerometer-mean()-X`
- `TimeGravityAccelerometer-mean()-Y`
- `TimeGravityAccelerometer-mean()-Z`
- `TimeGravityAccelerometer-std()-X`
- `TimeGravityAccelerometer-std()-Y`
- `TimeGravityAccelerometer-std()-Z`
- `TimeBodyAccelerometerJerk-mean()-X`
- `TimeBodyAccelerometerJerk-mean()-Y`
- `TimeBodyAccelerometerJerk-mean()-Z`
- `TimeBodyAccelerometerJerk-std()-X`
- `TimeBodyAccelerometerJerk-std()-Y`
- `TimeBodyAccelerometerJerk-std()-Z`
- `TimeBodyGyroscope-mean()-X`
- `TimeBodyGyroscope-mean()-Y`
- `TimeBodyGyroscope-mean()-Z`
- `TimeBodyGyroscope-std()-X`
- `TimeBodyGyroscope-std()-Y`
- `TimeBodyGyroscope-std()-Z`
- `TimeBodyGyroscopeJerk-mean()-X`
- `TimeBodyGyroscopeJerk-mean()-Y`
- `TimeBodyGyroscopeJerk-mean()-Z`
- `TimeBodyGyroscopeJerk-std()-X`
- `TimeBodyGyroscopeJerk-std()-Y`
- `TimeBodyGyroscopeJerk-std()-Z`
- `TimeBodyAccelerometerMagnitude-mean()`
- `TimeBodyAccelerometerMagnitude-std()`
- `TimeGravityAccelerometerMagnitude-mean()`
- `TimeGravityAccelerometerMagnitude-std()`
- `TimeBodyAccelerometerJerkMagnitude-mean()`
- `TimeBodyAccelerometerJerkMagnitude-std()`
- `TimeBodyGyroscopeMagnitude-mean()`
- `TimeBodyGyroscopeMagnitude-std()`
- `TimeBodyGyroscopeJerkMagnitude-mean()`
- `TimeBodyGyroscopeJerkMagnitude-std()`
- `FrequencyBodyAccelerometer-mean()-X`
- `FrequencyBodyAccelerometer-mean()-Y`
- `FrequencyBodyAccelerometer-mean()-Z`
- `FrequencyBodyAccelerometer-std()-X`
- `FrequencyBodyAccelerometer-std()-Y`
- `FrequencyBodyAccelerometer-std()-Z`
- `FrequencyBodyAccelerometer-meanFreq()-X`
- `FrequencyBodyAccelerometer-meanFreq()-Y`
- `FrequencyBodyAccelerometer-meanFreq()-Z`
- `FrequencyBodyAccelerometerJerk-mean()-X`
- `FrequencyBodyAccelerometerJerk-mean()-Y`
- `FrequencyBodyAccelerometerJerk-mean()-Z`
- `FrequencyBodyAccelerometerJerk-std()-X`
- `FrequencyBodyAccelerometerJerk-std()-Y`
- `FrequencyBodyAccelerometerJerk-std()-Z`
- `FrequencyBodyAccelerometerJerk-meanFreq()-X`
- `FrequencyBodyAccelerometerJerk-meanFreq()-Y`
- `FrequencyBodyAccelerometerJerk-meanFreq()-Z`
- `FrequencyBodyGyroscope-mean()-X`
- `FrequencyBodyGyroscope-mean()-Y`
- `FrequencyBodyGyroscope-mean()-Z`
- `FrequencyBodyGyroscope-std()-X`
- `FrequencyBodyGyroscope-std()-Y`
- `FrequencyBodyGyroscope-std()-Z`
- `FrequencyBodyGyroscope-meanFreq()-X`
- `FrequencyBodyGyroscope-meanFreq()-Y`
- `FrequencyBodyGyroscope-meanFreq()-Z`
- `FrequencyBodyAccelerometerMagnitude-mean()`
- `FrequencyBodyAccelerometerMagnitude-std()`
- `FrequencyBodyAccelerometerMagnitude-meanFreq()`
- `FrequencyBodyAccelerometerJerkMagnitude-mean()`
- `FrequencyBodyAccelerometerJerkMagnitude-std()`
- `FrequencyBodyAccelerometerJerkMagnitude-meanFreq()`
- `FrequencyBodyGyroscopeMagnitude-mean()`
- `FrequencyBodyGyroscopeMagnitude-std()`
- `FrequencyBodyGyroscopeMagnitude-meanFreq()`
- `FrequencyBodyGyroscopeJerkMagnitude-mean()`
- `FrequencyBodyGyroscopeJerkMagnitude-std()`
- `FrequencyBodyGyroscopeJerkMagnitude-meanFreq()`

## Activity labels

- `WALKING`
- `WALKING_UPSTAIRS`
- `WALKING_DOWNSTAIRS`
- `SITTING`
- `STANDING`
- `LAYING`