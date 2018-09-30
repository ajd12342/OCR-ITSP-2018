function predictions=fullpredict()
close all;
pkg load image;
  load "kk.mat";
   hidden_layer_size=1500;
 num_labels=10;
 input_layer_size=784;
 hidden1=500;
 hidden2=300;
  Theta1=[b1,W1];
  Theta2=[b2,W2];
  Theta3=[b3,W3];
  load lett.mat;
  parentimg=imread('img.png');
parentimg=double(parentimg)/255;
  for iter=1:size(letter_pos_global,2)
  for iter2=1:size(letter_pos_global{iter},2)
  for iter3=1:size(letter_pos_global{iter}{iter2},1)
 left=letter_pos_global{iter}{iter2}(iter3,1);
 right=letter_pos_global{iter}{iter2}(iter3,2);
 top=letter_top_down_global{iter}{iter2}(iter3,1);
 bottom=letter_top_down_global{iter}{iter2}(iter3,2);
 img=parentimg(top:bottom,left:right);
 %imshow(img);
 %figure,imshow(img);
 %if(size(img,3)==3)
%img=double(rgb2gray(img));
%end
%img=1-img;
 %imshow(scale(img));
 %  img=(scale(img)(:))';
   %figure,imshow(reshape(img,28,28));
 %prediction=predict(Theta1,Theta2,Theta3,img);
 prediction=predict_combined(Theta1,Theta2,Theta3,img,letter_top_down_global{iter}{iter2}(iter3,3));
 %prediction
 fprintf(prediction{1,1});
 end
 fprintf(' ');
 end
 fprintf('\n');
 end
 end
 