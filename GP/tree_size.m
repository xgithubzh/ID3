function [n,vix] = tree_size(tree)
%在树中搜索有效节点，若根节点索引号=1，则表示该根节点还可以分下去，保存该根节点索引号和其对应的二叉树的分支的
%索引号；接着从其分支索引号接着搜索其是否等于1若不等则表示该分支节点为终止符该节点之后停止搜索，反之继续搜索。
%    计算树的大小
%    n <- 树的大小 size of tree
%    vix <- 结点向量的索引 index vector of nodes
nt = tree.nodetyp;
v = 1;%v是存储有效根节点索引号的，其值无法一开始确定
i = 1;
n = 1;
while i<=n 
    if nt(v(i))==1 && v(i)*2<=length(nt)
        v = [v, v(i)*2, v(i)*2+1];%无法事先设定
    end
    if v(i)*2>length(nt)       
      % 当v(i)（就是根结点的索引号）的值>16的话它所生成的左右子树的结点就大于 31 
      break;
    end
         i = i+1;
         n = length(v);
end
% Result
n = length(v);
vix = v;
return