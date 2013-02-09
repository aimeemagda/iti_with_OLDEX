function [best_merit, best_variable] = get_best_old_merit(tree,here,n_variables)
%get the best of the old merit values 
%author: J. Brooks Zurn
%inputs:
%tree: the tree
%here: the current node
%n_variables: number of variables
%outputs:
%best_merit: the best merit value
%best_variable: the variable corresponding to the best merit value

all_best_merit = zeros(n_variables,1); %the row corresponds to the var #
all_best_merit_sorted = zeros(n_variables,1); 
all_best_variables_sorted = zeros(n_variables,1); 

for i=1:n_variables
    if(~array_is_empty(tree(here).variables(i).best_value))
        all_best_merit(i,1)=tree(here).variables(i).best_value;
    else
        all_best_merit(i,1)=0;
    end
end

[all_best_merit_sorted, all_best_variables_sorted] = sort(all_best_merit,'descend');

best_merit = all_best_merit_sorted(1,1);
if(best_merit)
    best_variable = all_best_variables_sorted(1,1);
else
    best_variable = 0;
end
