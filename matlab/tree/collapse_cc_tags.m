function all_cc_tags = collapse_cc_tags(tree,here,variable)
%combine each column of class counts tags into a single row, for computing
%the numeric_value_counts memberships of each instance
%author: J. Brooks Zurn
%inputs:
%tree: the tree
%here: the current node
%variable: the current variable
%output:
%cc_tags: a cell array {1 x n_values}, where n_values is the number of unique
%values in the node (each a separate column in class_counts)

global n_classes

[dummy n_values] = size(tree(here).variables(variable).class_counts);


if(n_classes > 1)
    for i=1:n_values
        
        all_cc_tags{1,i} = horzcat(tree(here).variables(variable).class_counts_tags{2,i},tree(here).variables(variable).class_counts_tags{1,i});
        if(n_classes > 2)
            for j=3:n_classes
                all_cc_tags{1,i} = horzcat(all_cc_tags{1,i},tree(here).variables(variable).class_counts_tags{j,i});
            end
        end
    end
else
    all_cc_tags = tree(here).variables(variable).class_counts_tags;
end