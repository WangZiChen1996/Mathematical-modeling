%% 清除环境
clc
close all
clear all
%% 读取数据
data=xlsread('data3.4.xlsx'); %导入数据
% IDX=xlsread('IDX1.xlsx'); %导入数据
%% 获取片段
v = data(:,2);  %单位（km/h）
time=data(:,1); %单位（s）
a=[0];          %单位（m/s2）
[m,n]=size(data);
for i=1:m-1
    a = [a;(v(i+1)-v(i))/3.6];
    
end

b=0;
B=[];
for i=2:m
    if v(i)==0 & v(i-1)~=0
        if b>20
            B=[B;i b];
            b=0;
        else
            b=0;
        end
    else
        b=b+1;
        
    end
end

[mb,nb]=size(B);
% B=sortrows(B,2,'descend');

%% 计算参数值
%%% 结果存储在A矩阵中
%A第2列，T：片段持续时间：数据文件中夫人总点数
%A第3列，平均速度V_a平均速度：V_a=S/T平均速度
%A第4列，行驶路程S=∑?〖v(i)〗
%A第5列, T_a: j加速度大于0.15m/s2的总点数
%A第6列,T_d：加速度小于-0.15/s2的总点数
%A第7列,T_i：怠速时间比例：速度为0且发动机速度不为0的总点数
%A第8列,速度标准差
%A第9列,加速度标准差
%A第10列,加速度最大值
%A第11列,加速度最小值
%A第12列,平均减速度
%A第13列,平均加速度
%A第14列,速度最大值
%A第15列,平均行驶速度
%A第16列,巡航时间
%%%

A=B;

for i=1:mb
    pi=data(A(i,1)-A(i,2):A(i,1),:);
    piv=v(A(i,1)-A(i,2):A(i,1),:);
    pia=a(A(i,1)-A(i,2):A(i,1),:);
    
    A(i,3)=mean(piv);
    A(i,4)=sum(piv);
    A(i,5)=length(find(pia>0.15))/A(i,2);
    A(i,6)=length(find(pia<-0.15))/A(i,2);
    A(i,7)=length(find(piv==0))/A(i,2);
    A(i,8)=std(piv(find(piv)));
    A(i,9)=std(pia(find(pia)));
    A(i,10)=max(pia(find(pia)));
    A(i,11)=min(pia(find(pia)));
    A(i,12)=mean(pia(find(pia<0)));
    A(i,13)=mean(pia(find(pia>0)));
    A(i,14)=max(piv);
    A(i,15)=mean(A(i,4)/(A(i,2)-A(i,7)*A(i,2)));
    A(i,16)=mean(A(i,2)-A(i,5)*A(i,2)-A(i,6)*A(i,2)-A(i,7)*A(i,2))/A(i,2);
  
end

%% 运动学片段筛选
% (1)除去小于20s的运动学片段
%  运动学片段提取过程中已完成

% (2)删除平均行驶速度大于280km/h，删除平均速度小于1km/h
A1=A(find(A(:,15)<280),:);
A2=A1(find(A1(:,3) > 1),:);

% (3)加速度异常
A3=A2(find(A2(:,10)<4),:);
A4=A3(find(A3(:,11)>-8),:);

A=A4;


%% 数据标准化

[ma,na]=size(A);  %ma=1328,na=15
X = zscore(A(:,2:end));

%%
xlswrite('sport3.xlsx',A);
xlswrite('X3.xlsx',X);
