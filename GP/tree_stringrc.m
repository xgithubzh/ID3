function unit = tree_stringrc(tree,ix,symbols)
%���ջ᷵����Ⱥ��������ɵ�ĳ������ĺ������
% Decodes the tree to string
% s = tree_stringrc(tree,ix,symbols)
%   s <- the output string
%   tree -> the tree
%   ix -> index of strating point (the root = 1)
%   symbols -> cell arrays of operator and terminator node strings

operator = {'+','-','.*','./','.^'};%�����������

s= '';
%% ��������������������������ֹ���ͽ�������һ������ϴ�ӡ������
if tree.nodetyp(ix)==1 && ix*2+1<=tree.maxsize,
  sleft = tree_stringrc(tree,ix*2,symbols);      % ������
  sright = tree_stringrc(tree,ix*2+1,symbols);   % ������
 %������ɲ����� 
  i = mod(ceil(abs(rand)*100),5)+1;
  s = operator{i}; 
  unit = strcat('(',sleft,')',s,symbols{tree.nodetyp(ix)}{tree.node(ix)}, '(',sright,')');%strcat�������ַ�����������Ϊ����������֦�Ľڵ��ϣ����������δ֪�����������м�����ں�����ǰ����һ��������
else
    if tree.nodetyp(ix)==2,  %��nodetype=2��ʱ�򣬱���node=1�����ʼ�ĸ������ɷ�ʽ�й�
      unit = symbols{tree.nodetyp(ix)}{tree.node(ix)};%��symbol{2}�е�ĳ����ֹ������ֵ��unit��ȥ�������Ӧ����Ҷ�ӽڵ�
    else
%         if rand<=0.5,
            unit='x';
%         else
%             s=unifrnd(0,100);
%         end
    end
end
return