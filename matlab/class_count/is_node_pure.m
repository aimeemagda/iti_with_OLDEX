function pure = is_node_pure(tree,this_node)
%is the node pure?

n_majority = 0;
n_second_majority = 0;
min_insts_second_majority = tree(1).min_insts_second_majority;
[dummy num_classes] = size(tree(this_node).class_counts);

these_class_counts = zeros(num_classes,1);

%are there any class counts?
%what's the highest class count?
%what's the second highest class count?
if(num_classes>1)
    for i=1:num_classes
        these_class_counts(i,1) = tree(this_node).class_counts(i).count;
    end

    these_class_counts = sort(these_class_counts,'descend'); %only size of counts matters

    if(these_class_counts(2,1)<min_insts_second_majority)
        pure = 1;
    else
        pure = 0;
    end
else
    pure = 0;
end


