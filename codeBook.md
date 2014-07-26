CodeBook.md
===========

Format
------
* Value are separated by the space character.
* The first line is the header of the dataset.
* There is no rowname.

Variable
--------
* Activity is the activity done by the subject during the experiment.
* Subject is the id given to the person doing the activity
* All other column are average of values measured during the experiment. The name of the variable gives the type of the signals 
 * t denotes time
 * f denotes a fourier transformation
 * -X,-Y,-Z: 3-axial signals in the X, Y and Z directions respectively
 * Acc and Gyro denotes the accelerometer and gyroscope 3-axial raw signals
 * BodyAcc and GravityAcc are acceleration signal separated into body and gravity acceleration signals
 * Jerk denotes jerk signals
 * mag denotes magnitudes of the three-dimensional, calculated using the Euclidean norm
  * mean() denotes mean value and std() denotes standard deviation
 
Transformation
--------------
In the original dataset there are several measurements for each subject and activity. We transform the data so we have the average for each subject and for each activity.
