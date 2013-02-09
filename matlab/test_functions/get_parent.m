function parent = get_parent(tree)

[dummy n_nodes] = size(tree);

parent = zeros(n_nodes,1);

for i=1:n_nodes
    parent(i,1) = tree(i).parent;
end

    