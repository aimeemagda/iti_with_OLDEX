function tree = split_node_if_impure(tree,here)
%checks if a node is impure; splits it recursively if necessary
%calls rebuild_instances_below_node to rebuild using existing inst info
%author: J. Brooks Zurn
%inputs:
%tree: the input tree
%here: the current node in the tree
%outputs:
%tree: the tree, which has been further split if necessary

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

VERBOSE = 0;

if(~is_node_pure(tree,here))
    if(VERBOSE) fprintf('leaf is impure\n'); end
    fprintf('!');
    
    [tree,new_best_variable,best_metric_value,best_new_merit] = best_variable_by_indirect_metric(tree,here);
    
    %if indirect metric finds a best value
    if(new_best_variable)
        if(VERBOSE) fprintf('found a new best split variable (%d) for impure leaf (old best==%d)\n',new_best_variable,tree(here).best_variable); end
        
        %get and initialize left and right children
        tree = get_child_node(tree,here,'left');
        tree = get_child_node(tree,here,'right');
        
        tree_class_counts = get_child_node(tree_class_counts,here,'left');
        tree_class_counts = get_child_node(tree_class_counts,here,'right');
        tree_class_counts_tags = get_child_node(tree_class_counts_tags,here,'left');
        tree_class_counts_tags = get_child_node(tree_class_counts_tags,here,'right');
        tree_numeric_value_counts = get_child_node(tree_numeric_value_counts,here,'left');
        tree_numeric_value_counts = get_child_node(tree_numeric_value_counts,here,'right');
        
        %figure out if node is numeric or symbolic
        %if symbolic, set best value to new_best_value
        %if numeric, set cutpoint to new cutpoint
        tree(here).best_variable = new_best_variable;
        tree(here).variables(new_best_variable).cutpoint = tree(here).variables(new_best_variable).new_cutpoint;
        %set tree flag ~stale
        tree(here).flags.stale = 0;
        %send the instances down through the node
        %send previous instances down through decision
        
        %%%%%tree = add_instances_below_node(tree,insts(i,:),here);
        tree = rebuild_instances_below_node(tree,here,0); %ensure = 0;
        
        
    else %otherwise clean up variable info from node and keep it a leaf
        if(VERBOSE) fprintf('no best split for impure leaf, keeping it a leaf\n'); end
    end
    
    %             if(~inst_already_appended)
    %                 inst_already_appended = 1;
    %             end
    
else %node is pure and add the instance
    if(VERBOSE) fprintf('leaf is pure\n'); end    
end %don't try to split node if it's pure