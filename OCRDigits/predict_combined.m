function prediction= predict_combined(Theta1, Theta2, Theta3, parentimg, no_char_combined)
pkg load image;
  %if(size(parentimg,3)==3)
  %parentimg=rgb2gray(parentimg);
  %end
  %parentimg=im2bw(double(parentimg));
  %parentimg=double(1-parentimg);
  %imshow(parentimg);
  [ysize xsize]=size(parentimg);
  dp_products=zeros(no_char_combined, xsize);
  dp_answers= cell(no_char_combined,xsize);
  if(xsize>30)
  reducedsize=6;
  parentimg=imresize(parentimg, reducedsize/xsize);
  end
  [ysize xsize]=size(parentimg);
 % parentimg=1-parentimg;
  %figure,imshow(parentimg);
  tcut=-1;
  if(no_char_combined==1)
	%parentimg=(scale(parentimg)(:))';
	o=predict(Theta1,Theta2,Theta3,parentimg);
	dp_answers(1,xsize)=char(48+o);
  else
  for j=1:no_char_combined
    for i=1:xsize
     if j==1
    img=parentimg(:, 1:i);
    img=(scale(img)(:))';
    [o ,dp_products(j,i)]=predict(Theta1,Theta2,Theta3,img);
    dp_answers(j,i)=char(48+o);
    else
    for t=1:i-1
      img=parentimg(:,t+1:i);
      img=(scale(img)(:))';
      [value,confidence]=predict(Theta1,Theta2,Theta3,img);
      if (dp_products(j-1,t)*confidence)>dp_products(j,i)
	  if(i==xsize&&j==2)
			tcut=t;
	  endif
      dp_products(j,i)=dp_products(j-1,t)*confidence;
      dp_answers(j,i)=strcat(dp_answers(j-1,t),char(48+value));
      endif
    endfor
  endif
endfor
endfor
endif
prediction=dp_answers(no_char_combined, xsize);
%hold on;
%tcut
%plot([1,ysize],[tcut,tcut],'r');
endfunction