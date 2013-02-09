function [maxleft minright] = get_cutpoint_var_ix(cutpoint,values_cell_array)
%get the indices of the values on either side of the cutpoint
%author: J. Brooks Zurn

maxleft = 0;
minright = 0;

values_array = cell2mat(values_cell_array);

[dummy num_vals] = size(values_array);
if(iscell(cutpoint))
    cutpoint = cell2mat(cutpoint);
end

for i=1:(num_vals)
    if(values_array(1,i)<cutpoint)  
        maxleft = i;
    end
end

if(maxleft<num_vals)
    minright = maxleft+1;
else
    minright = maxleft;
end
        