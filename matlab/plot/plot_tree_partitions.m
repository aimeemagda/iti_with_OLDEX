function plot_tree_partitions(tree,x,y,nodes,zip_train_data,zip_train_classes,markersize)
%draw a scatterplot based on 2 attributes and partition it based on the
%cut values in the tree
%requires: descend_partition.m, scatter_shapes.m
%inputs:
%tree:iti tree
%x,y:attributes (columns) to plot
%nodes: maximum nodes to traverse (0=traverse entire tree)
%zip_train_data,zip_train_classes: data and classes to plot and partition

[zip_train_classes_numeric zip_train_classes_numeric_key] = get_numeric_classes(zip_train_classes);
    
% figure
hold on
scatter_shapes(zip_train_data(:,x),zip_train_data(:,y),markersize,zip_train_classes_numeric(:,1));

if(nodes<1)
    [dummy nodes]=size(tree);
end

cutvars = zeros(nodes,1);
cutvals = cutvars;

for i=1:nodes
   % get cutvar
   cutvars(i,1)=tree(1,i).best_variable;
   % get cutval
   if(cutvars(i,1)>0)
    cutvals(i,1)=tree(1,i).variables(1,(cutvars(i,1))).cutpoint{1};
   end
end

%now start partitioning
partitions_x = zeros(nodes,2);
partitions_y = zeros(nodes,2);

% xmin = min(zip_train_data(:,x));
% xmax = max(zip_train_data(:,x));
% ymin = min(zip_train_data(:,y));
% ymax = max(zip_train_data(:,y));
temp=xlim;
xmin = temp(1,1);
xmax = temp(1,2);
temp=ylim;
ymin=temp(1,1);
ymax=temp(1,2);

%descend starting at node 1 (root)
[partitions_x,partitions_y] = descend_partition(tree,1,cutvars,cutvals,x,y,xmin,xmax,ymin,ymax,partitions_x,partitions_y);

%draw the partitions on the scatterplot
%hold on  already set this earlier

for i=1:nodes
    line(partitions_x(i,:),partitions_y(i,:));
end

%reset plot limits to data limits
axis([xmin xmax ymin ymax])