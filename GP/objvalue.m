function objvalue = objvalue(Cell,X,Y)
%% 计算每一个体的适应值(函数逼近真实值的程度)
% x为数据序列的号码
% Cell是种群中单个个体的表达式（也可以说是瓦斯预测函数，以字符串的形式存储）
% y为瓦斯含量的真实值
% Q为函数计算得到的模型预测值
x=X; %这是必要的
y=Y;
Q = eval(Cell);%将字符串转换成matlab可执行的语句，注意此时里面就包含了未知数x.

% 采用最小二乘计算误差平方和最小确定较优模型结构，
Error = sum((Q-y).^2);
objvalue = 1/Error;      %将误差值代表成每个个体的适应值

% 如果目标值不是数字|或者是无穷大|或者它不是实数而是带有虚部的复数||或者它小于0时
if (isnan(objvalue))||(~isreal(objvalue)||(objvalue<0))
%  if (isnan(objvalue))||(isinf(objvalue))||(~isreal(objvalue)||(objvalue<0))
%     disp('所生成的函数不是有效函数表达式！');
    objvalue = 0;
%     objvalue=inf;
end

%  objvalue = Error;      %将误差值代表成每个个体的适应值
%  if (isnan(objvalue))||(isinf(objvalue))||(~isreal(objvalue)||(objvalue<0))
%     objvalue=inf;
%  end

% disp(objvalue);
% disp('.............................................................');

return
