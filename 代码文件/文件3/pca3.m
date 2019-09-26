clc
clear all
close all

%% 主成分分析 降维

% 参数初始化
inputfile = 'X3.xlsx';
outputfile = 'dimention_reducted.xls';   % 降维后的数据
proportion = 0.8 ; % 主成分的比例

%% 数据读取
[num,~] = xlsread(inputfile);

%% 主成分分析
% 主成分特征向量与特征根对应，特征根从大到小排列，与变量元素不对应；
% 各元素与第一个特征向量相乘，得到新的第一个最主要的成分；
% 由此8个原来的变量pca成8个新的变量，重要性从大到小排列；
% 8个原来的变量乘上系数后成分重要性从大到小排列；
% 交换原数据的两个成分，则每个特征向量中的两个对应数值交换位置，不影响新的成分；
% 特征向量,特征根
[coeff,~,latent] = pca(num);   %主成分单位特征向量,主成分特征根

%% 计算累计贡献率，确认维度
sum_latent = cumsum(latent/sum(latent));    % 累计贡献率
dimension = find(sum_latent>proportion);
dimension= dimension(1);

%% 降维
%怎么运算的？num[14*8]*coeff[8*3]=data[14*3]
data = num * coeff(:,1:dimension); 
xlswrite(outputfile,data);
disp('主成分特征根：');
disp(latent');
disp('主成分单位特征向量');
disp(coeff);
disp('累计贡献率');
disp(sum_latent');
disp(['主成分分析完成，降维后的数据在' outputfile]);