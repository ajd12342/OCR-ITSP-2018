function [firstl, secondl]= LineSep2(img)
[ysize, xsize]=size(img);
mag=xsize;
firstl=1;
secondl=ysize;
for i=2:(ysize-1)
  nopix1=sum((img(i, :))(:));
  nopix2=sum((img(i+1,:))(:));
  if (nopix1>=mag && nopix2<mag)
   firstl=i-1;
   break;
  end
end
for i=2:ysize-1
j=ysize-i+1;
nopix1=sum((img(j, :))(:));
  nopix2=sum((img(j+1,:))(:));
  if (nopix1<mag && nopix2>=mag)
    secondl=j+2;
    break;
  end
end
end