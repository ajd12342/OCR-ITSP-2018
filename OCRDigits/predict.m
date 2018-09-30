function [p value] = predict(Theta1, Theta2, Theta3, X)
%X=double(X)/255.0;
if(size(X,3)==3)
X=double(rgb2gray(X));
end
X=1-X;
X=(scale(X)(:))';
m = size(X, 1);
num_labels = size(Theta3, 1);


p = zeros(size(X, 1), 1);
X=[ones(m,1) X];
a2=relu(X*(Theta1)');
a2=[ones(m,1) a2];
a3=relu(a2*(Theta2)');
a3=[ones(m,1) a3];
z4=a3*(Theta3)';
a4=exp(z4)./sum(exp(z4),2);
for i=1:m
  [value,index]=max(a4(i,:));
  p(i)=index-1;
end;

end
