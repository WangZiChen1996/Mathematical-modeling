%%
%% �������
clc
close all
clear all
%% ��ȡ����
data=xlsread('data2.4.xlsx'); %��������
IDX=xlsread('IDX2.xlsx'); %��������
A=xlsread('sport2.xlsx'); %��������

%% Ƭ�η���
K1=A((find(IDX==1)),:);
K2=A((find(IDX==2)),:);


%% Ƭ�ξ�����Ϣ
c=67;

pi=data(A(c,1)-A(c,2):A(c,1),:);
plot(pi(:,1),pi(:,2));  %��ʾ���������ٶȱ仯����
xlabel('ʱ�䣨s��');


