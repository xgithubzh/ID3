%% ʹ��ID3�������㷨Ԥ�������ߵ�
%% ����Ԥ������cell�ﴢ����ַ�������ת��������������
close all
disp('���ڽ�������Ԥ����...');
[matrix,part_class,Attributes_data,class_data,activeAttributes]=data_exchange(source_data);
%matrix ��ԭ���ݵ�����ȥ�������ַ�����ɵ�����ת����number������
%part_class ���Ե����
%activeAttributes ��Ծ������ֵ��0,1������1��ʾ��Ծ��
%Attributes_data ����ֵ
%class_data ��ԭ���ݵ�����ȥ�������ݡ�
%% ����ID3������������make_tree_tryΪ�Զ��庯��������������cell��ʽ����
disp('����Ԥ������ɣ����ڽ��й�����...');
tree=make_tree_try(matrix,Attributes_data,part_class,activeAttributes);
%tree ��Ԫ����������ݣ���һ�����������ԣ�֮���Ǹ����Զ�Ӧĳ���ࣨ�������֮ǰ�Լ����˳���ˣ��ķ�֧��
%% ��ӡ������,�������ļ���һά�������ʽչ��
[nodeids_,nodevalue_,branch_] = print_tree(tree,part_class,Attributes_data);
%nodeids_% ���ڵ��ֵΪ0����¼�ӽڵ��Ӧ���ڵ�ĵ�ַ
%nodevalue_��Žڵ�����
%branch_���֦����
%% ������������ͼ�Σ������ڵ����ԣ�Ҷ�����Ժ�֦����
disp('���ڴ�ӡ������ ...')
tree_plot( nodeids_ ,nodevalue_,branch_,Attributes_data)
%% ��֦������ʱ�����޲�δ���м�֦����
disp('ID3�㷨������������ɣ�');