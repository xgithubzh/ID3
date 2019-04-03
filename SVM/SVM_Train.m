function svm = SVM_Train(X,Y,kertype,C)
options = optimset;         % Options是用来控制算法的选项参数的向量，寻优函数搜索方式的设定
options.LargeScale = 'off'; %LargeScale指大规模搜索，off表示大规模搜索模式关闭
options.Display = 'off';    %这样设置意味着没有输出

n = length(Y);%数组Y的长度 
H = (Y'*Y).*Kernel(X,X,kertype);%调用kernel函数，核函数，svm三大法宝，支持向量，核函数，松弛因子
%H=(Y'*Y).*(X'*X);

f = -ones(n,1);  %f为1*n个-1,f相当于Quadprog函数中的c
A = [];
b = [];
Aeq = Y;         %相当于Quadprog函数中的A1,b1
beq = 0;
lb = zeros(n,1); %相当于Quadprog函数中的LB，UB
ub = C*ones(n,1);
a0 = zeros(n,1);  % a0是解的初始近似值

[a,fval,eXitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
%求解二次规划的函数，a是x是最优解，fval是目标函数在X时候的值，即目标函数最优值。
%exitflag，为终止跌迭代的条件，exitflag>0表示函数收敛于解x；exitflag=0表示超过函数估计值或迭代最大次数；exitflag<0表示函数不收敛于解x。
%output为输出信息，若参数output=iterations表示迭代次数，output=funccount表示函数赋值次数，output=algorithm表示所使用的算法。
%lambda是Lagrange乘子，它体现哪一个约束有效。

epsilon = 1e-8;                      
sv_label = find(abs(a)>epsilon);  %0<a<a(max)则认为x为支持向量     
svm.a = a(sv_label);
svm.Xsv = X(:,sv_label);
svm.Ysv = Y(sv_label);
svm.svnum = length(sv_label);
%svm.label = sv_label;