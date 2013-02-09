function tree = initialize_tree(tree,min_insts_second_majority)
%initialize a tree if it doesn't exist
%author: J. Brooks Zurn

global n_variables
global n_classes
global all_classes
global variable_name
%global min_insts_second_majority

if(~isstruct(tree))
            tree= get_tree_node(tree,n_variables,n_classes,1);
        end
        
        tree(1) = load_classnames_into_tree(tree(1),all_classes);
        for i=1:n_variables
            tree(1).variables(i).variable_key = variable_name{i,1};
        end
        
        tree(1).min_insts_second_majority = min_insts_second_majority;
end