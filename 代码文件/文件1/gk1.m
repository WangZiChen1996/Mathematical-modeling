%%
%% �������
clc
close all
clear all
%% ��ȡ����
data=xlsread('data1.4.xlsx'); %��������
IDX=xlsread('IDX1.xlsx'); %��������
A=xlsread('sport1.xlsx'); %��������

%% Ƭ�η���
K1=A((find(IDX==1)),:);
K2=A((find(IDX==2)),:);

%% Ƭ�ξ�����Ϣ

c=170;

pi=data(A(c,1)-A(c,2):A(c,1),:);
plot(pi(:,1),pi(:,2));  %��ʾ���������ٶȱ仯����
xlabel('ʱ�䣨s��');







