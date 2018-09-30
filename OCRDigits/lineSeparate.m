function [firstl, secondl]= lineSeparate(img)
[ysize, xsize]=size(img);
mag=xsize;
firstl=1;
secondl=1;
for i=1:(ysize-1)
  nopix1=sum((img(i, :))(:));
  nopix2=sum((img(i+1,:))(:));
  if (nopix1>=mag && nopix2<mag)
   firstl=i-1;
  elseif (nopix1<mag && nopix2>=mag)
    secondl=i+2;
    break;
  end
end

end