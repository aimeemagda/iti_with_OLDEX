function tree = get_child_node(tree,here,side)
%initialize child node on side designated by 'side'
%inputs: tree: the tree
%side: string, left or right
global n_classes
global all_classes
global n_variables

%[dummy n_classes] = size(get_all_classes(tree));

%[num_insts n_variables] = size(get_all_variables(tree));



if(strcmpi(side,'left'))

        tree(here).left = get_next_open_node(tree);
        tree = get_tree_node(tree,n_variables,n_classes,tree(here).left);
        %all_classes=get_all_classes(tree);
        %tree(tree(here).left) = load_classnames_into_tree(tree(tree(here).left),get_all_classes(tree));
        tree(tree(here).left) = load_classnames_into_tree(tree(tree(here).left),all_classes);
        tree(tree(here).left).parent = here;
        tree(tree(here).left).min_insts_second_majority = tree(here).min_insts_second_majority;
        
        for this_var = 1:n_variables
            tree(tree(here).left).variables(this_var).variable_key = tree(here).variables(this_var).variable_key; 
        end
        
elseif(strcmpi(side,'right'))
        tree(here).right = get_next_open_node(tree);
        tree = get_tree_node(tree,n_variables,n_classes,tree(here).right);
        %tree(tree(here).right) = load_classnames_into_tree(tree(tree(here).right),get_all_classes(tree));
        tree(tree(here).right) = load_classnames_into_tree(tree(tree(here).right),all_classes);
        tree(tree(here).right).parent = here;
        tree(tree(here).right).min_insts_second_majority = tree(here).min_insts_second_majority;

        for this_var = 1:n_variables
            tree(tree(here).right).variables(this_var).variable_key = tree(here).variables(this_var).variable_key; 
        end
        
else
    fprintf('error(get_child_node): incorrect child designation %s (should be ''left'' or ''right'')',side);
end


