function class_counts = get_variable_class_counts(tree,here)
%get an [n_classes x n_variables] format array of class_counts
%author: J. Brooks Zurn

VERBOSE = 1;

global n_classes
global n_variables

if(VERBOSE) fprintf('(get_tree_class_counts) entering function\n'); end

class_counts = zeros(n_classes,n_variables);


for i=1:n_variables
    for j=1:n_classes
        class_counts(j,i)= sum(cell2mat(tree(here).variables(i).class_counts(j,:)),2);
    end
end

