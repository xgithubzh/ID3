function tree = tree_crossover(tree1,tree2,dstix,nvar)
%   tree <- the subtree ����õ�������������Ҳû�о����޼�
%   treein -> the source tree  ����ĳ�ʼ��,��ʼ������û�о����޼�
%   rix -> ��Դ������������������ֵ subtree-index in source tree


% tree.nodetyp=zeros(treein.maxsize,1);
% tree.node=zeros(treein.maxsize,1);
if (dstix>tree1.maxsize)||(dstix>tree2.maxsize)
    return; 
end
% �õ�����
vin  = dstix;%����vinΪ26��ô�ڳ�ʼ����26�ڵ㴦��������
% vout = 1;
iix = 1;
while (vin(iix)<=tree1.maxsize)&&(vin(iix)<=tree2.maxsize)
  tree1.nodetyp(vin(iix)) = tree2.nodetyp(vin(iix));% �������������Ž�����
  tree1.node(vin(iix)) = tree2.node(vin(iix));
  vin = [vin vin(iix)*2 vin(iix)*2+1];
% vout = [vout vout(iix)*2 vout(iix)*2+1];
  iix = iix+1;
end
tree=tree1;

for i = (tree.maxsize+1)/2:tree.maxsize,
  if tree.nodetyp(i)==1,                          %%%%%%  1 ���������ĸ����
     tree.nodetyp(i) = 2;
     tree.node(i) = floor(nvar*rand)+1;
  end
end
return