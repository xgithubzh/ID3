function popu = initpop(popusize,maxtreedepth,symbols)
% ��ʼ����Ⱥ����
popu.generation = 1;    %������Ⱥ����
popu.symbols = symbols; %������Ⱥ���ż��ϣ�������ʾ��������ļ��ϡ�
popu.size = popusize;   %������Ⱥ����
for i = 1:popu.size   
%     popu.chrom{i}.fitness = 0;%���嵱ǰ����ĳ�ʼ����Ӧ��
%     popu.chrom{i}.mse = 0;    %
    popu.chrom{i}.tree = tree_genrnd(maxtreedepth,symbols);%������ɵ�������
end
return

% -------------------------------------------------------------------------
function tree = tree_genrnd(maxtreedepth,symbols)
% ������ɶ�������һ��������������ʽ����
% maxtreedepth=7
% symbols{1} = {'log','sin','exp','cos','cot','tan','sqrt'};
% symbols{2} = {'x'};%δ֪��������һ�㶼��������Ҷ���ϣ�����Ϊ��ֹ��
nn = [length(symbols{1}), length(symbols{2})];
n =2^floor(maxtreedepth)-1;% floor�����ǳ��Ÿ������ȡ���� floor(-1.3)=2; ������127�ڵ� 64��Ҷ��
vt = zeros(n,1);
vn = zeros(n,1);
for i=1:(n-1)/2,
  [vt(i), vn(i)] = tree_genrndsymb(1/2,nn);
end
for i=(n+1)/2:n,
  [vt(i), vn(i)] = tree_genrndsymb(1,nn);
end

tree.maxsize = n;   %�������ʽ�������е����ڵ�����
tree.nodetyp = vt;  %�ڵ�����
tree.node = vn;     %�ڵ�
% tree.param = zeros(floor((tree.maxsize+1)/2),1); %param�ǲ�������˼��ʾδ֪��x����������Ҷ������һ��
% tree.paramn = 0;
return

%------------------------------------------------------------------
function [nodetyp,node] = tree_genrndsymb(p0,nn)
%  ������ɲ�����������ֹ����
if rand<p0,
  nodetyp = 2;
else
  nodetyp = 1;
end
node = floor(nn(nodetyp)*rand)+1;%node������rand����0-1����������һ���������
return