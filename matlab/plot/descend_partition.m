function [partitions_x,partitions_y] = descend_partition(tree,current_node,cutvars,cutvals,x,y,xmin,xmax,ymin,ymax,partitions_x,partitions_y)

%input: tree, min and max partition limits, partitions
%if(tree(1,current_node).left>0)
%set partition between min and max
%reset min and max
%descend left
%elseif(tree(1,current_node).right>0))
%set partition between min and max
%reset min and max
%descend right
%end
xmin_old = xmin;
xmax_old = xmax;
ymin_old = ymin;
ymax_old = ymax;

if(tree(1,current_node).left>0) %left is a decision node, descend
    if(cutvars(current_node,1)==x)
        %set x,y vals for partition i
        partitions_x(current_node,:)=cutvals(current_node,1);
        partitions_y(current_node,1)= ymin;
        partitions_y(current_node,2)= ymax;
        xmax=cutvals(current_node,1);
        %[partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).left,cutvars,cutvals,x,y,xmin,cutvals(current_node,1),ymin,ymax,partitions_x,partitions_y);
    elseif(cutvars(current_node,1)==y)
        %set x,y vals for partition i
        partitions_y(current_node,:)=cutvals(current_node,1);
        partitions_x(current_node,1)= xmin;
        partitions_x(current_node,2)= xmax;
        ymax=cutvals(current_node,1);
        %[partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).left,cutvars,cutvals,x,y,xmin,xmax,ymin,cutvals(current_node,1),partitions_x,partitions_y);
    end
    [partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).left,cutvars,cutvals,x,y,xmin,xmax,ymin,ymax,partitions_x,partitions_y);
end
%reset min&max for this tree level
xmin = xmin_old;
xmax = xmax_old;
ymin = ymin_old;
ymax = ymax_old;

if(tree(1,current_node).right>0) %right is a decision node, descend
    if(cutvars(current_node,1)==x)
        %set x,y vals for partition i
        partitions_x(current_node,:)=cutvals(current_node,1);
        partitions_y(current_node,1)= ymin;
        partitions_y(current_node,2)= ymax;
        xmin=cutvals(current_node,1);
        %[partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).right,cutvars,cutvals,x,y,cutvals(current_node,1),xmax,ymin,ymax,partitions_x,partitions_y);
    elseif(cutvars(current_node,1)==y)
        %set x,y vals for partition i
        partitions_y(current_node,:)=cutvals(current_node,1);
        partitions_x(current_node,1)= xmin;
        partitions_x(current_node,2)= xmax;
        ymin=cutvals(current_node,1);
        %[partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).right,cutvars,cutvals,x,y,xmin,xmax,cutvals(current_node,1),ymax,partitions_x,partitions_y);
    end
    [partitions_x,partitions_y] = descend_partition(tree,tree(1,current_node).right,cutvars,cutvals,x,y,xmin,xmax,ymin,ymax,partitions_x,partitions_y);
end