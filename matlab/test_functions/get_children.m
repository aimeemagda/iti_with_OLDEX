function children = get_children(tree)

[dummy n_nodes] = size(tree);

children = zeros(n_nodes,2);

for i=1:n_nodes
    children(i,1) = tree(i).left;
    children(i,2) = tree(i).right;
end

    