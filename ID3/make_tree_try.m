function [tree]=make_tree_try(matrix,Attributes_data,part_class,activeAttributes)
%% matrix �����ת���������־���;
% Attributes_data ����ֵ;{'Outlook'    'Temperatuer'    'Humidity'    'Wind'  'PlayTennis'}
%matrix    ��������ת���������־���;
%part_class    ���Ե����
%activeAttributes��Ծ������ֵ��-1,1������1��ʾ��Ծ��
%% ����ṩ�������Ƿ�Ϊ�գ����쳣
if (isempty(matrix));
    error('�����ṩ���ݣ�');
end
[rows,cols]=size(matrix);
%�õ������ά��
%% ǰ��׼��
%�������ڵ�
tree={};

%������һ���Ƿ�Ϊͬһ���͵�����,����ͬһ���͵�����
lastColumnSum=sum(matrix(:,cols));
num_class_last=length(part_class{cols});%������һ�е����Ե��������
for i=1:num_class_last
    if  (lastColumnSum==((i-1)*rows))
        tree=part_class{cols}{i};
        return
    end
end

%�Ȼ�����һ�����ݵ�ÿ�����ͳ�ƴ�����
for i=1:num_class_last
    count(i)=sum(matrix(:,cols)==i-1);
end                                 
    [~,j]=max(count);
    
%�����Ծ������Ϊ�գ��򷵻����ǩ��������ֵ
if (sum(activeAttributes) == 0);
    tree=part_class{cols}{j};
    return
end

%% �������һ�����Ե���
Last_Entropy0=0;
for i=1:num_class_last  
    e=count(i)/rows;
    if e==0 %�ڶ����������ĳһ��Ϊ������ҲӦ��Ϊ�㣬���������0*log2(0)ʱ�����������ǻὫ�����NAN
    else
       Last_Entropy0=-e*log2(e)+Last_Entropy0;  
    end
end


%% �õ���Ϣ��������ֵ
gains=zeros(1,cols-1);%��ʼ����Ϣ����
totle={};
for i=1:length(activeAttributes)
    if (activeAttributes(i))                    %�������Դ��ڻ�Ծ״̬���������
     num_class_current=length(part_class{i});%��õ�ǰ�����µ����������
     gains(i)=Last_Entropy0;
     for j=1:num_class_current
        [single_position,~]=find(matrix(:,i)==j-1);%��õ�ǰ������ĳһ��������ꡣ
        Restructure_matrix=[];%�Ƚ�֮ǰ�ع������������
        for n=1:length(single_position)  %���¹����Ӿ���,����length��single_position��Ϊ�����Ҳ����������
            t=single_position(n);
            Restructure_matrix(n,:)=matrix(t,:);
        end
        totle{i}{j}=Restructure_matrix;%������Ĳ���ʱ�����ó�ĳһ�Ѿ����ֳ��������ԣ�������ȫΪһ��ʱ����Ҳ�ͱ�Ϊ���㡣
        [rows_res,cols_res]=size(Restructure_matrix);%����Ӿ���ĳߴ�
        Last_Entropy1=0;
        if (isempty(Restructure_matrix))  
        else
          for m=1:num_class_last     %ͳ���Ӿ���ĵ�����ĸ���,��������
            count(m)=sum(Restructure_matrix(:,cols_res)==m-1);
            e=count(m)/rows_res;
            if e==0 %���������0*log2(0)ʱ�����������ǻὫ�����NAN
            else
               Last_Entropy1=-e*log2(e)+Last_Entropy1; 
            end
          end
        end
       gains(i)=gains(i)-Last_Entropy1*length(single_position)/rows; %%%%%%%%%%%%%%%������  
     end 
    end
end

%% ѡ���������
[~, max_Attribute] = max(gains);%��b,c��=max(a)��һ������a������ֵb,�Լ����ֵ���ڵ�λ��c
activeAttributes(max_Attribute)=0;%����Ӧ�Ļ�Ծ������Ϊ��
tree{1} = Attributes_data{max_Attribute};%���ýڵ����� 
%% ����Ѿ��ֹ�����Ӿ���
for i=1:length(totle{max_Attribute})
    if(isempty(totle{max_Attribute}{i}))%����Ӿ��󣨴�����֦��Ϊ�գ������������Ѿ��޷����ֳ�����Ӿ����ˣ���������Դ�����Ҷ�ڵ㡣
        for j=1:num_class_last
            count(j)=sum(matrix(:,cols)==i-1);
        end                                 
        [~,k]=max(count);
        t=part_class{cols}{k};
        tree{i+1}=t;
        else   
        tree{i+1}=make_tree_try(totle{max_Attribute}{i},Attributes_data,part_class,activeAttributes);%�Ӿ����ǿվ���������������Ҷ�ڵ㣬��Ҫ�ݹ顣
    end
end



% for i=1:length(totle{max_Attribute})
%     switch i
%         case 1
%           if(isempty(totle{max_Attribute}{i}))%����Ӿ��󣨴�����֦��Ϊ������಻����Ϊ��
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
%              if(isempty(totle{max_Attribute}{i}))%����Ӿ��󣨴�����֦��Ϊ������಻����Ϊ��
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
%              if(isempty(totle{max_Attribute}{i}))%����Ӿ��󣨴�����֦��Ϊ������಻����Ϊ��
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