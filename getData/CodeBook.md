* This is a codebook for run_analysis.R

There are total 68 variables.
Below is the full and detailed list of those variables.

SubjectID
- From 1 to 30. There were 30 subjects who performed the activities.

Activity
- There are 6 activities.
- WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

* For the rest of variables, here is a common description.
- Accelerometer and gyroscope captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.
- A quote from the data authors:
  "The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."
- More detailed descriptions about how the values were measured can be found on:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* There are 2 prefixes: 'time' and 'frequency'.
- 'time': the signals were captured at a constant rate of 50Hz.
          Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.
- 'frequency': a Fast Fourier Transform (FFT) was applied.

* The signals were then separated into 'Body' and 'Gravity' acceleration signals.

* Then the body linear acceleration and angular velocity were derived in time to obtain Jerk signals.
- for example: timeBodyAccelerometerJerkMeanXaxis, timeBodyGyroscopeJerMeankXaxis

* Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm.
- for example:
- timeBodyAccelerometerMagnitudeMean
- timeGravityAccelerometerMagnitudeMean
- timeBodyAccelerometerJerkMagnitudeMean
- timeBodyGyroscopeMagnitudeMean
- timeBodyGyroscopeJerkMagnitudeMean

* 2 types of variables: mean and standard deviation.
- Mean, StandartDeviation

* There are 3 postfixes: 'Xaxis', 'Yaxis' and 'Zaxis'.
- Each of them is used to denote 3-axial signals in the X, Y and Z directions.

* Below are the rest of variables.

timeBodyAccelerometerMeanXaxis
timeBodyAccelerometerMeanYaxis
timeBodyAccelerometerMeanZaxis
timeBodyAccelerometerStandardDeviationXaxis
timeBodyAccelerometerStandardDeviationYaxis
timeBodyAccelerometerStandardDeviationZaxis
timeGravityAccelerometerMeanXaxis
timeGravityAccelerometerMeanYaxis
timeGravityAccelerometerMeanZaxis
timeGravityAccelerometerStandardDeviationXaxis
timeGravityAccelerometerStandardDeviationYaxis
timeGravityAccelerometerStandardDeviationZaxis
timeBodyAccelerometerJerkMeanXaxis
timeBodyAccelerometerJerkMeanYaxis
timeBodyAccelerometerJerkMeanZaxis
timeBodyAccelerometerJerkStandardDeviationXaxis
timeBodyAccelerometerJerkStandardDeviationYaxis
timeBodyAccelerometerJerkStandardDeviationZaxis
timeBodyGyroscopeMeanXaxis
timeBodyGyroscopeMeanYaxis
timeBodyGyroscopeMeanZaxis
timeBodyGyroscopeStandardDeviationXaxis
timeBodyGyroscopeStandardDeviationYaxis
timeBodyGyroscopeStandardDeviationZaxis
timeBodyGyroscopeJerkMeanXaxis
timeBodyGyroscopeJerkMeanYaxis
timeBodyGyroscopeJerkMeanZaxis
timeBodyGyroscopeJerkStandardDeviationXaxis
timeBodyGyroscopeJerkStandardDeviationYaxis
timeBodyGyroscopeJerkStandardDeviationZaxis
timeBodyAccelerometerMagnitudeMean
timeBodyAccelerometerMagnitudeStandardDeviation
timeGravityAccelerometerMagnitudeMean
timeGravityAccelerometerMagnitudeStandardDeviation
timeBodyAccelerometerJerkMagnitudeMean
timeBodyAccelerometerJerkMagnitudeStandardDeviation
timeBodyGyroscopeMagnitudeMean
timeBodyGyroscopeMagnitudeStandardDeviation
timeBodyGyroscopeJerkMagnitudeMean
timeBodyGyroscopeJerkMagnitudeStandardDeviation
frequencyBodyAccelerometerMeanXaxis
frequencyBodyAccelerometerMeanYaxis
frequencyBodyAccelerometerMeanZaxis
frequencyBodyAccelerometerStandardDeviationXaxis
frequencyBodyAccelerometerStandardDeviationYaxis
frequencyBodyAccelerometerStandardDeviationZaxis
frequencyBodyAccelerometerJerkMeanXaxis
frequencyBodyAccelerometerJerkMeanYaxis
frequencyBodyAccelerometerJerkMeanZaxis
frequencyBodyAccelerometerJerkStandardDeviationXaxis
frequencyBodyAccelerometerJerkStandardDeviationYaxis
frequencyBodyAccelerometerJerkStandardDeviationZaxis
frequencyBodyGyroscopeMeanXaxis
frequencyBodyGyroscopeMeanYaxis
frequencyBodyGyroscopeMeanZaxis
frequencyBodyGyroscopeStandardDeviationXaxis
frequencyBodyGyroscopeStandardDeviationYaxis
frequencyBodyGyroscopeStandardDeviationZaxis
frequencyBodyAccelerometerMagnitudeMean
frequencyBodyAccelerometerMagnitudeStandardDeviation
frequencyBodyBodyAccelerometerJerkMagnitudeMean
frequencyBodyBodyAccelerometerJerkMagnitudeStandardDeviation
frequencyBodyBodyGyroscopeMagnitudeMean
frequencyBodyBodyGyroscopeMagnitudeStandardDeviation
frequencyBodyBodyGyroscopeJerkMagnitudeMean
frequencyBodyBodyGyroscopeJerkMagnitudeStandardDeviation
