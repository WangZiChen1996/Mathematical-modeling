%% �������
clc
close all
clear all
%% ��ȡ����
deltatime=xlsread('�ļ�1ʱ��.xlsx');%�����ļ�1ʱ�����ݣ��룩
[num,txt]=xlsread('�ļ�1.xlsx');  % �����ļ�1����

data = [deltatime num];      %�ϲ����ݼ�
[m,n]=size(data);           %m=185725,n=14
data=[data(:,1) data(:,2) data(:,6)];   %��ѡ����������
[m,n]=size(data); 
%% (1)GPS�źŶ�ʧ
data1=data(find(data(:,3)>0),:);
%�����m=185722,n=3
%% (2)�ٶȡ����ٶ��쳣
data2=data1;
[m2,n2]=size(data2);
v = data2(:,2);  %��λ��km/h��

% v��km/h�� �ٶ�ɸѡ
B2=data2(find(data2(:,2)<280),:);
data2=B2;
% a (m/s2)  ���ٶ�ɸѡ
[m2,n2]=size(data2);
time=data2(:,1); %��λ��s��
a=[0];          %��λ��m/s2��
for i=1:m2-1
    a = [a;(v(i+1)-v(i))/3.6];
    
end

a1=a(find(a>-8&a<4),:);
A2=data2(find(a>-8&a<4),:);
data2=A2;

plot(A2(:,1),a1);  %��ʾ���������ٶȱ仯����
xlabel('ʱ�䣨s��');
ylabel('���ٶ�(m/s2)');
%% (3)����ͣ���쳣����������
data3=data2;
[m3,n3]=size(data3);
v = data3(:,2);  %��λ��km/h��
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

% ɾ������
[mb,nb]=size(B);
B=sortrows(B,1,'descend');
for i=1:mb
    data3(B(i,1)-B(i,2):B(i,1)-180,:)=[];
end
%% (4)ɾ������
data4=data3;
[m4,n4]=size(data4); 
v = data4(:,2);  %��λ��km/h��
time=data4(:,1); %��λ��s��
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

% ɾ������
[mb,nb]=size(B);
B=sortrows(B,1,'descend');
for i=1:mb
    data4(B(i,1)-B(i,2):B(i,1)-180,:)=[];
end


%% �������
xlswrite('data1.4.xlsx',data4);
%data1:185725
%data2:185693
%data3:178637
%data4:178281




