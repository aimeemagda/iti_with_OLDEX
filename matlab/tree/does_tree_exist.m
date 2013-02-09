function tree_exists = does_tree_exist(tree,here)
%determines whether a tree node exists (or is not orphaned) and returns 1(true) or 0(false)
%inputs:
%tree: a tree which may or may not be empty
%outputs:
%tree_exists: true (tree node exists) or false (tree node is empty)

[dummy tree_size] = size(tree);

if(here>tree_size) %here is larger than size of tree
    tree_exists=0;
elseif (tree(here).parent <0) %this is an orphan node
    tree_exists=0;
else    
    tree_exists=1;
end

%try 
%    tree_exists = isstruct(tree);
%catch
%    tree_exists = 0;
%end

    