function tree = tree_crossover(tree1,tree2,dstix,nvar)
%   tree <- the subtree 结果得到的子树，子树也没有经过修剪
%   treein -> the source tree  输入的初始树,初始的树并没有经过修剪
%   rix -> 在源二叉树中子树的索引值 subtree-index in source tree


% tree.nodetyp=zeros(treein.maxsize,1);
% tree.node=zeros(treein.maxsize,1);
if (dstix>tree1.maxsize)||(dstix>tree2.maxsize)
    return; 
end
% 得到子树
vin  = dstix;%假设vin为26那么在初始树的26节点处剪下子树
% vout = 1;
iix = 1;
while (vin(iix)<=tree1.maxsize)&&(vin(iix)<=tree2.maxsize)
  tree1.nodetyp(vin(iix)) = tree2.nodetyp(vin(iix));% 这个条件不满足才结束。
  tree1.node(vin(iix)) = tree2.node(vin(iix));
  vin = [vin vin(iix)*2 vin(iix)*2+1];
% vout = [vout vout(iix)*2 vout(iix)*2+1];
  iix = iix+1;
end
tree=tree1;

for i = (tree.maxsize+1)/2:tree.maxsize,
  if tree.nodetyp(i)==1,                          %%%%%%  1 代表是树的根结点
     tree.nodetyp(i) = 2;
     tree.node(i) = floor(nvar*rand)+1;
  end
end
return