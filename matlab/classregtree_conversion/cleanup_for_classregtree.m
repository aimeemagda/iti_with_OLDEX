function tree3 = cleanup_for_classregtree(tree)
%clean up iti tree structure so that it can be converted to a classregtree 
%author: J. Brooks Zurn



%make an index of the new addresses

[dummy num_nodes] = size(tree);
change_of_address_form20 = zeros(num_nodes,1);
current_defined_node = 1;
for i=1:num_nodes
    if(tree(i).parent > -1)
        change_of_address_form20(i,1)=current_defined_node;
        %new_tree5(current_defined_node)=tree5(i);
        current_defined_node=current_defined_node+1;
    else
        change_of_address_form20(i,1)=0;
    end
end

tree2 = tree; %make a duplicate and modify duplicate

for i=1:num_nodes
    if(tree(i).left)
        tree2(i).left =change_of_address_form20(tree(i).left,1);
    else
        tree2(i).left = 0;
    end
    if(tree(i).right)
        tree2(i).right =change_of_address_form20(tree(i).right,1);
    else
        tree2(i).right = 0;
    end
    if(tree(i).parent > 0)
        tree2(i).parent = change_of_address_form20(tree(i).parent,1);
    end  %if parent==0, it's the root and leave it alone, also leave the -1 flags
end

%now move to a new tree, without empty nodes

current_defined_node = 1;
for i=1:num_nodes
    if(tree2(i).parent > -1)
    tree2_fixed(current_defined_node)=tree2(i);
    current_defined_node=current_defined_node+1;
    end
end

%next problem: nodes whose children have numerically lower addresses are 
%plotted higher on screen than their parents.  need to reorganize tree so 
%that all parents have lower address than children.


%%%%%%%%%%function get out of order
% [dummy tree2_size] =size(tree2_fixed);
% out_of_order = zeros(tree2_size,1);
% 
% %figure out how many nodes are out of order
% for i=1:tree2_size
%    if(tree2_fixed(i).parent>0)
%        if(tree2_fixed(i).parent > i)
%            out_of_order(i,1) = 1;
%        end
%    end
% end
% %get locations of out_of_order nodes
% 
% out_of_order_ix = find(out_of_order);
%%%%%%%%%%%%%%%%%%%%%end function get out of order


%%%%%%%%%%%%%%%function reorder nodes

%maybe try swapping locations between parent and its lowest child?

%swap locations of the lowest out_of_order parent and child, then check for
%out of order again.  maybe it's fixed. NO!!!! when moving parent, have to
%fix both children!!!!

out_of_order_ix = get_out_of_order(tree2_fixed);

[num_out_of_order dummy]=size(out_of_order_ix);
    
tree3 = tree2_fixed;
while(num_out_of_order)
%if(num_out_of_order)
    
    current_ix = out_of_order_ix(1,1);
    %child_ix = 
    parent_ix = tree3(current_ix).parent;
    
    if(current_ix == tree3(parent_ix).left)
        left_ix = current_ix;
        right_ix = tree3(parent_ix).right;
    elseif(current_ix == tree3(parent_ix).right)
        right_ix = current_ix;
        left_ix = tree3(parent_ix).left;
    else
        fprintf('error, out of order node does not correspond to left or right child of its parent, returning unmodified tree and exiting function\n');
        
        %return;
    end
    
    %if left index > right, first swap left and right nodes
    
%     temp_tree_node_child = tree3(child_ix);
%     temp_tree_node_parent = tree3(parent_ix);

    %now put the parent in the lowest node and shift others down
    
    temp_parent = tree3(parent_ix);
    temp_left = tree3(left_ix);
    temp_right = tree3(right_ix);
    
    %load PARENT tree into left_ix
    tree3(left_ix)   = temp_parent;
    
    %shift LEFT child down into right_ix
    tree3(right_ix)  = temp_left;
    
    %shift RIGHT child down into former parent node
    tree3(parent_ix) = temp_right;
    
    %update the local parameters for each node
    %PARENT @left_ix
    tree3(left_ix).here  = left_ix;
    tree3(left_ix).left  = right_ix;
    tree3(left_ix).right = parent_ix;
    
    %LEFT @right_ix
    tree3(right_ix).here   = right_ix;
    tree3(right_ix).parent = left_ix;
    
    %RIGHT @parent_ix
    tree3(parent_ix).here   = parent_ix;
    tree3(parent_ix).parent = left_ix;
    
    %fix the parent addresses for the left and right children
    
    %LEFT childrens' parent
    left_left = tree3(right_ix).left;
    left_right = tree3(right_ix).right;
    tree3(left_left).parent = right_ix;
    tree3(left_right).parent = right_ix;
    
    %RIGHT childrens' parent
    right_left = tree3(parent_ix).left;
    right_right = tree3(parent_ix).right;
    tree3(right_left).parent = parent_ix;
    tree3(right_right).parent = parent_ix;
    
%     tree3(parent_ix) = temp_tree_node_child;
%     tree3(parent_ix).here = parent_ix;
%     tree3(parent_ix).parent = child_ix;
%     
%     tree3(child_ix) = temp_tree_node_parent;
%     tree3(child_ix).here = child_ix;
%     
%     if(child_is_left > -1)
%         if(child_is_left > 0)
%             tree3(child_ix).left = parent_ix;
%         else
%             tree3(child_ix).right = parent_ix;
%         end
%     else %otherwise there's a real problem, this node has no parent
%         fprintf('(reorganize_nodes) error: this child is neither left nor right child of parent\n');
%     end
    
    out_of_order_ix = get_out_of_order(tree3);

    [num_out_of_order dummy]=size(out_of_order_ix);

    
end

