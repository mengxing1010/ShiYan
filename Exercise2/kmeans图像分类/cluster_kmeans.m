clear
%循环读取所有图片，得到灰度矩阵，分别铺成一行，放入data中，形成kmeans数据data
pt = 'D:\MatlabFiles\Projects\Exercise2\kmeans图像分类\image60\';  
ext = '*.jpg';  
dis = dir([pt ext]);  
nms = {dis.name};  
data = zeros(length(nms),98304);  
for k = 1:1:length(nms)  
    nm = [pt nms{k}];  
    I = imread(nm);  
    gray = rgb2gray(I);
    data(k,:) = reshape(gray,1,98304);  
end 


%kmeans聚类算法处理数据
N=6;%设置聚类数目  
[m,n]=size(data);  
pattern=zeros(m,n+1);  
center=zeros(N,n);%初始化聚类中心  
pattern(:,1:n)=data(:,:);  
for x=1:N  
    center(x,:)=data(randi(60,1),:);%第一次随机产生聚类中心  
end  
while true  
    distence=zeros(1,N);  
    num=zeros(1,N);  
    new_center=zeros(N,n);  
   
    for x=1:m  
        for y=1:N  
        distence(y)=norm(data(x,:)-center(y,:));%计算到每个类的距离  
        end  
        [~, temp]=min(distence);%求最小的距离  
        pattern(x,n+1)=temp;
    end  
    k=0;  
    for y=1:N  
        for x=1:m  
            if pattern(x,n+1)==y  
                new_center(y,:)=new_center(y,:)+pattern(x,1:n);  
                num(y)=num(y)+1;  
            end  
        end  
        new_center(y,:)=new_center(y,:)/num(y);  
        if norm(new_center(y,:)-center(y,:))<0.1  
            k=k+1;  
        end  
    end  
    if k==N  
        break;  
    else  
        center=new_center;  
    end  
end  
[m, n]=size(pattern);


% 最后显示聚类后的灰度图像     
for i=1:m  
    if pattern(i,n)==1
        imshow(reshape(pattern(i,1:n-1),256,384))
        c1 = zeros(256,384);
        c1(:,:) = reshape(pattern(i,1:n),256,384);
        mkdir image1
        imwrite(gray,'image1/test1.png') 
    elseif pattern(i,n)==2  
         plot(pattern(i,1),pattern(i,2),'g*');  
         plot(center(2,1),center(2,2),'ko');  
    elseif pattern(i,n)==3  
         plot(pattern(i,1),pattern(i,2),'b*');  
         plot(center(3,1),center(3,2),'ko');  
    elseif pattern(i,n)==4  
         plot(pattern(i,1),pattern(i,2),'y*');  
         plot(center(4,1),center(4,2),'ko');  
    else  
         plot(pattern(i,1),pattern(i,2),'m*');  
         plot(center(4,1),center(4,2),'ko');  
    end  
    end
c = zeros(256,384);
for j = 1:1:N
    a = find(pattern(:,n)==j);
    a = a'; 
    figure
    for i = 1:1:num(j)
        subplot(1,num(j),i)
        nm1 = [pt nms{a(i)}];  
        I1 = imread(nm1);
        imshow(I1)
    end 
end

