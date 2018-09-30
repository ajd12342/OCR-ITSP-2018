function predictions=fullpredict()
pkg load image;
  load "97_5_92.mat";
 input_layer_size=784;
 hidden1=1400;
 hidden2=700;
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
 if(letter_top_down_global{iter}{iter2}(iter3,3)==0)
 [pred1,conf1]=predict_combined(Theta1,Theta2,Theta3,img, 2);
 [pred2,conf2]=predict_combined(Theta1,Theta2,Theta3,img, 3);
 if(conf1>conf2)
 prediction=pred1;
 else
 prediction=pred2;
 end
 else
 prediction=predict_combined(Theta1,Theta2,Theta3,img, 1);
 end
 %prediction
 fprintf(prediction{1,1});
 end
 fprintf(' ');
 end
 fprintf('\n');
 end
 end
 