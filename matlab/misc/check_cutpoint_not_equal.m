function cutpoint_not_equal = check_cutpoint_not_equal(tree,here,var,new_cutpoint)
%check if cutpoints are equal, first ensure that cutpoints are in right
%format
%author: J. Brooks Zurn

tree(here).variables(var).cutpoint = ensure_cutpoint_not_nested(tree(here).variables(var).cutpoint);
%tree(here).variables(var).cutpoint{1,1} ~= new_cutpoint
if(array_is_empty(tree(here).variables(var).cutpoint{1,1}))
    %fprintf('(check_cutpoint_not_equal) cutpoint array is empty\n');
    cutpoint_not_equal = 1;
elseif(tree(here).variables(var).cutpoint{1,1} ~= new_cutpoint)
    %fprintf('(check_cutpoint_not_equal) cutpoint is not equal to new cutpoint\n');    
    cutpoint_not_equal = 1;
else
    %fprintf('(check_cutpoint_not_equal) cutpoint IS equal\n');
    cutpoint_not_equal = 0;
end
