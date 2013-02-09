function class_counts = get_tree_class_counts(tree,here)
%get an [n_classes x 1] format array of class_counts
%author: J. Brooks Zurn

VERBOSE = 1;

global n_classes

if(VERBOSE) fprintf('(get_tree_class_counts) entering function\n'); end

class_counts = zeros(n_classes,1);

for i=1:n_classes
    class_counts(i,1)=tree(here).class_counts(i).count;
end

