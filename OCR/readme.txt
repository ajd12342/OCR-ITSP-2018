============ DP Based Segementing for digits that are not ==================

================   split by the segmentation algorithm =====================


Introduction
-------------

The DP based segmentation of digits works in O((x^2)n) time and is therefore an efficient way to predict number sequences in which individual numbers aren't split up by the simple character segmentation algorithm. The contents of this folder are:

1) 591.png : This is the test image to check the algorithm.
2) emnist-trained-digits.mat : This is the trained weights for the neural network
3) predict_combined.m : This is where the DP is implemented
4) relu.m : applies RELU
5) scale.m: Applies necessary preprocessing like scaling, applying gaussian filter
6) predict.m : Returns the the label and the probability (of that label) for a particular image


Instructions maxx
------------- 

1) Open Octave/Matlab and load the trained data to give W1,b1,W2,b2,W3,b3.
2) Load the image: test_image=imread("591.png").
3) Set Theta1=[b1 W1]; Theta2=[b2 W2]; Theta3=[b3 W3]. 
4) Set n to the number of segments that you want it to be broken into.
4) Call predict_combined(Theta1,Theta2,Theta3, test_image, n)


Results
--------

In 20-30 seconds it predicts the correct answer 591. It shows that although the algorithm is slow, it solves the problem of coupling two letters into a single letter faced in earlier methods of character segmentation.
