%%
clc;
clear;
data_num=2;
switch  data_num 
    case 1
        x =1:10;
        w=[0.2500 0.1000 0.0110 0.6900 0.3100 0.0410 0.9030 0.7652 0.5190 0.3167];
    case 2
        x = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207];
        w = [39 10 4 36 4 5 4 91 49 1 25 1 4 30 42 9 49 44 32 3 78 1 30 205 5 129 103 224 186 53 14 9 2 10 1 34 170 129 4 4 35 5 5 22 36 35 121 23 33 48 32 21 4 23 9 13 165 14 22 41 12 138 95 49 62 2 35 89 90 69 22 15 19 42 14 11 41 210 16 30 37 66 9 16 14 24 12 159 89 118 29 21 18 2 114 37 46 17 1 150 382 160 66 206 9 26 62 239 13 4 85 85 240 178 34 102 9 146 59 48 25 25 111 5 31 51 6 193 27 25 96 26 30 30 17 320 78 39 13 13 19 128 34 84 40 177 349 274 82 58 31 114 39 88 84 232 108 38 86 7 22 80 239 3 39 63 152 63 80 245 196 46 152 102 9 228 220 208 78 3 83 6 212 91 3 10 172 21 173 371 40 48 126 90 149 30 317 500 673 432 66 168 66 66 128 49 332];
end
y=cumsum(w);%w(i)��ֵ��w��i��֮ǰ�������ĺ�

%% ���庯������ֹ������
symbols{1} = {'log','sin','exp','cos','cot','tan','sqrt'};
symbols{2} = {'x'};

%% �����趨
popusize = 10000;%��Ⱥ����
maxtreedepth = 7;%������Ĳ�������������������ʽ��ʾ��
totle_gengeration = 50;%��Ⱥ�ܹ������Ĵ���
best=zeros(1,totle_gengeration);%�洢ÿ�����Ÿ������Ӧֵ
best_solution{totle_gengeration}={};%���ÿ�����Ÿ���ĺ������

%% ��ʼ����Ⱥ��������popu�����������Ⱥ��������Ϣ
popu = initpop(popusize,maxtreedepth,symbols);
%popu.generation = 1      ������Ⱥ��ʼ����
%popu.symbols = symbols;  ������Ⱥ���ż��ϣ�������ʾ��������ļ��ϡ�
%popu.size = popusize;    ������Ⱥ����
%popu.chrom;%���ڵ�������ı��룬�ܹ��������10000�����������Ⱥ
%     popu.chrom{i}.fitness;    ���嵱ǰ�������Ӧ��
%     popu.chrom{i}.mse = 0;      
%     popu.chrom{i}.tree = tree_genrnd(maxtreedepth,symbols); ������ɵ�������
%                   tree.maxsize = n;   %�������ʽ�������е����ڵ�����
%                   tree.nodetyp = vt;  %�ڵ�����
%                   tree.node = vn;     %�ڵ�     ͨ���ڵ����ͺͽڵ�����ֿ��Զ�λ��symbol��ѡ�����
%                   tree.param = zeros(floor((tree.maxsize+1)/2),1); %param�ǲ�������˼��ʾδ֪��x����������Ҷ������һ��
%                   tree.paramn = 0;

%% ����Ⱥ�еĸ�����ȡ����,����symbol�еĺ�������ֹ������ʾ����
unit{totle_gengeration,popusize}={};
obj=zeros(totle_gengeration,popusize);
for i = 1:popusize
  unit{1,i} = tree_stringrc(popu.chrom{i}.tree,1,popu.symbols);  %unit�б�����ʼ�����ɵ���Ⱥ����,��ͨ���ַ�������ʽ��������
  obj(1,i) = objvalue(unit{1,i},x,y);                            %����ÿһ�������Ӧֵ(�����ƽ���ʵֵ�ĳ̶�)                     
end

%% ��Ӧ������������һ�����������Ÿ��屣������

fitness = obj(1,:);
best(1) = fitness(1);
for j = 1:popusize
    if (fitness(j) ~= inf) && (fitness(j)>best(1)) %fitness(j)��inf�����ʱ���ʽ��fitness(j) ~= inf��Ϊ��
        best(1) = fitness(j);                      % best(1) �õ����ǵ�һ�����������ƽ���͵ĵ������ֵ�������Ÿ���
        best_solution{1} = unit{1,j};              % best_solution{1} ��һ����������С���ֵ�ĵ������ֵ��Ӧ�ĸ���
    end
end

% for j = 1:popusize
%     if (fitness(j) ~= 0) && (fitness(j)<best(1)) %fitness(j)��inf�����ʱ���ʽ��fitness(j) ~= inf��Ϊ��
%         best(1) = fitness(j);                      % best(1) �õ����ǵ�һ�����������ƽ���͵ĵ������ֵ�������Ÿ���
%         best_solution{1} = unit{1,j};              % best_solution{1} ��һ����������С���ֵ�ĵ������ֵ��Ӧ�ĸ���
%     end
% end

%% --------------------------- �ڶ�����ʼ -------------------------------------------
% opt = [0.8 0.9 0.05 2 1 0.2 30 0.05 0 1];
%gap = opt(1);
tsels = 2;       %��ѡ�����ʱ�����˲�������ѡ��ʽ��
                 %0�������̶�ѡ��2��������ѡ��(����ѡ��Ҫ���ȴӵ�ǰȺ�������ѡ���������裬�ٰ������ȶ���ĸ���pѡ����Ӧ�Ƚϸߵļ��裬���ո���1-pѡ����Ӧ�Ƚϵ͵ļ���)
