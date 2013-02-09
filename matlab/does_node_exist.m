function tree_exists = does_node_exist(tree)
%determines whether a tree exists and returns 1(true) or 0(false)
%inputs:
%tree: a tree which may or may not be empty
%outputs:
%tree_exists: true (tree exists) or false (tree is empty)

tree_exists = isstruct(tree);

    