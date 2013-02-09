function tree = add_instances_below_node(tree,insts,here)
%* Remove instances at a source_tree node, and then try to add each instance
%* recursively to dest_tree node.
%* author: Paul Utgoff
%modified by J. Brooks Zurn

[num_insts n_variables] = size(insts);


%new_left = tree(tree(here).left);
%new_right = tree(tree(here).right);


for i=1:num_insts
    
    if(test_is_true(tree,insts(i,:),here))
        %descend left for true
        %if(tree(here).left)
             tree = add_instances_above_node(tree,insts(i,:),tree(here).left);  %%%%%%%%%%%%
        %else
        %    tree = get_child_node(tree,here,'left');
        %    tree = add_instances_above_node(tree,insts(i,:),tree(here).left);
        %end
            
    else
        %descend right for false
        
        %if(tree(here).right)
            tree = add_instances_above_node(tree,insts(i,:),tree(here).right);  %%%%%%%%%%%%%%%
        %else
        %    tree = get_child_node(tree,here,'right');
        %    tree = add_instances_above_node(tree,insts(i,:),tree(here).right);
        %end
    end

end


                                
