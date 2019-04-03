function [tree1,tree2] = crossover(treein1,treein2,rmode,symbols)
%treein1与treein2是两个需要交叉的树
%rmode是交叉模式，1--单点交叉 2--双点交叉
%symbols是符号集合
tree1 = treein1;
tree2 = treein2;
nn = [length(symbols{1}), length(symbols{2})];  %nn= [7,1];

%% Calculate indexes  获得交叉点
switch rmode                            % 在这里进行树的交叉类型是 1 就是单点交叉
  case 1                                % 交叉模式为1时是单点交叉，只在一个分支结点处进行交叉
    [~,v1] = tree_size(tree1);          % n 是实际tree1 的大小， v1 是结点向量的索引号
    [~,v2] = tree_size(tree2);          % n 是实际tree2 的大小， v2 是结点向量的索引号
    n = max([tree1.maxsize, tree2.maxsize]);
    dummy1 = zeros(n,1);
    dummy2 = zeros(n,1);
    dummy1(v1) = 1;%将实际的树的节点索引，用数字一表示出来其存在
    dummy2(v2) = 1;
    v = find((dummy1+dummy2)==2);
    k(:,1)=(tree1.nodetyp(v)==2);%tree1.nodetyp(v)将tree1.nodetyp中元素按照v中数组的索引找出来，组成跟v大小相同的数组
    k(:,2)=(tree2.nodetyp(v)==2);
    V = find((k(:,1)+k(:,2))==2);
    K=V;
    v(K)=[];
    if isempty(v)
        v = find((dummy1+dummy2)==2); 
    end
        ix1 = v(floor(rand*(length(v))+1));%随机找一个对应节点交叉
        ix2 = ix1;                         %树二的交叉节点与树一相同
  case 2                               % 交叉模式为2时是双点交叉，在2个分支结点处同时进行交叉
    [~,v] = tree_size(tree1);
    ix1 = v(floor(rand*(length(v))+1));
    [~,v] = tree_size(tree2);
    ix2 = v(floor(rand*(length(v))+1));
    otherwise  
    return
end

%% 子树的替换，二叉树的重组
tree1 = tree_crossover(treein1,treein2,ix1,nn(2));
tree2 = tree_crossover(treein2,treein1,ix2,nn(2)); %子树替换
return