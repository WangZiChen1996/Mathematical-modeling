clc
clear all
close all

%% ���ɷַ��� ��ά

% ������ʼ��
inputfile = 'X3.xlsx';
outputfile = 'dimention_reducted.xls';   % ��ά�������
proportion = 0.8 ; % ���ɷֵı���

%% ���ݶ�ȡ
[num,~] = xlsread(inputfile);

%% ���ɷַ���
% ���ɷ�������������������Ӧ���������Ӵ�С���У������Ԫ�ز���Ӧ��
% ��Ԫ�����һ������������ˣ��õ��µĵ�һ������Ҫ�ĳɷ֣�
% �ɴ�8��ԭ���ı���pca��8���µı�������Ҫ�ԴӴ�С���У�
% 8��ԭ���ı�������ϵ����ɷ���Ҫ�ԴӴ�С���У�
% ����ԭ���ݵ������ɷ֣���ÿ�����������е�������Ӧ��ֵ����λ�ã���Ӱ���µĳɷ֣�
% ��������,������
[coeff,~,latent] = pca(num);   %���ɷֵ�λ��������,���ɷ�������

%% �����ۼƹ����ʣ�ȷ��ά��
sum_latent = cumsum(latent/sum(latent));    % �ۼƹ�����
dimension = find(sum_latent>proportion);
dimension= dimension(1);

%% ��ά
%��ô����ģ�num[14*8]*coeff[8*3]=data[14*3]
data = num * coeff(:,1:dimension); 
xlswrite(outputfile,data);
disp('���ɷ���������');
disp(latent');
disp('���ɷֵ�λ��������');
disp(coeff);
disp('�ۼƹ�����');
disp(sum_latent');
disp(['���ɷַ�����ɣ���ά���������' outputfile]);