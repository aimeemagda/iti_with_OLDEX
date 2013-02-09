function tree = send_instance_down(tree,here,inst)
%send instance recursively down through tree
%author: J. Brooks Zurn, modified from Paul Utgoff
%inputs:
%tree: the tree
%here: the current node in the current tree
%inst: the new instance to append
%output:
%tree: the updated tree,

global current_inst_tag
global n_variables
SUPER_VERBOSE = 0;

%first update count at this node

tree = increment_class_count_key(tree,here,inst(1,1).classname,1);
tree = add_variable_info_to_tree_node(tree,inst(1,:),here);
tree = get_node_class(tree,here);

if (SUPER_VERBOSE)
    for i=1:n_variables
        fprintf('tree(%d).variables(%d).class_counts is',here,i);
        tree(here).variables(i).class_counts
    end
end

%if this is a decision node, update tests and try to descend
if(tree(here).left||tree(here).right)
    if(SUPER_VERBOSE) fprintf('(send_instance_down) found a decision node\n'); end
    
    if(test_is_true(tree,here,inst))
        if(SUPER_VERBOSE) fprintf('(send_instance_down) sending left (true)\n'); end
        tree = send_instance_down(tree,tree(here).left,inst);
    else
        if(SUPER_VERBOSE) fprintf('(send_instance_down) sending right (false)\n'); end
        tree = send_instance_down(tree,tree(here).right,inst);
    end
else %otherwise if this is a leaf node
    if(SUPER_VERBOSE) fprintf('found a leaf node, current_inst_tag=%d\n',current_inst_tag); end
    
    tree = split_node_if_impure(tree,here);
    
    
end %end "is it decision or leaf node"