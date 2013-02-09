function [mytree,myclasscounts,myclasscountstags]=clear_counts_this_value(value,mytree,myclasscounts,myclasscountstags)
%delete all instance counts for this value
%note: numeric_value_counts has only the actual values, which is unused if
%there are no class counts.  therefore we don't bother clearing it.
%author: J. Brooks Zurn
%inputs:
%mytree: the tree - need to remove from cumulative class count
%myclasscounts - need to remove counts for this value
%myclasscountstags - need to remove instance tags for this value
%outputs: same as input, but fixed

global n_classes

% mytree=tree_oldex_2;   %these 3 are for testing only
% myclasscounts=tree_oldex_2_class_counts;
% myclasscountstags=tree_oldex_2_class_counts_tags;

% [dummy num_values] = size(myclasscounts.variables);
% 
% temp_counts_this_val = myclasscounts.variables(1,value).class_counts;
% 
% cumulative_counts_before_val = 0;
% if(value>1)
% for i=1:(value-1)
%     cumulative_counts_before_val = cumulative_counts_before_val + myclasscounts.variables(1,i).class_counts;
% end
% end
% 
% class_sums = sum(temp_counts,2)';

%remove class counts that are no longer in tree (associated with removed
%value)
% for i=1:n_classes
%     mytree.class_counts(1,i) = mytree.class_counts(1,i) - class_sums(1,i);
% end

%now clear the value accumulators and instance tags
[num_classes num_vals] = size(myclasscounts.variables(1,value).class_counts);

myclasscounts.variables(1,value).class_counts = zeros(num_classes,num_vals);

for i=1:n_classes
    for j=1:num_vals
        %myclasscounts.variables(1,value).class_counts(i,j)=0;
        myclasscountstags.variables(1,value).class_counts_tags{i,j}=[];
    end
end
    