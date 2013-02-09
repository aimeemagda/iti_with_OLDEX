function [result n_tests] = classify(tree,here,instance,n_tests)
%* Classify inst according to tree.
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%this classifies an instance starting at node 'here'
%originally, the function assigned the string of the classname to result.
%instead, 

result = 0;

if(does_tree_exist(tree,here))
    if(((tree(here).left)||(tree(here).right))&&(~tree(here).flags.vpruned))
        n_tests = n_tests+1; %this is the number of tree tests required to classify the instance
        
        if(test_is_true(tree,instance,here)) %recursively send node to bottom of tree
            result = classify(tree,tree(here).left,instance,n_tests);
        else
            result = classify(tree,tree(here).right,instance,n_tests);
        end
        
    else
        %result = tree(here).class_counts(tree(here).class).key;
        result = tree(here).class; %return the class number instead of the string name
    end
else
    fprintf('(classify) error: tree sent test instance to bad node\n');
end

%leaves result as null if the class ends up going to a bad node
