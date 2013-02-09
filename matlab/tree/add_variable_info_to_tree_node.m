function tree = add_variable_info_to_tree_node(tree,insts,here)
%* Update the variable information according to the instance.
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%changes in Matlab version: program no longer differentiates between
%numeric and symbolic for missing values.  
%
%tree: tree node class
%inst: instance class
%here: the current node of the tree

% char *symval;
open_class = initialize_type('class_count_node');
current = open_class;

VERBOSE = 0;
SUPER_VERBOSE = 0;

%  tree.flags |= STALE; 
%  flag the node stale
tree(here).flags.stale = 1;

%n_variables is initialized in read_variable_names
%we can figure it out from tree.instance
[n_instances n_variables] = size(insts);

if(VERBOSE) fprintf('(add_variable_info_to_tree_node) entering function\n'); end

%for all the passed instances
for i=1:n_instances
    for j=1:n_variables
        %figure out if it's missing, numeric, or symbolic and update
        %accordingly
        if(SUPER_VERBOSE) fprintf('(add_variable_info_to_tree_node) figure out which type of variable\n'); end
        if(strcmp(insts(i,j).symbolic,'MISSING'))
            if(SUPER_VERBOSE) fprintf('(add_variable_info_to_tree_node) variable is MISSING\n'); end
            tree(here).variables(j).missing_value_counts = tree(here).variables(j).missing_value_counts + 1;
        elseif(strcmp(insts(i).symbolic,'NUMERIC'))
            if(SUPER_VERBOSE) fprintf('(add_variable_info_to_tree_node) variable is NUMERIC\n'); end
            tree = get_numeric_value_counts(tree,here,j,insts(i,j),i);
            %tree(here).variables(j).numeric_value_counts = tree(here).variables(j).numeric_value_counts + 1;
            %increment_numeric_value_count_key
        elseif(strcmp(insts(i,j).symbolic,'SYMBOLIC'))
            if(SUPER_VERBOSE) fprintf('(add_variable_info_to_tree_node) variable is SYMBOLIC\n'); end
            %tree(here).variables(j).symbolic_value_counts = tree(here).variables(j).symbolic_value_counts + 1;        
            %increment_symbolic_value_count_key
        else if(VERBOSE) fprintf('(add_variable_info_to_tree_node) didn''t find variable type\n'); end
            
        end

        %update the variable class_counts
        %fprintf('\n\ncalling increment_variable_class_count_key\n\n');
        %tree = increment_variable_class_count_key(tree,here,j,insts(i,j).classname,1);

        %update the total number of variables count
        tree(here).variables(j).count = tree(here).variables(j).count + 1;
    end % end repeat for all variables
    
end %end processing all instances
