function prediction= predict_combined(Theta1, Theta2, Theta3, parentimg, no_char_combined)
  parentimg=rgb2gray(parentimg);
  parentimg=255.0-parentimg;
  parentimg=parentimg/255;
  [ysize xsize]=size(parentimg);
  dp_products=zeros(no_char_combined, xsize);
  dp_answers= cell(no_char_combined,xsize);
  reducedsize=30;
  parentimg=imresize(parentimg, reducedsize/xsize);
  [ysize xsize]=size(parentimg);
  for j=1:no_char_combined
    for i=1:reducedsize
     if j==1
    img=parentimg(:, 1:i);
    img=(scale(img)(:))';
    img=img*255;
    [o ,dp_products(j,i)]=predict(Theta1,Theta2,Theta3,img);
    dp_answers(j,i)=char(48+o);
    else
    for t=1:i-1
      img=parentimg(:,t+1:i);
      img=(scale(img)(:))';
      img=img*255;
      [value,confidence]=predict(Theta1,Theta2,Theta3,img);
      if (dp_products(j-1,t)*confidence)>dp_products(j,i)
      dp_products(j,i)=dp_products(j-1,t)*confidence;
      dp_answers(j,i)=strcat(dp_answers(j-1,t),char(48+value));
      endif
    endfor
  endif
endfor
endfor
prediction=dp_answers(no_char_combined, reducedsize);
endfunction
