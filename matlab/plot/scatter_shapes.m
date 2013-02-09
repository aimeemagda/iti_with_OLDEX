function scatter_shapes(x,y,s,c)
%plot a scatterplot with shapes for different marker types
%x=x axis
%y=y axis
%s=size of marker
%c=class of each row

markers = {'+','o','*','x','s','d','^','v','>','<','p','h'};
classes = unique(c);
[num_classes dummy]=size(classes);



figure
hold on
for i=1:num_classes
    current_class=(c==classes(i,1));
    scatter(x(current_class,1),y(current_class,1),s,c(current_class,1),markers{i})
end
