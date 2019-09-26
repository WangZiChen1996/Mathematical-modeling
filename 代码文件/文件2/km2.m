%% ʹ��K-Means�㷨����������Ϊ��������
%% 201909

clc
close all
clear all

% ������ʼ��
inputfile = 'dimention_reducted.xls'; % ������������������
k = 2; % ��������
iteration =50 ; % �������ѭ������
distance = 'sqEuclidean'; % ���뺯��

%% ��ȡ����
[num,txt]=xlsread(inputfile);
data = num(:,2:end);
A=xlsread('sport2.xlsx')

%% ���ݱ�׼��
% data = zscore(data);
% z-score ��׼��(��̫��׼��)�ǻ���ԭʼ���ݵľ�ֵ��mean���ͱ�׼�standard deviation��
% �������ݵı�׼������A��ԭʼֵxʹ��z-score��׼����x����

%% ����kmeans�㷨
opts = statset('MaxIter',iteration);
[IDX,C,~,D] = kmeans(data,k,'distance',distance,'Options',opts);

%% ��ӡ���
for i=1:k
   disp(['��' num2str(i) '���������Ϊ��']);
   disp(C(i,:));
end

disp('K-Means�����㷨��ɣ�');
[s,h] = silhouette(data,IDX,'sqeuclid'); grid on;


xlswrite('IDX2.xlsx',IDX);
