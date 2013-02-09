function leaves = count_leaves(tree,here,leaves)
%use an existing decision tree to return a class for the current instance
%author: J. Brooks Zurn
%inputs:
%tree: the decision tree (important for calling function recursively)
%here: the current node of the tree
%inst: the test instance
%height: the 'height' of the current branch (the number of nodes the test
%has passed through)
%outputs:
%class_num: the number of the class assigned to the instance
%notes: first call to this function should have height=0, because if it
%goes straight to a leaf then the number of tests is zeros

SUPER_VERBOSE = 0;

if(tree(here).left||tree(here).right)
    if(SUPER_VERBOSE) fprintf('(count_leaves) decision '); end
    
    if(tree(here).left)
        if(SUPER_VERBOSE) fprintf('(count_leaves) left\n'); end
        leaves = count_leaves(tree,tree(here).left,leaves);
    end
    
    if(tree(here).right)
        if(SUPER_VERBOSE) fprintf('(count_leaves) right\n'); end
        leaves = count_leaves(tree,tree(here).right,leaves);
    end
else %otherwise if this is a leaf node
    if(SUPER_VERBOSE) fprintf('(count_leaves) reached leaf\n'); end
    
    leaves = leaves + 1;
    
    %height is already set from the input argument
    
    
end %end "is it decision or leaf node"

