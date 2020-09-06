close;clear;clc;
I=im2double(imread('coins.png'));  %��Ϊ˫���ȣ���0-1
subplot(221);imhist(I);            %��ʾ�Ҷ�ֱ��ͼ
[M,N]=size(I);                     %�õ�ͼ����������
number_all=M*N;                    %������ֵ
hui_all=0;                         %Ԥ��ͼ���ܻҶ�ֵΪ0
ICV_t=0;                           %Ԥ����󷽲�Ϊ0
%�õ�ͼ���ܻҶ�ֵ
for i=1:M
    for j=1:N
        hui_all=hui_all+I(i,j);
    end
end
all_ave=hui_all*255/number_all;   %ͼ��Ҷ�ֵ����ƽ��ֵ
 
 
%tΪĳ����ֵ����ԭͼ���ΪA���֣�ÿ������ֵ>=t����B���֣�ÿ������ֵ<t��
for t=0:255                       %������̽����tֵ
    hui_A=0;                      %��������A�����ܻҶ�ֵ
    hui_B=0;                      %��������B�����ܻҶ�ֵ
    number_A=0;                   %��������A����������
    number_B=0;                   %��������B����������
    for i=1:M                     %����ԭͼ��ÿ�����صĻҶ�ֵ
        for j=1:N
            if (I(i,j)*255>=t)    %�ָ���Ҷ�ֵ��=t������
                number_A=number_A+1;  %�õ�A����������
                hui_A=hui_A+I(i,j);   %�õ�A�����ܻҶ�ֵ
            elseif (I(i,j)*255<t) %�ָ���Ҷ�ֵ��t������
                number_B=number_B+1;  %�õ�B����������
                hui_B=hui_B+I(i,j);   %�õ�B�����ܻҶ�ֵ
            end
        end
    end
    PA=number_A/number_all;            %�õ�A��������������ͼ�������صı���
    PB=number_B/number_all;            %�õ�B��������������ͼ�������صı���
    A_ave=hui_A*255/number_A;          %�õ�A�����ܻҶ�ֵ��A���������صı���
    B_ave=hui_B*255/number_B;          %�õ�B�����ܻҶ�ֵ��B���������صı���
    ICV=PA*((A_ave-all_ave)^2)+PB*((B_ave-all_ave)^2);  %Otsu�㷨
    if (ICV>ICV_t)                     %�����жϣ��õ���󷽲�
        ICV_t=ICV;
        k=t;                           %�õ���󷽲��������ֵ
    end
end
k                                      %��ʾ��ֵ