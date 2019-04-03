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
y=cumsum(w);%w(i)的值是w（i）之前所有数的和

%% 定义函数、终止符集合
symbols{1} = {'log','sin','exp','cos','cot','tan','sqrt'};
symbols{2} = {'x'};

%% 参数设定
popusize = 10000;%种群数量
maxtreedepth = 7;%最大树的层数，函数是以树的形式表示的
totle_gengeration = 50;%种群总共历尽的代数
best=zeros(1,totle_gengeration);%存储每代最优个体的适应值
best_solution{totle_gengeration}={};%获得每代最优个体的函数表达

%% 初始化种群，整棵树popu代表了这个种群的所有信息
popu = initpop(popusize,maxtreedepth,symbols);
%popu.generation = 1      定义种群初始代数
%popu.symbols = symbols;  定义种群符号集合，用来表示单个个体的集合。
%popu.size = popusize;    定义种群数量
%popu.chrom;%对于单个个体的编码，总共随机生成10000个个体组成种群
%     popu.chrom{i}.fitness;    定义当前个体的适应度
%     popu.chrom{i}.mse = 0;      
%     popu.chrom{i}.tree = tree_genrnd(maxtreedepth,symbols); 随机生成单个个体
%                   tree.maxsize = n;   %函数表达式树所具有的最大节点数量
%                   tree.nodetyp = vt;  %节点类型
%                   tree.node = vn;     %节点     通过节点类型和节点的数字可以定位到symbol中选择符号
%                   tree.param = zeros(floor((tree.maxsize+1)/2),1); %param是参数的意思表示未知数x，其数量与叶子数量一致
%                   tree.paramn = 0;

%% 将种群中的个体提取出来,并用symbol中的函数、终止符集表示出来
unit{totle_gengeration,popusize}={};
obj=zeros(totle_gengeration,popusize);
for i = 1:popusize
  unit{1,i} = tree_stringrc(popu.chrom{i}.tree,1,popu.symbols);  %unit中保留初始化生成的种群个体,并通过字符串的形式储存起来
  obj(1,i) = objvalue(unit{1,i},x,y);                            %计算每一个体的适应值(函数逼近真实值的程度)                     
end

%% 适应度评估，将第一代个体中最优个体保存下来

fitness = obj(1,:);
best(1) = fitness(1);
for j = 1:popusize
    if (fitness(j) ~= inf) && (fitness(j)>best(1)) %fitness(j)与inf不相等时表达式（fitness(j) ~= inf）为真
        best(1) = fitness(j);                      % best(1) 得到的是第一代个体中误差平方和的倒数最大值，即最优个体
        best_solution{1} = unit{1,j};              % best_solution{1} 第一代个体中最小误差值的倒数最大值对应的个体
    end
end

% for j = 1:popusize
%     if (fitness(j) ~= 0) && (fitness(j)<best(1)) %fitness(j)与inf不相等时表达式（fitness(j) ~= inf）为真
%         best(1) = fitness(j);                      % best(1) 得到的是第一代个体中误差平方和的倒数最大值，即最优个体
%         best_solution{1} = unit{1,j};              % best_solution{1} 第一代个体中最小误差值的倒数最大值对应的个体
%     end
% end

%% --------------------------- 第二代开始 -------------------------------------------
% opt = [0.8 0.9 0.05 2 1 0.2 30 0.05 0 1];
%gap = opt(1);
tsels = 2;       %在选择操作时决定了采用哪种选择方式，
                 %0——轮盘赌选择，2——竞赛选择(竞赛选择要事先从当前群体中随机选择两个假设，再按照事先定义的概率p选择适应度较高的假设，按照概率1-p选择适应度较低的假设)
pc = 0.9;        %交叉概率,
                 %在koze的实验中他根据适应度概率选择当前群体的10%不改变保留到下一代，则交叉概率=（1-pc）=0.9
