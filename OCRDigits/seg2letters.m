%Given a line/word, segment into characters and return the starting and ending of each character, relative to the line/word
%Input should be a b/w image
function [letters]=seg2letters(bw)
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
end