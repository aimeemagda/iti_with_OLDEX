function tree = ensure_best_variable(tree,here)
% * Recursively ensure that the best test is installed at each
% * decision node.
% * author: Paul Utgoff
%modified by J. Brooks Zurn
VERBOSE = 0;

if(VERBOSE) fprintf('(ensure_best_variable) entering function\n'); end

%if((tree(here).left || tree(here).right) && (tree(here).flags.stale))
if(tree(here).left || tree(here).right)
    tree = ensure_best_variable_this_node(tree,here);
    tree(here).flags.stale = 1; %after this we've restructured 'here'. move on to children
    
    %recursively check left, then right branches
    fprintf('/'); %display a signal to screen
    if(tree(here).left)
        tree = ensure_best_variable(tree,tree(here).left);
    end
    fprintf('\\'); %display a signal to screen
    if(tree(here).right)
        tree = ensure_best_variable(tree,tree(here).right);
    end
    
end
    