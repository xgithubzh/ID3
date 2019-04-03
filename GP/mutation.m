function tree = mutation(treein,symbols)

tree = treein;
nn = [length(symbols{1}), length(symbols{2})];
% Mutate one node
[~,v] = tree_size(tree);           %得到实际树的节点索引
i = v(floor(rand*(length(v))+1));  %随机生成变异节点
if i<(tree.maxsize+1)/2 && rand<0.5
  [tree.nodetyp(i), tree.node(i)] = tree_genrndsymb(abs(rand-0.5),nn); %
else
  while tree.node(i)==treein.node(i) && tree.nodetyp(i)==treein.nodetyp(i)
    [tree.nodetyp(i) ,tree.node(i)] = tree_genrndsymb(abs(rand-0.5),nn);
  end
end
return
%------------------------------------------------------------------
function [nodetyp,node] = tree_genrndsymb(p0,nn)

if rand<p0   
  nodetyp = 2;
else
  nodetyp = 1;
end
node = floor(nn(nodetyp)*rand)+1;
return