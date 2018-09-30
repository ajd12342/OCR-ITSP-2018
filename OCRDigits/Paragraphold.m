%Replace scan2.png with whatever image you wish to test
%Pranay's code(13-36) will be used to isolate the first line of the image. In the next loop, the first line will be cut out, hence now the second line
%will be recognised, and so on. firstl, secondl, sequentially contain the values of the beginning and ending y-coordinates of each line. Once a line is
%isolated, we use Anuj's code(39-95) to isolate words and letters in each line, using the pixel darkness. Finally the whole thing is displayed nicely. 
pkg load image;
close all;
letter_cells={};
lines={};
letter_lines_cells={};
img=imread('img.png');
img=rgb2gray(img);
img=im2bw(img,'moments');
imshow(img);
hold on;
firstl=0;
secondl=0;
while(true)
cutimg=img((secondl+1):size(img,1),:);
prevsecondl=secondl;
%figure, imshow(cutimg);
[firstl, secondl]= lineSeparate(cutimg);
firstl=prevsecondl+firstl;
secondl=prevsecondl+secondl;
%firstl
%secondl
bw=img(firstl:secondl,:);
%figure, imshow(I);
%bw=im2bw(I,"moments");
%bw
black=ones(1,size(bw,2));
for it=1:size(bw,2)
	count=sum(bw(:,it)==0);
	if(count<=0)
		black(it)=0;
	end
end
%black
letters=[];
if(black(1)==1)
letters=[1,1];
end
for it=2:size(black,2)
	if(black(it)==1 && black(it-1)==0)
		letters=[letters;[it-1,it]];
	end
	if(black(it)==1 && black(it-1)==1)
		letters(size(letters,1),2)=letters(size(letters,1),2)+1;
	end
	if(black(it)==0 && black(it-1)==1)
		letters(size(letters,1),2)=letters(size(letters,1),2)+1;
	end
	if(black(it)==0 && black(it-1)==0)
	
	end
end
if(size(letters)==[0,0])
break
end
%letters
%imshow(bw);
temp=[letters(:,1),[0;letters(:,2)](1:end-1)];
whitelength=(temp(:,1)-temp(:,2))(2:end);
maxim=max(whitelength);
whitelength=whitelength.*(whitelength>=((maxim)/2));
words=[letters(1,1),letters(1,2)];
if(size(whitelength)~=[0,0])
for it=1:size(whitelength,1)
	if(whitelength(it)~=0)
		words=[words;[letters(it+1,1),letters(it+1,2)]];
	end
	if(whitelength(it)==0)
		words(size(words,1),2)=letters(it+1,2);
	end
end
end
letter_lines=[];
for iter=1:size(letters,1)
imgletter=img(firstl:secondl,letters(iter,1):letters(iter,2));
%figure,imshow(imgletter);
[fl sl]=LineSep2(imgletter);
fl=firstl+fl;
sl=firstl+sl;
letter_lines=[letter_lines;[fl,sl]];
end
letter_lines_cells{end+1}=letter_lines;
letter_cells{end+1}=letters;
lines{end+1}=[firstl,secondl];
%imshow(img);
%words
%{
hold on;
for it=1:size(words)
	plot([words(it,1),words(it,1)],[firstl,secondl],'g');
	plot([words(it,2),words(it,2)],[firstl,secondl],'r');
end
%}
plot([words(1,1),words(size(words,1),2)],[firstl,firstl],'y');
plot([words(1,1),words(size(words,1),2)],[secondl,secondl],'r');

%hold off;
%figure,imshow(bw);
hold on;
for it=1:size(letters,1)
	plot([letters(it,1),letters(it,1)],[letter_lines(it,1),letter_lines(it,2)],'g');
	plot([letters(it,2),letters(it,2)],[letter_lines(it,1),letter_lines(it,2)],'r');
	plot([letters(it,1),letters(it,1)],[letter_lines(it,1),letter_lines(it,1)],'y');
	plot([letters(it,2),letters(it,2)],[letter_lines(it,2),letter_lines(it,2)],'b');
end
end
save lett.mat letter_cells lines letter_lines_cells;