function [class_num height] = tree_test(tree,here,inst,height)
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

global current_inst_tag
%global n_variables
SUPER_VERBOSE = 0;

if(tree(here).left||tree(here).right) %
    if(SUPER_VERBOSE) fprintf('(tree_test) decision '); end
    
    if(test_is_true(tree,here,inst))
        if(SUPER_VERBOSE) fprintf('(tree_test) left (true)\n'); end
        [class_num height] = tree_test(tree,tree(here).left,inst,height+1);
    else
        if(SUPER_VERBOSE) fprintf('(tree_test) right (false)\n'); end
        [class_num height] = tree_test(tree,tree(here).right,inst,height+1);
    end
else %otherwise if this is a leaf node
    if(SUPER_VERBOSE) fprintf('(tree_test) reached leaf, current_inst_tag=%d\n',current_inst_tag); end
    
    %get current class number of node
    class_num = tree(here).class;
    
    %height is already set from the input argument
    
    
end %end "is it decision or leaf node"

