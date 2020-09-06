close all;
clear all;
clc;

m=0.5;              %�Ŵ����С�ĸ߶�
n=0.5;              %�Ŵ����С�Ŀ��
img=imread('lena.jpg');
imshow(img);
[h w]=size(img);
imgn=zeros(h*m,w*n);
rot=[m 0 0;0 n 0;0 0 1];                                   %�任����

for i=1:h*m
    for j=1:w*n
        pix=[i j 1]/rot;   
        
        float_Y=pix(1)-floor(pix(1)); 
        float_X=pix(2)-floor(pix(2));
       
        if pix(1) < 1 %�߽紦��
            pix(1) = 1;
        end
        
        if pix(1) > h
            pix(1) = h;
        end
        
        if pix(2) < 1
            pix(2) =1;
        end
        
        if pix(2) > w
            pix(2) =w;
        end
        
        pix_up_left=[floor(pix(1)) floor(pix(2))];%�ĸ����ڵĵ�
        pix_up_right=[floor(pix(1)) ceil(pix(2))];
        pix_down_left=[ceil(pix(1)) floor(pix(2))];
        pix_down_right=[ceil(pix(1)) ceil(pix(2))];     
    
        value_up_left=(1-float_X)*(1-float_Y);%�����ٽ��ĸ����Ȩ��
        value_up_right=float_X*(1-float_Y);
        value_down_left=(1-float_X)*float_Y;
        value_down_right=float_X*float_Y;
%��Ȩ�ؽ���˫���Բ�ֵ
        imgn(i,j)=value_up_left*img(pix_up_left(1),pix_up_left(2))+ ...
                  value_up_right*img(pix_up_right(1),pix_up_right(2))+ ...
                  value_down_left*img(pix_down_left(1),pix_down_left(2))+ ...
                  value_down_right*img(pix_down_right(1),pix_down_right(2));        
    end
end

figure,imshow(uint8(imgn))