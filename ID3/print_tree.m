function [nodeids_,nodevalue_,branch_] = print_tree(tree,part_class,Attributes_data)
%% ��ӡ�����������Ĺ�ϵ����
global nodeid nodeids nodevalue branch ;
nodeids=[];
nodeids(1)=0; % ���ڵ��ֵΪ0����¼�ӽڵ��Ӧ���ڵ�ĵ�ַ
nodeid=0;     %���������ж��ٸ��ڵ�
nodevalue={}; %��Žڵ�����
branch={}     ;%���֦����
if isempty(tree) 
    disp('������');
    return ;
end
queue={tree};%%�����⣬�ڵ����Բ�����֦����
while ~isempty(queue) % ���в�Ϊ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����
    if isempty(queue)
    disp('����Ϊ�գ����ܷ��ʣ�');
    return;
    end
    node = queue(1); % ��һ��Ԫ�ص���
    queue=queue(2:end); % �����ƶ�һ��Ԫ��λ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%����
    if ischar(node{1})%%%%%%%����ж��Ƿ���Ҷ��ͨ���жϸ��������Ƿ���char�����ݣ�������cell������Ҫ��������
        nodeid=nodeid+1;
        fprintf('Ҷ�ӽڵ㣬node: %d\t������ֵ: %s\n',nodeid, node{1});
        nodevalue{1,nodeid}=node{1};
    else % Ҫô��Ҷ�ӽڵ㣬Ҫô����
        nodeid=nodeid+1;
        local_attributes=find(strcmp(Attributes_data,node{1}{1}));%��ýڵ�����������������е�λ��
        for i=1:(length(node{1})-1)
           branch(nodeid+length(queue)+i)={part_class{local_attributes}{i}};%���������µ�����������ŵ�һά������ȥ���������Խ�һ�����Ӷ���Ҷ����һά��ʽչ����
           nodeids(nodeid+length(queue)+i)=nodeid;
        end 
        [t]=find(nodeids==nodeid);%Ѱ�Ҷ�Ӧ�������ڵ�
        q=num2str(t);
        fprintf('node:%d\t ����ֵ:%s\t, �����ڵ㣺node %s\n',nodeid,node{1}{1},q);
        nodevalue{1,nodeid}=node{1}{1};
        for i=1:(length(node{1})-1)
           queue=[queue,{node{1}{i+1}}];%%���ӣ����ӽڵ�һһ��ȡ�����ŵ��ж���   
        end
    end
end
nodeids_=nodeids;
nodevalue_=nodevalue;
branch_=branch;
end
