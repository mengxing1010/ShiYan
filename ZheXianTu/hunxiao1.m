function confusion_matrix1(act1, det1)
%act1为真实的标签，det1为预测标签
%输入的是行向量
%https://blog.csdn.net/xuyingjie125/article/details/78417760
[mat, order] = confusionmat(act1, det1);
%confusionmat用来构建混淆矩阵，mat返回混淆矩阵，order返回每个变量所在的类
%mat(i,j)表示训练集中i类在测试集中被分到j类的个数
k = max(order);   %k为分类的个数

imagesc(mat); %imagesc函数将矩阵mat的元素数值按大小转化为不同颜色，并在坐标轴对应位置以这种颜色染色
colormap(flipud(gray)); %转换成灰度图
%colormap函数是用来设定和获取当前色图的函数
%flipud是矩阵倒转命令，gray是matlab内置矩阵
%gray()会返回M×3的矩阵
title('混淆矩阵');
textStrings = num2str(mat(:),'%0.02f');
%num2str(x，precision)把数组x转换成字符串形式表示，precision为精度
textStrings = strtrim(cellstr(textStrings));
%cellstr是将字符数组转换成cell类型
%裁切字符串的开头和尾部的空格，制表，回车符

%meshgrid是MATLAB中用于生成网格采样点的函数
[x,y] = meshgrid(1:k);
hStrings = text(x(:),y(:),textStrings(:),'HorizontalAlignment','center');
%text函数表示对文字string定位于用坐标轴指定的位置，且对指定的属性进行设置
%HorizontalAlignment表示文字水平方向的对齐方式，center表示文本外框中间对齐
midValue = mean(get(gca,'CLim')); 
%get(gca,'CLim')获取当前的坐标轴句柄，并设置它的CLim(ColorLimit)值，用来使不同的图使用相同的色标
%mean函数返回均值，使得midValue获得图色标的均值0.5000
textColors = repmat(mat(:) > midValue,1,3);
%将矩阵[mat(:)>midValue]复制1×3块的矢量（颜色值必须为包含3个元素的数值矢量）
%把矩阵[mat(:)>midValue]作为矩阵textColors的元素
%B=repmat(A,M,N)这是一个处理大矩阵且内容有重复时使用，其功能是以A的内容堆叠在（M×N）的矩阵B中，
%B矩阵的大小由M×N及A矩阵的内容决定，
%如果A是一个3×4×5的矩阵，则矩阵B变为6×12×5

set(hStrings,{'Color'},num2cell(textColors,2));
%n=1表示把每列的所有行转换为cell，n=2表示把每行的所有列转换为cell，将结构阵列转换成异质阵列
%然后set去重后放在hStrings

%根据自己的分类要求更改类别标签
set(gca,'XTick',1:9,'XTickLabel',{'1','2','3','4','5','6','7','8','9'},'YTick''1:9','YTickLabel',{'1','2','3','4','5','6','7','8','9'});