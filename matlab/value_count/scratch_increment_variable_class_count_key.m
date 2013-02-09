function tree = increment_variable_class_count_key(tree,here,variable,key,n)
%author: J. Brooks Zurn
%split off the variable class counter from the regular one because now the
%entire tree is operated on and passed back.
%usage: %tree =
%increment_variable_class_count_key(tree,here,j,insts(i,j).classname,1);
%inputs:
%tree: the tree
%here: the current node
%variable: the current variable
%key: the current classname
%n: the number of instances to examine
%outputs:
%tree: the entire tree, updated

%figure out how many classes we're dealing with
[dummy num_classes] = size(tree(here).class_counts);

%make sure array is initialized, otherwise we can't fill it
%if(~tree(here).variables(1).class_counts(1).count) %if it is an empty array
%    tree(here).class_counts(1).count = 0; %set it to zero
%end

%test every class.
%for i=1:num_classes
%    if(strcmp(tree.class_counts(i).key,key))
%        tree.class_counts(i).count = tree.class_counts(i).count + 1;
%    end
%end

%found = 0;

%get it out of cell format
if(iscell(tree(here).variables(variable).class_counts))
    numeric_list_counts = cell2mat(tree(here).variables(variable).class_counts);
else
    numeric_list_counts = tree(here).variables(variable).class_counts;
end

%for each instance, update the count for the found class.
for j=1:n
    for i=1:num_classes
        if(strcmp(tree(here).class_counts(i).key,key))
            %tree(here).variables(variable).class_counts(i) = tree(here).variables(variable).class_counts(i) + 1;
            numeric_list_counts(i,1) = numeric_list_counts(i,1) + 1; 
            %found = 1;
        end  %we will assume previous functions have cleaned the whitespace from the key.
    end
end %end repeat for number of instances        

        