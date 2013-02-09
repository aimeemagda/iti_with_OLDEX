function tree = load_classnames_into_tree(tree,all_classes)
%load a pre-determined set of classnames into a tree
global n_classes
%[dummy n_classes] = size(all_classes);

temp_class_counts = initialize_type('class_count_node');


for i=1:n_classes
    temp_class_counts(i).key = all_classes{i};
    temp_class_counts(i).count = 0;
    
    temp_class_counts(i).left = 0;
    temp_class_counts(i).right = 0;
    temp_class_counts(i).next = 0;
    temp_class_counts(i).height = 0;
end

tree(1).class_counts = temp_class_counts;

