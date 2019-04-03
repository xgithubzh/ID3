function selm = selection(popu,fitness,pc,pm,tsels)
% ѡ�����
popun = popu.size;        %Ⱥ���С10000
selm = zeros(popun,3);    % ����popun*3�� ȫ 0 ����  

% Fitness values and sort
% % fit = zeros(1,popun);     % fit ���ص��� 1*3 �еľ���
% for i = 1:popun,          % popun ��ֵ����Ⱥ����Ĵ�Сֵ��3��
%     fit(i) = popu.chrom{i}.fitness;
% end                       % fit��󷵻�һ�� 1��3�� �������洢һ����Ⱥ�еĸ��������Ӧ��

fit = fitness;  %��ǰȺ�����Ӧֵ��ע������֮ǰ��ƽ��������Ӧ�ȵģ�ֵԽС��Ӧ��Ӧ��Խ�ã�

if ~isempty(find(fit<0, 1))         %��������ҵ���Ӧֵ�Ǵ��ڵ���0�Ļ�,find(fit<0, 1)����������ʽ����ΪֻҪ�ҵ�һ��fit<0 ���λ�þͿ����ж���
  error('Every fitness must be >= 0');
end

[fitsort,sortix] = sort(fit);      % ���� ���� -fit ֵ�Ĵ�С�������� fitsort �����źõ����У�sortix �����е�����
fitsort = fitsort./sum(fitsort);   % ������Ӧֵ�ĸţ��Ӵ�С���еı���ֵ��������
fitsum = cumsum(fitsort);          % �ۻ���ͣ��ۻ���������� 1


i = floor((1-pc)*popun)+1;          % floor������ȡ������

if i>=1 && i<=popun,               
  selm(1:i,1) = sortix(1:i)';      % �����һƲ��ʾ�����ת�ã����ﱣ��ǰ10%����������  
  i = i+1;
else
  i = 1;
end
nn = i-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Create the New individuals  %%%%%%%%%%%%%%%%%%%%%%%%%%
while nn<popun                       % ��Ϊ�ڴ� tsels = 2 ����ѡ��
  if tsels == 2                     
    j1 = tournament(fit,tsels);      % ��tsels==2 ��ʱ��ʹ�þ���ѡ���㷨
  else                               
    j1 = roulette(fitsum,sortix);    % tsels==0��ʱ��Ϊ����ѡ���㷨
  end
  %%%%%%%%%%%%%%%%%%%%%%%%      ѡ���Ŵ�����     %%%%%%%%%%%%%%%%%%%%%%%
  r = rand;
  if r<pc                           % ��rС�ڽ�����ʵ�ʱ�� 
    % Crossover ��������
    if tsels == 2
      j2 = tournament(fit,tsels);    % tsels==2��ʱ��ʹ�þ���ѡ���㷨
    else
      j2 = roulette(fitsum,sortix);  % tsels==0��ʱ��Ϊ����ѡ���㷨
    end
    selm(i,1) = j1;
    selm(i,2) = j2;        %���ý�������ʱ��Ҫ�ֱ����ø��ʲ�����������
    selm(i,3) = 1;         %1��ʾʹ���˽�������
    i = i+1;
    nn = nn+2;             %��������������˫�׵���Ҳ������������
  elseif r<pc+pm,
    % Mutation ��������
    selm(i,1) = j1;
    selm(i,3) = 2;        %2��ʾҪʹ�ñ�������
    i = i+1;
    nn = nn+1;
  else
    % �����������������㽻�桢�������������ֱ�Ӱ���ǰ�ĸ��屣������
    selm(i,1) = j1;
    selm(i,3) = 0;        %0��ʾ��������
    i = i+1;
    nn = nn+1;
  end
end
selm = selm(1:i-1,:);
return

%--------------------------------------------------------------
function j = tournament(fit,tsels)        %�������򣨾���ѡ��
    n = length(fit);
    jj = floor(rand(tsels,1)*n)+1;%����������������λ��
    [~,minix] = min(fit(jj));    %ͨ�����������λ�ö�ȡ�����������Ӧֵ���Ƚϻ�ýϺø�����Ǹ�λ�õ���Ϣ
    j = jj(minix);               %���������������Ÿ����λ����Ϣ
return
%--------------------------------------------------------------
function j = roulette(fitsum,sortix)      %����ѡ���㷨
    v = find(fitsum >= rand(1,1));
    j = sortix(v(1));
return