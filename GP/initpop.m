function popu = initpop(popusize,maxtreedepth,symbols)
% 初始化种群个体
popu.generation = 1;    %定义种群代数
popu.symbols = symbols; %定义种群符号集合，用来表示单个个体的集合。
popu.size = popusize;   %定义种群数量
for i = 1:popu.size   
%     popu.chrom{i}.fitness = 0;%定义当前个体的初始的适应度
%     popu.chrom{i}.mse = 0;    %
    popu.chrom{i}.tree = tree_genrnd(maxtreedepth,symbols);%随机生成单个个体
end
return

% -------------------------------------------------------------------------
function tree = tree_genrnd(maxtreedepth,symbols)
% 随机生成二叉树，一个函数用树的形式保存
% maxtreedepth=7
% symbols{1} = {'log','sin','exp','cos','cot','tan','sqrt'};
% symbols{2} = {'x'};%未知数及常量一般都是在树的叶子上，可视为终止符
nn = [length(symbols{1}), length(symbols{2})];
n =2^floor(maxtreedepth)-1;% floor函数是朝着负无穷方向取整数 floor(-1.3)=2; 这里是127节点 64个叶子
vt = zeros(n,1);
vn = zeros(n,1);
for i=1:(n-1)/2,
  [vt(i), vn(i)] = tree_genrndsymb(1/2,nn);
end
for i=(n+1)/2:n,
  [vt(i), vn(i)] = tree_genrndsymb(1,nn);
end

tree.maxsize = n;   %函数表达式树所具有的最大节点数量
tree.nodetyp = vt;  %节点类型
tree.node = vn;     %节点
% tree.param = zeros(floor((tree.maxsize+1)/2),1); %param是参数的意思表示未知数x，其数量与叶子数量一致
% tree.paramn = 0;
return

%------------------------------------------------------------------
function [nodetyp,node] = tree_genrndsymb(p0,nn)
%  随机生成操作符集和终止符集
if rand<p0,
  nodetyp = 2;
else
  nodetyp = 1;
end
node = floor(nn(nodetyp)*rand)+1;%node的数字rand是在0-1产生不包括一的随机数。
return