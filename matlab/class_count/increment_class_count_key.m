function tree = increment_class_count_key(tree,here,key,n)
%function to increment count for this key
%don't bother with AVL search tree for now. get it coded NOW.
%J. Brooks Zurn

%figure out how many classes we're dealing with
%[dummy num_classes] = size(tree(here).class_counts);
%[dummy n_classes] = size(get_all_classes(tree));
global n_classes
global all_classes
global current_inst_tag  %the tag number of the current instance
VERBOSE = 0;

%make sure array is initialized, otherwise we can't fill it
%if(~tree(here).class_counts(1).count) %if it is an empty array
if(~isfield(tree(here).class_counts,'count')) %if it is an empty array
    fprintf('(increment_class_count_key)here is %d,n_classes=%d',here,n_classes);
    tree(here).class_counts(1).count = 0; %set it to zero
end

%test every class.
%for i=1:n_classes
%    if(strcmp(tree.class_counts(i).key,key))
%        tree.class_counts(i).count = tree.class_counts(i).count + 1;
%    end
%end

found = 0;


for j=1:n
    i=1;
    while(~found)
        if(strcmp(tree(here).class_counts(i).key,key))
            tree(here).class_counts(i).count = tree(here).class_counts(i).count + 1;
            if(VERBOSE) fprintf('(increment_class_count_key) current class: %s, current count: %d\n',key,tree(here).class_counts(i).count);end
            found = 1;
        elseif(i<(n_classes+1))
            i = i+1;
        else % it wasn't there, make a new class with count = 1;
            found = 1;  %force search to quit
            tree(here).class_counts(i).key = key; %i is already advanced from elseif
            tree(here).class_counts(i).count = 1; %since we just found it, it's obviously there.
            n_classes = n_classes + 1;
            if(VERBOSE) fprintf('(increment_class_count_key) Warning: uninitialized class found; added to list.\n'); end
            all_classes{n_classes} = key;
        end  %we will assume previous functions have cleaned the whitespace from the key.

    end

end %end repeat for number of instances        

        