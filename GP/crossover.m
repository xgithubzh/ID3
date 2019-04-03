function [tree1,tree2] = crossover(treein1,treein2,rmode,symbols)
%treein1��treein2��������Ҫ�������
%rmode�ǽ���ģʽ��1--���㽻�� 2--˫�㽻��
%symbols�Ƿ��ż���
tree1 = treein1;
tree2 = treein2;
nn = [length(symbols{1}), length(symbols{2})];  %nn= [7,1];

%% Calculate indexes  ��ý����
switch rmode                            % ������������Ľ��������� 1 ���ǵ��㽻��
  case 1                                % ����ģʽΪ1ʱ�ǵ��㽻�棬ֻ��һ����֧��㴦���н���
    [~,v1] = tree_size(tree1);          % n ��ʵ��tree1 �Ĵ�С�� v1 �ǽ��������������
    [~,v2] = tree_size(tree2);          % n ��ʵ��tree2 �Ĵ�С�� v2 �ǽ��������������
    n = max([tree1.maxsize, tree2.maxsize]);
    dummy1 = zeros(n,1);
    dummy2 = zeros(n,1);
    dummy1(v1) = 1;%��ʵ�ʵ����Ľڵ�������������һ��ʾ���������
    dummy2(v2) = 1;
    v = find((dummy1+dummy2)==2);
    k(:,1)=(tree1.nodetyp(v)==2);%tree1.nodetyp(v)��tree1.nodetyp��Ԫ�ذ���v������������ҳ�������ɸ�v��С��ͬ������
    k(:,2)=(tree2.nodetyp(v)==2);
    V = find((k(:,1)+k(:,2))==2);
    K=V;
    v(K)=[];
    if isempty(v)
        v = find((dummy1+dummy2)==2); 
    end
        ix1 = v(floor(rand*(length(v))+1));%�����һ����Ӧ�ڵ㽻��
        ix2 = ix1;                         %�����Ľ���ڵ�����һ��ͬ
  case 2                               % ����ģʽΪ2ʱ��˫�㽻�棬��2����֧��㴦ͬʱ���н���
    [~,v] = tree_size(tree1);
    ix1 = v(floor(rand*(length(v))+1));
    [~,v] = tree_size(tree2);
    ix2 = v(floor(rand*(length(v))+1));
    otherwise  
    return
end

%% �������滻��������������
tree1 = tree_crossover(treein1,treein2,ix1,nn(2));
tree2 = tree_crossover(treein2,treein1,ix2,nn(2)); %�����滻
return