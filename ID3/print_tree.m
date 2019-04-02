function [nodeids_,nodevalue_,branch_] = print_tree(tree,part_class,Attributes_data)
%% 打印树，返回树的关系向量
global nodeid nodeids nodevalue branch ;
nodeids=[];
nodeids(1)=0; % 根节点的值为0，记录子节点对应父节点的地址
nodeid=0;     %计数，计有多少个节点
nodevalue={}; %存放节点属性
branch={}     ;%存放枝属性
if isempty(tree) 
    disp('空树！');
    return ;
end
queue={tree};%%有问题，节点属性不可与枝并列
while ~isempty(queue) % 队列不为空
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%出队
    if isempty(queue)
    disp('队列为空，不能访问！');
    return;
    end
    node = queue(1); % 第一个元素弹出
    queue=queue(2:end); % 往后移动一个元素位置
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%出队
    if ischar(node{1})%%%%%%%如何判断是否是叶，通过判断该组数据是否是char型数据，否则是cell数据需要继续划分
        nodeid=nodeid+1;
        fprintf('叶子节点，node: %d\t，属性值: %s\n',nodeid, node{1});
        nodevalue{1,nodeid}=node{1};
    else % 要么是叶子节点，要么不是
        nodeid=nodeid+1;
        local_attributes=find(strcmp(Attributes_data,node{1}{1}));%获得节点的属性在属性数据中的位置
        for i=1:(length(node{1})-1)
           branch(nodeid+length(queue)+i)={part_class{local_attributes}{i}};%将该属性下的类提出来，放到一维数组中去，这样可以讲一棵树从顶到叶子以一维形式展开。
           nodeids(nodeid+length(queue)+i)=nodeid;
        end 
        [t]=find(nodeids==nodeid);%寻找对应的子树节点
        q=num2str(t);
        fprintf('node:%d\t 属性值:%s\t, 子树节点：node %s\n',nodeid,node{1}{1},q);
        nodevalue{1,nodeid}=node{1}{1};
        for i=1:(length(node{1})-1)
           queue=[queue,{node{1}{i+1}}];%%进队，将子节点一一提取出来放到列队里   
        end
    end
end
nodeids_=nodeids;
nodevalue_=nodevalue;
branch_=branch;
end
