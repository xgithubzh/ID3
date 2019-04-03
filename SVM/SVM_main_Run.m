%主函数
clear all;
clc;
%%
C = 10;
kertype = 'linear';  %svm 线性训练
n = 50;
%%  产生两类随机数据点，符合0-1正态分布
randn('state',0);   %可以保证每次重新运行主程序时产生的随机数一样
x1 = randn(2,n);    %2行N列矩阵
y1 = ones(1,n);     %1*N个 1
x2 = 5+randn(2,n);  %2*N矩阵
y2 = -ones(1,n);    %1*N个 -1
%%  将数据点画出来
figure;
plot(x1(1,:),x1(2,:),'bx',x2(1,:),x2(2,:),'k.'); 
axis([-3 8 -3 8]);
xlabel('x轴');
ylabel('y轴');
hold on;

%% 训练样本集
X = [x1,x2];        %训练样本d*n矩阵，n为样本个数，d为特征向量个数，在这里，X为一个2*100的数组
Y = [y1,y2];        %训练目标1*n矩阵，n为样本个数，值为+1或-1，在这里，Y为一个1*100的数组
svm = SVM_Train(X,Y,kertype,C);
plot(svm.Xsv(1,:),svm.Xsv(2,:),'ro');

%% 测试
[x1,x2] = meshgrid(-2:0.05:7,-2:0.05:7);  %x1和x2都是181*181的矩阵
[rows,cols] = size(x1);  
nt = rows*cols;                  
Xt = [reshape(x1,1,nt);reshape(x2,1,nt)];
Yt = ones(1,nt);
result = SVM_Test(svm, Xt, Yt, kertype);

Yd = reshape(result.Y,rows,cols);
contour(x1,x2,Yd,'m');