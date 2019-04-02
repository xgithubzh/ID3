function [matrix,part_class,Attributes_data,class_data,activeAttributes]=data_exchange(source_data)
Attributes_data=source_data(1,:);%%属性数据
class_data=source_data(2:end,:);%%类别数据
[rows,cols]=size(class_data);
matrix=zeros(rows,cols);
activeAttributes=ones(1,length(Attributes_data)-1);%初始化activeAttributes活跃的属性值；-1,1向量，1表示活跃；
%%搜索数组中不同元素，初始化第一个元素为0，读到某列的i个数据，将第i个数据均与之前i-1个数据比较相同则置成同一个数据，不同则监测之前i-1个数据寻找最大值加一。
for j=1:cols
    k=2;
    a=class_data(1,j);
    matrix_class=a;%%只保留第一个数据 其他类数据全被抹除掉
    for i=2:rows
        flag=0;
        for m=1:i-1
          if strcmp(class_data(m,j),class_data(i,j))
             matrix(i,j)=matrix(m,j);
             flag=1;
          else if m==i-1  
               if flag==0
                      matrix(i,j)=max(matrix(1:i-1,j))+1;
                      matrix_class(k)=class_data(i,j);
                      k=k+1;
                  else
               end
              end
          end
        end
    end 
    part_class{j}=matrix_class;
end
end