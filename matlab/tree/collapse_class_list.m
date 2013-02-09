function collapsed_list = collapse_class_list(list)
%collapse and accumulate values of an {n x m} cell array into a {1 x m} cell array
%author: J. Brooks Zurn
%input: list, a {n x m} cell array
%output: collapsed_list, a {1 x m} cell array

[n_classes n_values] = size(list);

if(n_classes<1)
    fprintf('(collapse_class_list) error: n_classes < 1\n')
    collapsed_list = list;
elseif(n_classes<2)
    collapsed_list = list;
else %n_classes >= 2
    for i=1:n_values
        
        collapsed_list{1,i}=horzcat(list{1,i},list{2,i});
        if(n_classes>2)
            for j=3:n_classes
                collapsed_list{1,i} = horzcat(collapsed_list{1,i},list{j,i});
            end
        end
    end
end



