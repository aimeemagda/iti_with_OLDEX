function next = get_next_open_node(tree)
%function to find the next open node (the end) of a tree

[dummy tree_size] = size(tree);
free_node = -1;
not_done = 1;

%return the highest free node
i=1;
while (not_done)
    if(tree(i).parent == -1)
        not_done = 0;
        free_node = i;
    end
    i = i + 1;
    if(i > tree_size)
        not_done = 0;
    end
end

if(free_node > -1)
    next = free_node;
else
    next = tree_size + 1;
end