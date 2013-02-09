function classnode_exists = does_classnode_exist(class_node)
%determines whether a tree exists and returns 1(true) or 0(false)
%inputs:
%tree: a tree which may or may not be empty
%outputs:
%tree_exists: true (tree exists) or false (tree is empty)

classnode_exists = isstruct(class_node);

    