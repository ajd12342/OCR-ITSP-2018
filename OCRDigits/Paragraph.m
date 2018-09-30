%Replace scan2.png with whatever image you wish to test
%Pranay's code(13-36) will be used to isolate the first line of the image. In the next loop, the first line will be cut out, hence now the second line
%will be recognised, and so on. firstl, secondl, sequentially contain the values of the beginning and ending y-coordinates of each line. Once a line is
%isolated, we use Anuj's code(39-95) to isolate words and letters in each line, using the pixel darkness. Finally the whole thing is displayed nicely. 
pkg load image;
close all;
%letter_cells={};
lines={};
%letter_lines_cells={};
letter_top_down_global={};
letter_pos_global={};
global_max=-1;
global_charl=-1;
charnum=0;
actualimg=imread('img.png');
if(size(actualimg,3)==3)
actualimg=rgb2gray(actualimg);
end
imshow(actualimg);
hold on;
firstl=0;
secondl=0;
while(true)
if((secondl+1)>size(actualimg,1))
break;
end %FIX THIS LATER
cutimg=actualimg((secondl+1):size(actualimg,1),:);
cutimg=im2bw(cutimg);
prevsecondl=secondl;
%figure, imshow(cutimg);
[firstl, secondl]= lineSeparate(cutimg);
if(firstl>secondl)
break;
end
bw=cutimg(firstl:secondl,:);
firstl=prevsecondl+firstl;
secondl=prevsecondl+secondl;
%firstl
%secondl
%figure, imshow(I);
%bw=im2bw(I,"moments");
%bw
letters=seg2letters(bw);
if(size(letters)==[0,0])
break
end
%letters
%imshow(bw);
temp=[letters(:,1),[0;letters(:,2)](1:end-1)];
whitelength=(temp(:,1)-temp(:,2))(2:end);
global_max=max(max(whitelength),global_max);
whitelength=whitelength.*(whitelength>=((global_max)/2));
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
%letters=[];
letter_lines_words_cell={};
word_letters_cell={};
charnumline=0;
charlenline=[];
for wordit=1:size(words,1)
	letter_lines=[];
	wordimg=im2bw(actualimg(firstl:secondl,words(wordit,1):words(wordit,2)));
	wordletters=seg2letters(wordimg);
	for iter=1:size(wordletters)
	imgletter=wordimg(:,wordletters(iter,1):wordletters(iter,2));
	[fl sl]=LineSep2(imgletter);
	fl=firstl+fl;
	sl=firstl+sl;
	letter_lines=[letter_lines;[fl,sl,1]];
	end
	charlenline=[charlenline;wordletters(:,2)-wordletters(:,1)];
	charnumline=charnumline+size(wordletters,1);
	wordletters=wordletters+words(wordit,1)-1;
	letter_lines_words_cell{end+1}=letter_lines;
	word_letters_cell{end+1}=wordletters;
	%letters=[letters;wordletters];
end
%charlenline
global_charl=(charnum*global_charl+sum(charlenline))/(charnum+charnumline);
charnum=charnum+charnumline;
countofletters=0;
for itr=1:size(letter_lines_words_cell,1)
prevcount=countofletters+1;
countofletters=countofletters+size(letter_lines_words_cell{itr},1);
letter_lines_words_cell{itr}(:,3)=max(round(double(charlenline(prevcount:countofletters))/global_charl),1);
endfor
%{
letter_lines=[];
for iter=1:size(letters,1)
imgletter=img(firstl:secondl,letters(iter,1):letters(iter,2));
%figure,imshow(imgletter);
[fl sl]=LineSep2(imgletter);
fl=firstl+fl;
sl=firstl+sl;
letter_lines=[letter_lines;[fl,sl]];
end
%}
%letter_lines_cells{end+1}=letter_lines;
%letter_cells{end+1}=letters;
lines{end+1}=[firstl,secondl];
letter_top_down_global{end+1}=letter_lines_words_cell;
letter_pos_global{end+1}=word_letters_cell;
%imshow(img);
%words
%{
hold on;
for it=1:size(words)
	plot([words(it,1),words(it,1)],[firstl,secondl],'g');
	plot([words(it,2),words(it,2)],[firstl,secondl],'r');
end
%}
%Comment 
hold on;
plot([words(1,1),words(size(words,1),2)],[firstl,firstl],'y');
plot([words(1,1),words(size(words,1),2)],[secondl,secondl],'r');

%hold off;
%figure,imshow(bw);

hold on;
for it1=1:size(word_letters_cell,2)
for it2=1:size(word_letters_cell{it1},1)
	plot([word_letters_cell{it1}(it2,1),word_letters_cell{it1}(it2,1)],[letter_lines_words_cell{it1}(it2,1),letter_lines_words_cell{it1}(it2,2)],'g');
	plot([word_letters_cell{it1}(it2,2),word_letters_cell{it1}(it2,2)],[letter_lines_words_cell{it1}(it2,1),letter_lines_words_cell{it1}(it2,2)],'r');
	plot([word_letters_cell{it1}(it2,1),word_letters_cell{it1}(it2,2)],[letter_lines_words_cell{it1}(it2,1),letter_lines_words_cell{it1}(it2,1)],'y');
	plot([word_letters_cell{it1}(it2,1),word_letters_cell{it1}(it2,2)],[letter_lines_words_cell{it1}(it2,2),letter_lines_words_cell{it1}(it2,2)],'g');

end
end
end
%letter_pos_global
%letter_top_down_global
save lett.mat letter_top_down_global letter_pos_global;