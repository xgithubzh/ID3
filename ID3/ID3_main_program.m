%% 使用ID3决策树算法预测销量高低
%% 数据预处理，将cell里储存的字符串数据转换成数字型数据
close all
disp('正在进行数据预处理...');
[matrix,part_class,Attributes_data,class_data,activeAttributes]=data_exchange(source_data);
%matrix 将原数据的属性去掉，将字符串组成的数据转化成number的数据
%part_class 属性的类别
%activeAttributes 活跃的属性值；0,1向量，1表示活跃；
%Attributes_data 属性值
%class_data 将原数据的属性去除的数据。
%% 构造ID3决策树，其中make_tree_try为自定义函数将树形数据用cell形式保存
disp('数据预处理完成，正在进行构造树...');
tree=make_tree_try(matrix,Attributes_data,part_class,activeAttributes);
%tree 用元胞储存的数据，第一个数据是属性，之后是该属性对应某个类（这个类在之前以及编好顺序了）的分支。
%% 打印决策树,将树形文件以一维数组的形式展开
[nodeids_,nodevalue_,branch_] = print_tree(tree,part_class,Attributes_data);
%nodeids_% 根节点的值为0，记录子节点对应父节点的地址
%nodevalue_存放节点属性
%branch_存放枝属性
%% 画出决策树的图形，标明节点属性，叶子属性和枝类型
disp('正在打印决策树 ...')
tree_plot( nodeids_ ,nodevalue_,branch_,Attributes_data)
%% 剪枝（由于时间有限并未进行剪枝处理）
disp('ID3算法构建决策树完成！');