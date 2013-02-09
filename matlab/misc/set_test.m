function result = set_test(tree, here, this_var,val_key,new_cutpoint)
%* Cause a particular test to become the test at the decision node.
%* author: Paul Utgoff
%modified by J. Brooks Zurn

tree(here).best_variable = this_var;

%symbolic or numeric?

if(~array_is_empty(tree(here).variables(this_var).symbolic_value_counts))
    result = 'SYMBOLIC';
    %lookup or insert symbolic value count node
elseif(~array_is_empty(tree(here).variables(this_var).numeric_value_counts))
    result = 'NUMERIC';
    tree(here).variables(this_var).cutpoint = new_cutpoint;
else
    result = 'MISSING';
end


            
