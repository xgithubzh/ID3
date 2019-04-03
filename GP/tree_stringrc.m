function unit = tree_stringrc(tree,ix,symbols)
%最终会返回种群中随机生成的某个个体的函数表达
% Decodes the tree to string
% s = tree_stringrc(tree,ix,symbols)
%   s <- the output string
%   tree -> the tree
%   ix -> index of strating point (the root = 1)
%   symbols -> cell arrays of operator and terminator node strings

operator = {'+','-','.*','./','.^'};%定义操作符集

s= '';
%% 从上往下搜索整棵树，遇到终止符就结束，再一层层往上打印整棵树
if tree.nodetyp(ix)==1 && ix*2+1<=tree.maxsize,
  sleft = tree_stringrc(tree,ix*2,symbols);      % 左子树
  sright = tree_stringrc(tree,ix*2+1,symbols);   % 右子树
 %随机生成操作符 
  i = mod(ceil(abs(rand)*100),5)+1;
  s = operator{i}; 
  unit = strcat('(',sleft,')',s,symbols{tree.nodetyp(ix)}{tree.node(ix)}, '(',sright,')');%strcat是连接字符串函数，因为函数符在树枝的节点上，将其和两个未知数连接起来中间必须在函数符前插入一个操作符
else
    if tree.nodetyp(ix)==2,  %当nodetype=2的时候，必有node=1；与初始的个体生成方式有关
      unit = symbols{tree.nodetyp(ix)}{tree.node(ix)};%将symbol{2}中的某个终止符集赋值到unit中去，这里对应的是叶子节点
    else
%         if rand<=0.5,
            unit='x';
%         else
%             s=unifrnd(0,100);
%         end
    end
end
return