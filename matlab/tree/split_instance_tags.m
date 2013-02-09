function [left_list right_list] = split_instance_tags(tree,here,cutval,maxleft)
%function to split the instance tags
%author: J. Brooks Zurn

%global tree_class_counts
global tree_class_counts_tags
%global tree_numeric_value_counts

%[n_classes n_vals] = size(tree(here).variables(cutval).class_counts_tags);
[n_classes n_vals] = size(tree_class_counts_tags(here).variables(cutval).class_counts_tags);
for i=1:n_classes
    left_list{i,1} = [];
    right_list{i,1} = [];
end

for i=1:maxleft
    for j=1:n_classes
%            left_list{j,1} = horzcat(left_list{j,1},tree(here).variables(cutval).class_counts_tags{j,i});
            left_list{j,1} = horzcat(left_list{j,1},tree_class_counts_tags(here).variables(cutval).class_counts_tags{j,i});
    end
end
for i=(maxleft+1):n_vals
    for j=1:n_classes
%            right_list{j,1} = horzcat(right_list{j,1},tree(here).variables(cutval).class_counts_tags{j,i});
            right_list{j,1} = horzcat(right_list{j,1},tree_class_counts_tags(here).variables(cutval).class_counts_tags{j,i});
    end
end
