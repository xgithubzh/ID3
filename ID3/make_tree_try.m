function [tree]=make_tree_try(matrix,Attributes_data,part_class,activeAttributes)
%% matrix 输入的转化过的数字矩阵;
% Attributes_data 属性值;{'Outlook'    'Temperatuer'    'Humidity'    'Wind'  'PlayTennis'}
%matrix    将属性类转化过的数字矩阵;
%part_class    属性的类别
%activeAttributes活跃的属性值；-1,1向量，1表示活跃；
%% 监测提供的数据是否为空，则报异常
if (isempty(matrix));
    error('必须提供数据！');
end
[rows,cols]=size(matrix);
%得到矩阵的维度
%% 前期准备
%创建树节点
tree={};

%监测最后一列是否为同一类型的数据,返回同一类型的数据
lastColumnSum=sum(matrix(:,cols));
num_class_last=length(part_class{cols});%获得最后一列的属性的类的数量
for i=1:num_class_last
    if  (lastColumnSum==((i-1)*rows))
        tree=part_class{cols}{i};
        return
    end
end

%先获得最后一列数据的每个类的统计次数，
for i=1:num_class_last
    count(i)=sum(matrix(:,cols)==i-1);
end                                 
    [~,j]=max(count);
    
%如果活跃的属性为空，则返回类标签最多的属性值
if (sum(activeAttributes) == 0);
    tree=part_class{cols}{j};
    return
end

%% 计算最后一列属性的熵
Last_Entropy0=0;
for i=1:num_class_last  
    e=count(i)/rows;
    if e==0 %在多个类的情况下某一类为零其熵也应该为零，计算机计算0*log2(0)时不会等于零而是会将他变成NAN
    else
       Last_Entropy0=-e*log2(e)+Last_Entropy0;  
    end
end


%% 得到信息增益最大的值
gains=zeros(1,cols-1);%初始化信息增益
totle={};
for i=1:length(activeAttributes)
    if (activeAttributes(i))                    %该属性仍处于活跃状态，对其更新
     num_class_current=length(part_class{i});%获得当前属性下的类的数量。
     gains(i)=Last_Entropy0;
     for j=1:num_class_current
        [single_position,~]=find(matrix(:,i)==j-1);%获得当前属性下某一类的行坐标。
        Restructure_matrix=[];%先将之前重构的数据清除；
        for n=1:length(single_position)  %重新构件子矩阵,就算length（single_position）为零程序也可正常运行
            t=single_position(n);
            Restructure_matrix(n,:)=matrix(t,:);
        end
        totle{i}{j}=Restructure_matrix;%在下面的操作时不用敲出某一已经划分出来的属性，当其类全为一类时其熵也就变为了零。
        [rows_res,cols_res]=size(Restructure_matrix);%获得子矩阵的尺寸
        Last_Entropy1=0;
        if (isempty(Restructure_matrix))  
        else
          for m=1:num_class_last     %统计子矩阵的单个类的个数,并计算熵
            count(m)=sum(Restructure_matrix(:,cols_res)==m-1);
            e=count(m)/rows_res;
            if e==0 %计算机计算0*log2(0)时不会等于零而是会将他变成NAN
            else
               Last_Entropy1=-e*log2(e)+Last_Entropy1; 
            end
          end
        end
       gains(i)=gains(i)-Last_Entropy1*length(single_position)/rows; %%%%%%%%%%%%%%%有问题  
     end 
    end
end

%% 选出最大增益
[~, max_Attribute] = max(gains);%【b,c】=max(a)求一个向量a里的最大值b,以及最大值所在的位置c
activeAttributes(max_Attribute)=0;%将相应的活跃属性置为零
tree{1} = Attributes_data{max_Attribute};%设置节点属性 
%% 获得已经分过组的子矩阵
for i=1:length(totle{max_Attribute})
    if(isempty(totle{max_Attribute}{i}))%如果子矩阵（代表树枝）为空，表明父矩阵已经无法划分出这个子矩阵了，这个子属性代表了叶节点。
        for j=1:num_class_last
            count(j)=sum(matrix(:,cols)==i-1);
        end                                 
        [~,k]=max(count);
        t=part_class{cols}{k};
        tree{i+1}=t;
        else   
        tree{i+1}=make_tree_try(totle{max_Attribute}{i},Attributes_data,part_class,activeAttributes);%子矩阵不是空矩阵表明这个还不是叶节点，需要递归。
    end
end



% for i=1:length(totle{max_Attribute})
%     switch i
%         case 1
%           if(isempty(totle{max_Attribute}{i}))%如果子矩阵（代表树枝）为空则该类不存在为空
%              class_0=struct('Attributes_Value','null','class_0','null','class_1','null','class_2','null');
%              for j=1:num_class_last
%              count(j)=sum(matrix(:,cols)==i-1);
%              end                                 
%              [~,k]=max(count);
%              class_0.Attributes_Value=part_class{cols}{k};
%              tree.class_0=class_0;
%           else   
%              tree.class_0=make_tree_try(totle{max_Attribute}{i},Attributes_data,part_class,activeAttributes);
%           end
%           
%         case 2
%              if(isempty(totle{max_Attribute}{i}))%如果子矩阵（代表树枝）为空则该类不存在为空
%               class_1=struct('Attributes_Value','null','class_0','null','class_1','null','class_2','null');
%               for j=1:num_class_last
%                   count(j)=sum(matrix(:,cols)==j-1);
%               end                                 
%               [~,k]=max(count);
%               class_1.Attributes_Value=part_class{cols}{k};
%               tree.class_1=class_1;
%              else   
%               tree.class_1=make_tree_try(totle{max_Attribute}{i},Attributes_data,part_class,activeAttributes);
%              end
%              
%         case 3
%              if(isempty(totle{max_Attribute}{i}))%如果子矩阵（代表树枝）为空则该类不存在为空
%                class_2=struct('Attributes_Value','null','class_0','null','class_1','null','class_2','null');
%                for j=1:num_class_last
%                    count(j)=sum(matrix(:,cols)==j-1);
%                end                                 
%                [~,k]=max(count);
%                class_2.Attributes_Value=part_class{cols}{k};
%                tree.class_2=class_2;
%              else   
%                tree.class_2=make_tree_try(totle{max_Attribute}{i},Attributes_data,part_class,activeAttributes);
%              end
%     end   
% end
% return
end