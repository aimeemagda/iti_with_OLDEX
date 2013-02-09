function [numeric_vals_counts tags_ix_sorted] = get_numeric_vals_counts(tree,here,variable,list)
%uses list to select members of numeric values
%author: J. Brooks Zurn
%

all_cc_tags = collapse_class_list(tree(here).variables(variable).class_counts_tags);
all_list_tags = collapse_class_list(list);


[dummy n_values] = size(all_cc_tags);
[dummy n_values_list]=size(cell2mat(all_list_tags));

numeric_vals_counts_mat = zeros(1,n_values_list)

%get logicals for intersection of list and all_cc_tags

if((n_values>0)&&(n_values_list>0))
    [tags tags_ix list_tags_ix] = intersect(cell2mat(all_cc_tags),cell2mat(all_list_tags))
    
    tags_ix_sorted = sort(tags_ix)
    
    for i=1:n_values_list
        numeric_vals_counts(i)=tree(here).variables(variable).numeric_value_counts(tags_ix_sorted(i))
    end

    
else
    numeric_vals_counts = {[]};
    numeric_vals_cc_ix=0;
end




    