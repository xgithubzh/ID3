function tree_plot( nodeids_ ,nodevalue_,branch_,Attributes_data)
%% ²Î¿¼treeplotº¯Êý
[x,y,h]=treelayout(nodeids_);
f = find(nodeids_~=0);
pp = nodeids_(f);
X = [x(f); x(pp); NaN(size(f))];
Y = [y(f); y(pp); NaN(size(f))];
X = X(:);
Y = Y(:);
hold on ; 
plot (x, y, 'ro', X, Y, 'r-');
nodesize = length(x);
for i=1:nodesize
% text(x(i)+0.01,y(i),['node' num2str(i)]); 
    text(x(i),y(i),nodevalue_{1,i});
end
for j=1:(nodesize-1)
    text((x(nodeids_(j+1))+x(j+1))/2,(y(nodeids_(j+1))+y(j+1))/2,branch_{1,j+1});
end
hold off;

title(['Let me help you make a decision about  ' Attributes_data{length(Attributes_data)}] );
xlabel(['Number of layers = ' int2str(h)]);
axis([0 1 0 1]);
end
