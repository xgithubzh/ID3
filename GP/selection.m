function selm = selection(popu,fitness,pc,pm,tsels)
% 选择操作
popun = popu.size;        %群体大小10000
selm = zeros(popun,3);    % 产生popun*3的 全 0 矩阵  

% Fitness values and sort
% % fit = zeros(1,popun);     % fit 返回的是 1*3 列的矩阵
% for i = 1:popun,          % popun 的值是种群个体的大小值（3）
%     fit(i) = popu.chrom{i}.fitness;
% end                       % fit最后返回一个 1行3列 的向量存储一代种群中的各个体的适应度

fit = fitness;  %当前群体的适应值（注意我们之前用平方误差定义适应度的，值越小适应度应该越好）

if ~isempty(find(fit<0, 1))         %如果不能找到适应值是大于等于0的话,find(fit<0, 1)采用这种形式是因为只要找到一个fit<0 点的位置就可以判断了
  error('Every fitness must be >= 0');
end

[fitsort,sortix] = sort(fit);      % 排序 按照 -fit 值的大小升序排列 fitsort 就是排好的序列，sortix 是序列的索引
fitsort = fitsort./sum(fitsort);   % 返回适应值的概，从大到小排列的比率值（正数）
fitsum = cumsum(fitsort);          % 累积求和，累积的最后结果是 1


i = floor((1-pc)*popun)+1;          % floor是向下取整函数

if i>=1 && i<=popun,               
  selm(1:i,1) = sortix(1:i)';      % 后面的一撇表示矩阵的转置，这里保留前10%的最优数据  
  i = i+1;
else
  i = 1;
end
nn = i-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Create the New individuals  %%%%%%%%%%%%%%%%%%%%%%%%%%
while nn<popun                       % 因为在此 tsels = 2 竞赛选择
  if tsels == 2                     
    j1 = tournament(fit,tsels);      % 当tsels==2 的时候使用竞赛选择算法
  else                               
    j1 = roulette(fitsum,sortix);    % tsels==0的时候为轮盘选择算法
  end
  %%%%%%%%%%%%%%%%%%%%%%%%      选择遗传算子     %%%%%%%%%%%%%%%%%%%%%%%
  r = rand;
  if r<pc                           % 当r小于交叉概率的时候 
    % Crossover 交叉算子
    if tsels == 2
      j2 = tournament(fit,tsels);    % tsels==2的时候使用竞赛选择算法
    else
      j2 = roulette(fitsum,sortix);  % tsels==0的时候为轮盘选择算法
    end
    selm(i,1) = j1;
    selm(i,2) = j2;        %利用交叉算子时需要分别利用概率产生两个父本
    selm(i,3) = 1;         %1表示使用了交叉算子
    i = i+1;
    nn = nn+2;             %交叉利用了两个双亲但是也会产生两个后代
  elseif r<pc+pm,
    % Mutation 变异算子
    selm(i,1) = j1;
    selm(i,3) = 2;        %2表示要使用变异算子
    i = i+1;
    nn = nn+1;
  else
    % 如果随机生成数不满足交叉、变异概率条件则直接把以前的个体保留下来
    selm(i,1) = j1;
    selm(i,3) = 0;        %0表示保留个体
    i = i+1;
    nn = nn+1;
  end
end
selm = selm(1:i-1,:);
return

%--------------------------------------------------------------
function j = tournament(fit,tsels)        %比赛排序（竞赛选择）
    n = length(fit);
    jj = floor(rand(tsels,1)*n)+1;%随机生成两个假设的位置
    [~,minix] = min(fit(jj));    %通过两个假设的位置读取两个假设的适应值，比较获得较好个体的那个位置的信息
    j = jj(minix);               %保留比赛排序最优个体的位置信息
return
%--------------------------------------------------------------
function j = roulette(fitsum,sortix)      %轮盘选择算法
    v = find(fitsum >= rand(1,1));
    j = sortix(v(1));
return