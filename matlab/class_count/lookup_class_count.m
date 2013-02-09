function result = lookup_class_count(tree,here,variable,this_class)
% * look up the count for a class
% * author: Paul Utgoff
%modified by J. Brooks Zurn
%not using the AVL search method, just direct indexing

%result = 0;

%find current class in node

result = tree(here).variables(variable).class_counts{this_class,variable};

% %get the count for that class
% if(current_count > 0)
%     result = current_count;
% end

