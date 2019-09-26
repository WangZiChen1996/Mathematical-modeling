%% �������
clc
close all
clear all
%% ��ȡ����
data=xlsread('data3.4.xlsx'); %��������
% IDX=xlsread('IDX1.xlsx'); %��������
%% ��ȡƬ��
v = data(:,2);  %��λ��km/h��
time=data(:,1); %��λ��s��
a=[0];          %��λ��m/s2��
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

%% �������ֵ
%%% ����洢��A������
%A��2�У�T��Ƭ�γ���ʱ�䣺�����ļ��з����ܵ���
%A��3�У�ƽ���ٶ�V_aƽ���ٶȣ�V_a=S/Tƽ���ٶ�
%A��4�У���ʻ·��S=��?��v(i)��
%A��5��, T_a: j���ٶȴ���0.15m/s2���ܵ���
%A��6��,T_d�����ٶ�С��-0.15/s2���ܵ���
%A��7��,T_i������ʱ��������ٶ�Ϊ0�ҷ������ٶȲ�Ϊ0���ܵ���
%A��8��,�ٶȱ�׼��
%A��9��,���ٶȱ�׼��
%A��10��,���ٶ����ֵ
%A��11��,���ٶ���Сֵ
%A��12��,ƽ�����ٶ�
%A��13��,ƽ�����ٶ�
%A��14��,�ٶ����ֵ
%A��15��,ƽ����ʻ�ٶ�
%A��16��,Ѳ��ʱ��
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

%% �˶�ѧƬ��ɸѡ
% (1)��ȥС��20s���˶�ѧƬ��
%  �˶�ѧƬ����ȡ�����������

% (2)ɾ��ƽ����ʻ�ٶȴ���280km/h��ɾ��ƽ���ٶ�С��1km/h
A1=A(find(A(:,15)<280),:);
A2=A1(find(A1(:,3) > 1),:);

% (3)���ٶ��쳣
A3=A2(find(A2(:,10)<4),:);
A4=A3(find(A3(:,11)>-8),:);

A=A4;


%% ���ݱ�׼��

[ma,na]=size(A);  %ma=1328,na=15
X = zscore(A(:,2:end));

%%
xlswrite('sport3.xlsx',A);
xlswrite('X3.xlsx',X);
