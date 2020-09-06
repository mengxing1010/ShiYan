function confusion_matrix1(act1, det1)
%act1Ϊ��ʵ�ı�ǩ��det1ΪԤ���ǩ
%�������������
%https://blog.csdn.net/xuyingjie125/article/details/78417760
[mat, order] = confusionmat(act1, det1);
%confusionmat����������������mat���ػ�������order����ÿ���������ڵ���
%mat(i,j)��ʾѵ������i���ڲ��Լ��б��ֵ�j��ĸ���
k = max(order);   %kΪ����ĸ���

imagesc(mat); %imagesc����������mat��Ԫ����ֵ����Сת��Ϊ��ͬ��ɫ�������������Ӧλ����������ɫȾɫ
colormap(flipud(gray)); %ת���ɻҶ�ͼ
%colormap�����������趨�ͻ�ȡ��ǰɫͼ�ĺ���
%flipud�Ǿ���ת���gray��matlab���þ���
%gray()�᷵��M��3�ľ���
title('��������');
textStrings = num2str(mat(:),'%0.02f');
%num2str(x��precision)������xת�����ַ�����ʽ��ʾ��precisionΪ����
textStrings = strtrim(cellstr(textStrings));
%cellstr�ǽ��ַ�����ת����cell����
%�����ַ����Ŀ�ͷ��β���Ŀո��Ʊ��س���

%meshgrid��MATLAB�������������������ĺ���
[x,y] = meshgrid(1:k);
hStrings = text(x(:),y(:),textStrings(:),'HorizontalAlignment','center');
%text������ʾ������string��λ����������ָ����λ�ã��Ҷ�ָ�������Խ�������
%HorizontalAlignment��ʾ����ˮƽ����Ķ��뷽ʽ��center��ʾ�ı�����м����
midValue = mean(get(gca,'CLim')); 
%get(gca,'CLim')��ȡ��ǰ����������������������CLim(ColorLimit)ֵ������ʹ��ͬ��ͼʹ����ͬ��ɫ��
%mean�������ؾ�ֵ��ʹ��midValue���ͼɫ��ľ�ֵ0.5000
textColors = repmat(mat(:) > midValue,1,3);
%������[mat(:)>midValue]����1��3���ʸ������ɫֵ����Ϊ����3��Ԫ�ص���ֵʸ����
%�Ѿ���[mat(:)>midValue]��Ϊ����textColors��Ԫ��
%B=repmat(A,M,N)����һ�������������������ظ�ʱʹ�ã��书������A�����ݶѵ��ڣ�M��N���ľ���B�У�
%B����Ĵ�С��M��N��A��������ݾ�����
%���A��һ��3��4��5�ľ��������B��Ϊ6��12��5

set(hStrings,{'Color'},num2cell(textColors,2));
%n=1��ʾ��ÿ�е�������ת��Ϊcell��n=2��ʾ��ÿ�е�������ת��Ϊcell�����ṹ����ת������������
%Ȼ��setȥ�غ����hStrings

%�����Լ��ķ���Ҫ���������ǩ
set(gca,'XTick',1:9,'XTickLabel',{'1','2','3','4','5','6','7','8','9'},'YTick''1:9','YTickLabel',{'1','2','3','4','5','6','7','8','9'});