%%
%% �������
clc
close all
clear all
%% ��ȡ����
data=xlsread('data3.4.xlsx'); %��������
IDX=xlsread('IDX3.xlsx'); %��������
A=xlsread('sport3.xlsx'); %��������

%% Ƭ�η���
K1=A((find(IDX==1)),:);
K2=A((find(IDX==2)),:);


%% Ƭ�ξ�����Ϣ
c=57;

pi=data(A(c,1)-A(c,2):A(c,1),:);
plot(pi(:,1),pi(:,2));  %��ʾ���������ٶȱ仯����
xlabel('ʱ�䣨s��');

