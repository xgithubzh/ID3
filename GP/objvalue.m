function objvalue = objvalue(Cell,X,Y)
%% ����ÿһ�������Ӧֵ(�����ƽ���ʵֵ�ĳ̶�)
% xΪ�������еĺ���
% Cell����Ⱥ�е�������ı��ʽ��Ҳ����˵����˹Ԥ�⺯�������ַ�������ʽ�洢��
% yΪ��˹��������ʵֵ
% QΪ��������õ���ģ��Ԥ��ֵ
x=X; %���Ǳ�Ҫ��
y=Y;
Q = eval(Cell);%���ַ���ת����matlab��ִ�е���䣬ע���ʱ����Ͱ�����δ֪��x.

% ������С���˼������ƽ������Сȷ������ģ�ͽṹ��
Error = sum((Q-y).^2);
objvalue = 1/Error;      %�����ֵ�����ÿ���������Ӧֵ

% ���Ŀ��ֵ��������|�����������|����������ʵ�����Ǵ����鲿�ĸ���||������С��0ʱ
if (isnan(objvalue))||(~isreal(objvalue)||(objvalue<0))
%  if (isnan(objvalue))||(isinf(objvalue))||(~isreal(objvalue)||(objvalue<0))
%     disp('�����ɵĺ���������Ч�������ʽ��');
    objvalue = 0;
%     objvalue=inf;
end

%  objvalue = Error;      %�����ֵ�����ÿ���������Ӧֵ
%  if (isnan(objvalue))||(isinf(objvalue))||(~isreal(objvalue)||(objvalue<0))
%     objvalue=inf;
%  end

% disp(objvalue);
% disp('.............................................................');

return
