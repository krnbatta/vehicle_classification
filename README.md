# AUTOMATIC IMAGE BASED CAR TYPE DETECTION AND CLASSIFICATION USING NEURAL NETWORK
The project deals with the classification of different types of cars by feature extraction and then
training them with artificial neural network systems using images of cars as input. Various stages
in car recognition are feature extraction, training followed by classification.
The presented approach uses log Gabor filter responses to effectively represent the object image.
The choice of log Gabor filter responses is biologically motivated because they model the
response properties of human visual cortical cells. The Gabor filter representation in fact
increases the dimensions of the feature space such that salient features can effectively be
discriminated in the extended feature space.

## Objective
The objective of our project is to recognize the type of a car present in a segmented image.
The car can be classified as any one of the following:

1. Sedan
2. Hatchback
3. SUV (Suburban Utility Vehicle)

It uses log gabor filters for feature extraction. The segmented image is convolved with 40 gabor
filters each returning two features : Mean Amplitude and Squared Energy. Thus we obtain a
feature vector of size 80 for each image in the training dataset giving us a feature matrix. This
matrix is used for training a neural network for classification.

The system has achieved an overall accuracy of 84%. Overfitting of the model has been
minimised using a validation set during the training process of the model. It has been
implemented on MATLAB and provides a GUI (Graphical User Interface) for easy interaction
with the user.

## Dataset
The Standard Data set used is The TU Darmstadt Database
Authors : Bastian Leibe and Bernt Schiele from Darmstadt University of Technology

It Contains side views of different types of cars. The original ground truth data provided by the
authors is given in terms of pixel segmentation masks for the cars.

The database has side views of cars which have been mirrored too. All cars have roughly the
same scale and occur in the centre of the image. There is only one car per image.

A link to the dataset is given below:

http://pascallin.ecs.soton.ac.uk/challenges/VOC/databases.html#TUD
