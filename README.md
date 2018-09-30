# OCR-ITSP-2018
### Optical character recognition using the EMNIST dataset and self-designed image segmentation and processing algorithms. Capable of recognizing text from a relatively clean image of a document. The project report is a good place to start for understanding how the project works.

The OCR folder contains code to run on English characters and the OCRDigits folder contains code to run on numeric digits. The latter has a much greater accuracy.

Steps to run the code for OCR and OCRDigits:
1.The folder contains a pretrained model `97_5_92.mat`(for OCR) or `kk.mat`(for OCRDigits) which was trained separately using Tensorflow on Python. First, place your image in this folder and name it `img.png`. Run `Paragraph.m` using either MATLAB or Octave. An image will appear onscreen showing the segmentation and `lett.mat` will be created, which contains information for running the prediction algorithm.
2.Then run `fullpredict.m`. The predicted output will be shown on the terminal.

Stay tuned for the steps to generate the model using Tensorflow!

