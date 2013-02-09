function tree = get_node_class(tree,here)
%append the current majority class of this node
%this is mainly for compatibility with classregtree
%author: J. Brooks Zurn
global all_classes
global n_classes
%[dummy n_classes] = size(tree(here).class_counts);

%majority_class = 'none';
majority_class_count = 0;
majority_class = 1; %default is first class in list

for i=1:n_classes
    %class_counts(i,1)=tree(here).class_counts(i).count;
    %if(tree(here).class_counts(i).count > majority_class)
    if(tree(here).class_counts(i).count > majority_class_count)
        %majority_class = tree(here).class_counts(i).key;
        majority_class_count = tree(here).class_counts(i).count;
        majority_class = i;
        %majority_class = all_classes{i};
    elseif(tree(here).class_counts(i).count == majority_class_count)
        if(get_c_strcmp(all_classes{majority_class},all_classes{i})<0)
            %if they're the same and current class is lexically lower
            majority_class = i;
        end
    end
end

%tree(here).class = all_classes{majority_class}; 
tree(here).class = majority_class; 
%tree(here).classname = all_classes{majority_class};


