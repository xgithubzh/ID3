function [matrix,part_class,Attributes_data,class_data,activeAttributes]=data_exchange(source_data)
Attributes_data=source_data(1,:);%%��������
class_data=source_data(2:end,:);%%�������
[rows,cols]=size(class_data);
matrix=zeros(rows,cols);
activeAttributes=ones(1,length(Attributes_data)-1);%��ʼ��activeAttributes��Ծ������ֵ��-1,1������1��ʾ��Ծ��
%%���������в�ͬԪ�أ���ʼ����һ��Ԫ��Ϊ0������ĳ�е�i�����ݣ�����i�����ݾ���֮ǰi-1�����ݱȽ���ͬ���ó�ͬһ�����ݣ���ͬ����֮ǰi-1������Ѱ�����ֵ��һ��
for j=1:cols
    k=2;
    a=class_data(1,j);
    matrix_class=a;%%ֻ������һ������ ����������ȫ��Ĩ����
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