pc = 0.9;        %�������,
                 %��koze��ʵ������������Ӧ�ȸ���ѡ��ǰȺ���10%���ı䱣������һ�����򽻲����=��1-pc��=0.9
pm = 0.05;       %������ 
rmode = 1;       %��������1--���㽻�� 2--˫�㽻��
hwait=waitbar(0,'��ȴ�>>>>>>>>');%���ý���
% while best>=1000,  % ��ֹ����
for ii = 2:totle_gengeration   %һ������50��
    wait_bar=ii/totle_gengeration;
    hwait=waitbar(wait_bar,hwait,'Ŀǰ����');%���ý���
    selm = selection(popu,fitness,pc,pm,tsels);      % ���ȸ�����Ӧֵѡ��ǰ���ﱣ��ǰ10%���������ݣ�֮���90%����������pc��pm����90%�Ľ�������5%�ı�������5%��������
    %selm��һ�����������У����������ִ����Ƿ��������棬���Ǳ��죻0-������1-���棨���Ӧ���е��������������ǽ�������ĸ�������2-����
   
    % New generation �¸���Ĳ���
    % newix = [];
    nn = 1;
    for i=1:size(selm,1)
%         if nn<=popusize
            m = selm(i,3);
            %   ����   *** Crossover ***
            if m==1
                p1 = selm(i,1);
                p2 = selm(i,2);
                % ���������
                tree1 = popu.chrom{p1}.tree;
                tree2 = popu.chrom{p2}.tree;
                [tree1,tree2] = crossover(tree1,tree2,rmode,popu.symbols); % ��������
                popu2.chrom{nn}.tree = tree1;
                if nn+1<=popu.size
                    popu2.chrom{nn+1}.tree = tree2;
                    nn = nn+1;
                end
                if nn<popu.size       
                    nn = nn+1;
                end
            % *** Mutation �������***
            elseif m==2
                p1 = selm(i,1);
                tree1 = popu.chrom{p1}.tree;
                tree1 = mutation(tree1,popu.symbols);
                popu2.chrom{nn}.tree = tree1;  
                nn = nn+1;
                % *** ��������н���ͱ�����ô��ֱ�Ӵ洢���� *** 
            else
                p1 = selm(i,1);
                if p1==0,
                    popu2.chrom{nn}.tree = popu.chrom{1}.tree;
                    return;
                else
                    popu2.chrom{nn}.tree = popu.chrom{p1}.tree;       
                    nn = nn+1;
                end
            end
     end
    
    %���µ�ǰ��������Ⱥ
    popu.chrom=popu2.chrom;
    popu.generation = popu.generation+1;
    
    %�����¸���Ⱥ����Ӧֵ����ѡ�����ǰ��Ⱥ�����Ÿ���
    for i = 1:popusize
      unit{popu.generation,i} = tree_stringrc(popu.chrom{i}.tree,1,popu.symbols);  %unit�б�����ʼ�����ɵ���Ⱥ����,��ͨ���ַ�������ʽ��������
      obj(popu.generation,i) = objvalue(unit{popu.generation,i},x,y);                              %����ÿһ�������Ӧֵ(�����ƽ���ʵֵ�ĳ̶�)                      % 
    end
    fitness = obj(popu.generation,:);
    best(ii) = fitness(1); 
    for jj = 1:popusize,
        if (fitness(jj) ~= inf) && (fitness(jj)>best(ii))      %fitness(j)��inf�����ʱ���ʽ��fitness(j) ~= inf��Ϊ��
            best(ii) = fitness(jj);                            % best(ii) �õ����ǵ�һ�����������ƽ���͵ĵ������ֵ�������Ÿ���
            best_solution{ii} = unit{popu.generation,jj};      % best_solution{ii} ��һ����������С���ֵ�ĵ������ֵ��Ӧ�ĸ���
        end
    end
    
end

% ����ó����յ����Ÿ���ֵ
fit_result = best(1);
for n = 1:length(best),
    if (best(n)~= inf) && (best(n)>fit_result),
        fit_result = best(n);
        best_population = best_solution{n};
    end
end

%% ��ͼ���Ƚ�ʹ��GP�㷨��ú������ߺ���ԭʼ���ݻ��������ߵĲ��
g = eval(best_population);
plot(x,g,'LineWidth',1,'Color','r','LineStyle','-');
hold on;
plot(x,y,'LineWidth',1,'Color','b','LineStyle',':');
hold off
% plot(x,g,'-r',x,y,':b');
legend('GP�ݻ�ģ�ͽṹ','ʵ����������',2);
title('�Ŵ���̲���','FontName','����_GB2312' ,'FontSize',16);
xlabel('��������','FontName','����_GB2312' ,'FontSize',12);
ylabel('�������','FontName','����_GB2312' ,'FontSize',12);
z1=['y=',best_population];
fit=int2str(fit_result);
% z2=['�����Ӧ��Ϊ��',fit];
text(round(length(x)/2),round(g(round(length(x)/2))),z1,'FontName','����_GB2312','FontSize',12);
% text(round(length(x)/2),round(max(y)/2),z2,'FontName','����_GB2312','FontSize',16)
grid on

return



