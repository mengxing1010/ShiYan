function [confusion_matrix]=compute_confusion_matrix(predict_label,num_in_class,name_class,grayimage)
%  Matlab code for computing and visulization of confusion matrix for
%  multi-classification problem
%
%  Author£º Page( Ø§×Ó)
%           Blog: www.shamoxia.com;
%           QQ:379115886;
%           Email: peegeelee@gmail.com
%  Date:    Dec. 2010
%
num_class=length(num_in_class);

confusion_matrix=size(num_class,num_class);

for ci=1:num_class
    for cj=1:num_class
        c_start=sum(num_in_class(1:(ci-1)))+1;
        c_end=sum(num_in_class(1:ci));
        confusion_matrix(ci,cj)=size(find(predict_label(c_start:c_end)==cj),1)/num_in_class(ci);
    end
end

draw_cm(confusion_matrix,name_class,num_class,grayimage);

end

function draw_cm(mat,tick,num_class,grayimage)
%%
%  Matlab code for visualization of confusion matrix;
%  Parameters£ºmat: confusion matrix;
%              tick: name of each class, e.g. 'class_1' 'class_2'...
%              num_class: number of class
%
%  Author£º Page( Ø§×Ó)  
%           Blog: www.shamoxia.com;  
%           QQ:379115886;  
%           Email: peegeelee@gmail.com
%%

matshow = log(mat);
imagesc(1:num_class,1:num_class,matshow);%# in color

if grayimage == 1
colormap(flipud(gray));  %# for gray; black for large value.
end

textStrings = num2str(mat(:),'%0.2f');
textStrings = strtrim(cellstr(textStrings));

for i = 1:length(textStrings)
    if isequal(textStrings(i),{'0.00'})
        textStrings(i) = {''};
    end
end

[x,y] = meshgrid(1:num_class); 
hStrings = text(x(:),y(:),textStrings(:), 'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim')); 
textColors = repmat(matshow(:) > midValue,1,3); 
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'xticklabel',tick,'XAxisLocation','top');
set(gca, 'XTick', 1:num_class, 'YTick', 1:num_class);
set(gca,'yticklabel',tick);
rotateXLabels(gca, 315 );% rotate the x tick
end
