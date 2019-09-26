%% 清除环境
clc
close all
clear all
%% 读取数据
deltatime=xlsread('文件1时间.xlsx');%导入文件1时间数据（秒）
[num,txt]=xlsread('文件1.xlsx');  % 导入文件1数据

data = [deltatime num];      %合并数据集
[m,n]=size(data);           %m=185725,n=14
data=[data(:,1) data(:,2) data(:,6)];   %挑选有用数据列
[m,n]=size(data); 
%% (1)GPS信号丢失
data1=data(find(data(:,3)>0),:);
%处理后m=185722,n=3
%% (2)速度、加速度异常
data2=data1;
[m2,n2]=size(data2);
v = data2(:,2);  %单位（km/h）

% v（km/h） 速度筛选
B2=data2(find(data2(:,2)<280),:);
data2=B2;
% a (m/s2)  加速度筛选
[m2,n2]=size(data2);
time=data2(:,1); %单位（s）
a=[0];          %单位（m/s2）
for i=1:m2-1
    a = [a;(v(i+1)-v(i))/3.6];
    
end

a1=a(find(a>-8&a<4),:);
A2=data2(find(a>-8&a<4),:);
data2=A2;

plot(A2(:,1),a1);  %显示部分数据速度变化曲线
xlabel('时间（s）');
ylabel('加速度(m/s2)');
%% (3)长期停车异常（按个数）
data3=data2;
[m3,n3]=size(data3);
v = data3(:,2);  %单位（km/h）
b=0;
B=[];
for i=1:m3
    if v(i)==0
        b=b+1;
    else
        if b > 180 
            B=[B;i b];
            b=0;
        else 
            b=0;
        end
    end
end

% 删除数据
[mb,nb]=size(B);
B=sortrows(B,1,'descend');
for i=1:mb
    data3(B(i,1)-B(i,2):B(i,1)-180,:)=[];
end
%% (4)删除怠速
data4=data3;
[m4,n4]=size(data4); 
v = data4(:,2);  %单位（km/h）
time=data4(:,1); %单位（s）
b=0;
B=[];

for i=1:m4
    if v(i)<=10
        b=b+1;
        
    else
        if b > 180 
            B=[B;i b];
            b=0;
        else 
            b=0;
         
        end
    end
end

% 删除数据
[mb,nb]=size(B);
B=sortrows(B,1,'descend');
for i=1:mb
    data4(B(i,1)-B(i,2):B(i,1)-180,:)=[];
end


%% 输出数据
xlswrite('data1.4.xlsx',data4);
%data1:185725
%data2:185693
%data3:178637
%data4:178281




