function all_classes = get_all_classes(tree)
%re-get an array of all the classes

[dummy num_classes] = size(tree(1).class_counts);

for i=1:num_classes
    %we will assume key is string format
    all_classes{i}=tree(1).class_counts(i).key;
end