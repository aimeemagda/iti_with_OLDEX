function tree = pull_up_num(tree,here,var,new_cutpoint)
% * Achieve new numeric test by transposition.
% * author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs:
%tree: the tree
%here: the current node of tree
%var: the variable for the new cutpoint
%new_cutpoint: the new cutpoint
%outputs:
%tree: the transposed tree
%notes: calling function (ensure_best_variable_this_node) already made sure
%       tree(here).variables(var).cutpoint{1} existed.

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

VERBOSE = 0;
SUPER_VERBOSE = 0;

left = tree(here).left;
right = tree(here).right;

%is the current cutpoint and var same as new cutpoint?

if((tree(here).best_variable ~= var)||(tree(here).variables(var).cutpoint{1} ~= new_cutpoint))
    %if((tree(here).best_variable ~= var)||cutpoint_not_equal)
    
    if(VERBOSE)
        if(iscell(tree(here).variables(var).cutpoint))
            fprintf('(pull_up_num)-->need to transpose, here=%d,var=%d,new best var=%d,cutpoint=%f,new_cutpoint=%f\n',here,tree(here).best_variable,var,tree(here).variables(var).cutpoint{1},new_cutpoint);
        else
            fprintf('(pull_up_num)-->need to transpose, here=%d,var=%d,new best var=%d,cutpoint=[],new_cutpoint=%f\n',here,tree(here).best_variable,var,new_cutpoint);
        end
    end
    %ensure left subtree ready for transpose
    if(left)
        if(SUPER_VERBOSE) fprintf('(pull_up_num) left subtree=%d\n',tree(here).left); end
        if(tree(left).left||tree(left).right)
            v=tree(left).best_variable;
            if(SUPER_VERBOSE) fprintf('(pull_up_num) left or right sub-subtree exists, and v=%d\n',v); end
            %             cutpoint_left_not_equal = check_cutpoint_not_equal(tree,tree(here).left,v,new_cutpoint);
            %
            %if((v~=var)||(array_is_empty(tree(left).variables(v).numeric_value_counts))||(tree(left).variables(v).cutpoint{1}~= new_cutpoint))
            if((v~=var)||(array_is_empty(tree_numeric_value_counts(left).variables(v).numeric_value_counts))||(tree(left).variables(v).cutpoint{1}~= new_cutpoint))
                if(SUPER_VERBOSE)fprintf('(pull_up_num) need to pull up left subtree, left subtree best var =%d, here best var=%d,left subtree cutpoint = %d, here new_cutpoint=%d\n',v,var,tree(left).variables(v).cutpoint{1},new_cutpoint); end
                %
                tree = pull_up_num(tree,left,var,new_cutpoint);
                %
            end %end pull up left subtree
        end %end check if left subtree has its own subtrees
    end %end check if left subtree exists
    %
    % %ensure right subtree ready for transpose
    if(right)
        if(SUPER_VERBOSE) fprintf('(pull_up_num) right subtree=%d\n',tree(here).right); end
        if(tree(right).left||tree(right).right)
            v=tree(right).best_variable;
            if(SUPER_VERBOSE) fprintf('(pull_up_num) right or right sub-subtree exists, and v=%d\n',v); end
            %             cutpoint_right_not_equal = check_cutpoint_not_equal(tree,tree(here).right,v,new_cutpoint);
            %
            %if((v~=var)||(array_is_empty(tree(right).variables(v).numeric_value_counts))||(tree(right).variables(v).cutpoint{1}~= new_cutpoint))
            if((v~=var)||(array_is_empty(tree_numeric_value_counts(right).variables(v).numeric_value_counts))||(tree(right).variables(v).cutpoint{1}~= new_cutpoint))
                if(SUPER_VERBOSE)fprintf('(pull_up_num) need to pull up right subtree, right subtree best var =%d, here best var=%d,right subtree cutpoint = %d, here new_cutpoint=%d\n',v,var,tree(right).variables(v).cutpoint{1},new_cutpoint); end
                %
                tree = pull_up_num(tree,right,var,new_cutpoint);
                %
            end %end pull up right subtree
        end %end check if right subtree has its own subtrees
    end %end check if right subtree exists
    
    
    %do it
    if(VERBOSE) fprintf('(pull_up_num) transpose the tree now\n'); end
    tree = transpose_tree(tree,here,var,new_cutpoint);
    
end