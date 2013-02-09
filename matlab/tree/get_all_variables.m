function all_variables = get_all_variables(tree)
%re-get an array of all the classes

[dummy num_variables] = size(tree(1).variables);

for i=1:num_variables
    %we will assume key is string format
    all_variables{i}=tree(1).variables(i).variable_key;
end