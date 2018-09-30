function normalised=scale(matrix)
     pkg load image;
[m n]=size(matrix);
matrix=imresize(matrix,28/m);
[m n]=size(matrix);
left=floor((m-n)/2);
right=m-n-left;
right_m=zeros(m,right);
left_m=zeros(m,left);
matrix=[matrix,right_m];
matrix=[left_m,matrix];
matrix=imresize(matrix, [28,28]);
h=fspecial('gaussian',[3 3], 1);
matrix = imfilter(matrix,h);
%matrix=fliplr(rot90(matrix));

normalised=double(matrix);
end