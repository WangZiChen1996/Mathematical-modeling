%%
%% 清除环境
clc
close all
clear all
%% 读取数据
data=xlsread('data3.4.xlsx'); %导入数据
IDX=xlsread('IDX3.xlsx'); %导入数据
A=xlsread('sport3.xlsx'); %导入数据

%% 片段分类
K1=A((find(IDX==1)),:);
K2=A((find(IDX==2)),:);


%% 片段具体信息
c=57;

pi=data(A(c,1)-A(c,2):A(c,1),:);
plot(pi(:,1),pi(:,2));  %显示部分数据速度变化曲线
xlabel('时间（s）');