pm = 0.05;       %变异率 
rmode = 1;       %交叉类型1--单点交叉 2--双点交叉
hwait=waitbar(0,'请等待>>>>>>>>');%设置进度
% while best>=1000,  % 终止条件
for ii = 2:totle_gengeration   %一共计算50代
    wait_bar=ii/totle_gengeration;
    hwait=waitbar(wait_bar,hwait,'目前进度');%设置进度
    selm = selection(popu,fitness,pc,pm,tsels);      % 首先根据适应值选择前这里保留前10%的最优数据，之后的90%的数据利用pc，pm产生90%的交叉后代，5%的变异后代，5%保留父本
    %selm是一个矩阵，有三列，第三列数字代表是否保留，交叉，还是变异；0-保留，1-交叉（其对应的行的其他两个数据是交叉操作的父本），2-变异
   
    % New generation 新个体的产生
    % newix = [];
    nn = 1;
    for i=1:size(selm,1)
%         if nn<=popusize
            m = selm(i,3);
            %   交叉   *** Crossover ***
            if m==1
                p1 = selm(i,1);
                p2 = selm(i,2);
                % 重组二叉树
                tree1 = popu.chrom{p1}.tree;
                tree2 = popu.chrom{p2}.tree;
                [tree1,tree2] = crossover(tree1,tree2,rmode,popu.symbols); % 交叉运算
                popu2.chrom{nn}.tree = tree1;
                if nn+1<=popu.size
                    popu2.chrom{nn+1}.tree = tree2;
                    nn = nn+1;
                end
                if nn<popu.size       
                    nn = nn+1;
                end
            % *** Mutation 变异操作***
            elseif m==2
                p1 = selm(i,1);
                tree1 = popu.chrom{p1}.tree;
                tree1 = mutation(tree1,popu.symbols);
                popu2.chrom{nn}.tree = tree1;  
                nn = nn+1;
                % *** 如果不进行交叉和变异那么就直接存储保留 *** 
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
    
    %更新当前代数的种群
    popu.chrom=popu2.chrom;
    popu.generation = popu.generation+1;
    
    %计算下个种群的适应值，并选择出当前种群中最优个体
    for i = 1:popusize
      unit{popu.generation,i} = tree_stringrc(popu.chrom{i}.tree,1,popu.symbols);  %unit中保留初始化生成的种群个体,并通过字符串的形式储存起来
      obj(popu.generation,i) = objvalue(unit{popu.generation,i},x,y);                              %计算每一个体的适应值(函数逼近真实值的程度)                      % 
    end
    fitness = obj(popu.generation,:);
    best(ii) = fitness(1); 
    for jj = 1:popusize,
        if (fitness(jj) ~= inf) && (fitness(jj)>best(ii))      %fitness(j)与inf不相等时表达式（fitness(j) ~= inf）为真
            best(ii) = fitness(jj);                            % best(ii) 得到的是第一代个体中误差平方和的倒数最大值，即最优个体
            best_solution{ii} = unit{popu.generation,jj};      % best_solution{ii} 第一代个体中最小误差值的倒数最大值对应的个体
        end
    end
    
end

% 计算得出最终的最优个体值
fit_result = best(1);
for n = 1:length(best),
    if (best(n)~= inf) && (best(n)>fit_result),
        fit_result = best(n);
        best_population = best_solution{n};
    end
end

%% 画图，比较使用GP算法获得函数曲线和用原始数据画出的曲线的差别
g = eval(best_population);
plot(x,g,'LineWidth',1,'Color','r','LineStyle','-');
hold on;
plot(x,y,'LineWidth',1,'Color','b','LineStyle',':');
hold off
% plot(x,g,'-r',x,y,':b');
legend('GP演化模型结构','实际数据序列',2);
title('遗传编程测试','FontName','楷体_GB2312' ,'FontSize',16);
xlabel('输入序列','FontName','楷体_GB2312' ,'FontSize',12);
ylabel('输出序列','FontName','楷体_GB2312' ,'FontSize',12);
z1=['y=',best_population];
fit=int2str(fit_result);
% z2=['最佳适应度为：',fit];
text(round(length(x)/2),round(g(round(length(x)/2))),z1,'FontName','楷体_GB2312','FontSize',12);
% text(round(length(x)/2),round(max(y)/2),z2,'FontName','楷体_GB2312','FontSize',16)
grid on

return



