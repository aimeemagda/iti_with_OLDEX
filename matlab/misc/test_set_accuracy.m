function accuracy = test_set_accuracy(tree,test_set,here)
% * Return the proportion of the test set that is classified correctly.
% * author: Paul Utgoff
%modified by J. Brooks Zurn

accuracy = 0;
correct = 0;
n_tests=0;


[total dummy] = size(test_set);

if(total)
    for i=1:total
        [result n_tests] = classify(tree,here, test_set(i,:),n_tests); %here = 1; the root node of the tree
        if(result>0)
            if(strcmpi(test_set(i).classname,tree(here).class_counts(result).key))
                correct = correct + 1;
            end
        end
    end
    
    accuracy = correct/total;
end










