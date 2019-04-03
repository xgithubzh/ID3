function svm = SVM_Train(X,Y,kertype,C)
options = optimset;         % Options�����������㷨��ѡ�������������Ѱ�ź���������ʽ���趨
options.LargeScale = 'off'; %LargeScaleָ���ģ������off��ʾ���ģ����ģʽ�ر�
options.Display = 'off';    %����������ζ��û�����

n = length(Y);%����Y�ĳ��� 
H = (Y'*Y).*Kernel(X,X,kertype);%����kernel�������˺�����svm���󷨱���֧���������˺������ɳ�����
%H=(Y'*Y).*(X'*X);

f = -ones(n,1);  %fΪ1*n��-1,f�൱��Quadprog�����е�c
A = [];
b = [];
Aeq = Y;         %�൱��Quadprog�����е�A1,b1
beq = 0;
lb = zeros(n,1); %�൱��Quadprog�����е�LB��UB
ub = C*ones(n,1);
a0 = zeros(n,1);  % a0�ǽ�ĳ�ʼ����ֵ

[a,fval,eXitflag,output,lambda]  = quadprog(H,f,A,b,Aeq,beq,lb,ub,a0,options);
%�����ι滮�ĺ�����a��x�����Ž⣬fval��Ŀ�꺯����Xʱ���ֵ����Ŀ�꺯������ֵ��
%exitflag��Ϊ��ֹ��������������exitflag>0��ʾ���������ڽ�x��exitflag=0��ʾ������������ֵ�������������exitflag<0��ʾ�����������ڽ�x��
%outputΪ�����Ϣ��������output=iterations��ʾ����������output=funccount��ʾ������ֵ������output=algorithm��ʾ��ʹ�õ��㷨��
%lambda��Lagrange���ӣ���������һ��Լ����Ч��

epsilon = 1e-8;                      
sv_label = find(abs(a)>epsilon);  %0<a<a(max)����ΪxΪ֧������     
svm.a = a(sv_label);
svm.Xsv = X(:,sv_label);
svm.Ysv = Y(sv_label);
svm.svnum = length(sv_label);
%svm.label = sv_label;