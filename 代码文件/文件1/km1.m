%% 使用K-Means算法聚类消费行为特征数据
%% 201909

clc
close all
clear all

% 参数初始化
inputfile = 'dimention_reducted.xls'; 
% inputfile = '1pca.xlsx'; 

k =2; % 聚类的类别
iteration =500 ; % 聚类最大循环次数
distance = 'sqEuclidean'; % 距离函数

%% 读取数据
[num,txt]=xlsread(inputfile);
data = num(:,2:end);
A=xlsread('sport1.xlsx')

%% 数据标准化
% data = zscore(data);
% z-score 标准化(正太标准化)是基于原始数据的均值（mean）和标准差（standard deviation）
% 进行数据的标准化。将A的原始值x使用z-score标准化到x’。

%% 调用kmeans算法
opts = statset('MaxIter',iteration);
[IDX,C,~,D] = kmeans(data,k,'distance',distance,'Options',opts);

%% 打印结果
for i=1:k
   disp(['第' num2str(i) '组聚类中心为：']);
   disp(C(i,:));
end
[s,h] = silhouette(data,IDX,'sqeuclid'); grid on;

xlswrite('IDX1.xlsx',IDX);
