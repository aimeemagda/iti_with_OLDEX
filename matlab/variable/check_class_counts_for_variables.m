function check_class_counts_for_variables(tree,here)
%* compare class_counts, note differences
%* author: Paul Utgoff
%modified by J. Brooks Zurn

VERBOSE = 1;

global n_variables

if(VERBOSE) fprintf('(check_class_counts_for_variables)entering function\n'); end

node_class_counts = get_tree_class_counts(tree,here);
variable_class_counts = get_variable_class_counts(tree,here);

is_equal = equal_class_counts(node_class_counts,variable_class_counts);

if(~is_equal)
        fprintf('(check_class_counts_for_variables)class_counts inconsistent\n');    
end

% for i=1:n_variables
%     
%     if(~equal_class_counts(tree(here).class_counts,tree(here).variables(i).class_counts))
%         fprintf('here=%d\n',here);
%     end
%     
% end