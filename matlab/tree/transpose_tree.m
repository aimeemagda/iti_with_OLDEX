function tree = transpose_tree(tree,here,var,cutpoint)
%* Redirect node pointers so that tree is transposed.  Handles subtrees
%* that are missing or are leaves.  Reconstruct any level one info that
%* is needed.
%notes: add 'val_key' later for symbolic variables
%* author: Paul Utgoff (JC)
%modified by J. Brooks Zurn
%inputs:
%tree: the tree
%here: the current node
%var: the current best variable
%cutpoint: the current best cutpoint
%outputs:
%tree: the transposed tree

VERBOSE = 0;
SUPER_VERBOSE = 0;

global n_transpositions

%increment n_transpositions
n_transpositions = n_transpositions + 1;

if(VERBOSE) fprintf('(transpose_tree) transposing tree, here=%d\n',here); end
left = tree(here).left;
right = tree(here).right;


%  if(left || right)
% % %check left and right branch class counts
% check_class_counts_for_variables(tree,here);
% %
%  end
%
v=tree(here).best_variable;
%
if(v~=0)
    %     %if symbolic
    %     if (~array_is_empty(tree(here).variables(v).symbolic_value_counts))
    %         %root_best_value_key = tree(here).variables(v).best_value->key.symbolic;
    %     elseif(~array_is_empty(tree(here).variables(v).numeric_value_counts)) %elseif numeric
    %             root_best_value_key = '';
    %     end
    %
    %  else
    %      if(VERBOSE) fprintf('(transpose_tree): error: no best variable');end
    %  end
    %
    % %iterate through transpositions, depending on which branches are present
    % %%%%%%%%%%%%%%%%%%% BEGIN iterate through all possible decision/leaf configurations
    if(left)
        if(right)
            if(SUPER_VERBOSE) fprintf('(transpose_tree) neither right nor left branch is missing\n');end
                     ll = tree(left).left;
                     lr = tree(left).right;
                     rl = tree(right).left;
                     rr = tree(right).right;
            
                     if(ll || lr)
                         if(SUPER_VERBOSE) fprintf('(transpose_tree) left node is a decision node\n'); end
                         if(rl||rr)
                             if(VERBOSE) fprintf('(transpose_tree) left and right are both decision nodes\n');end
                             %                     %compute and assign new left subtree
                             %                     %tree = rebuild_subtree(tree,here,ll,rl,v,root_best_value_key,tree(here).variables(v).cutpoint);
                             if(iscell(tree(here).variables(v).cutpoint))
                                 tree = rebuild_subtree(tree,left,v,tree(here).variables(v).cutpoint);
                                 tree = rebuild_subtree(tree,right,v,tree(here).variables(v).cutpoint);
                                 tree(here).best_variable = var;
                                 tree(here).variables(var).cutpoint = num2cell(cutpoint);
                             else %if the cutpoint doesn't exist, completely rebuild node
                                 tree = rebuild_subtree(tree,here,var,num2cell(cutpoint));
                             end
                             %
                             %                     %compute and assign new right subtree
                             %                     %tree = rebuild_subtree(tree,here,lr,rr,v,root_best_value_key,tree(here).variables(v).cutpoint);
                             %
                             %                     %set variable
                             %                     test_type = set_test(tree,here,var,'',cutpoint);
                             %
                             %                     if(strcmp(test_type,'MISSING'))
                             %                         %tree = reduce_tree_to_leaf(tree,here);
                             %                     end
                             %
                         else % ~(rl||rr)
                             if(VERBOSE) fprintf('(transpose_tree) left is decision, right is leaf\n');end
                            if(SUPER_VERBOSE) fprintf('(transpose_tree) use left node as result, add instances from right to it\n');end
                            tree_temp = tree(left);
                            %tree = free_children_recursively(tree,here);  %don't need this, rebuild_subtree does it automatically
                            
                            %not sure if I should pull right node up, or go
                            %ahead and just rebuild it now
                            
                            %this totally rebuilds it
                            %tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
                            
                            %this pulls right node up and rebuilds it using
                            %left node info
                            left_best_var = tree_temp(1).best_variable;
                            if(iscell(tree_temp(1).variables(left_best_var).cutpoint))
                                left_best_cutpoint = tree_temp(1).variables(left_best_var).cutpoint;
                                if(SUPER_VERBOSE) fprintf('(transpose_tree) rebuilding node using left decision info\n'); end
                                tree=rebuild_subtree(tree,here,left_best_var,left_best_cutpoint);
                            else % if the cutpoint is empty, totally rebuild using passed info
                                fprintf('(transpose_tree) warning: cutpoint not found for pre-existing split, rebuilding node\n');
                                tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
                            end
                            
                        end
            %
                     else % ~(ll||lr)
                         if(SUPER_VERBOSE) fprintf('(transpose_tree) left node is a leaf\n');end
            
                        if(rl||rr)   % ~(ll||lr) && (rl||rr)
                            if(VERBOSE) fprintf('(transpose_tree) left is leaf, right is decision\n');end
                            %supposed to copy right node to parent and 
                            %incorporate left instances
                            tree_temp = tree(right);
                            %tree = free_children_recursively(tree,here); %don't need this, rebuild_subtree does it automatically
                            
                            %not sure if I should pull right node up, or go
                            %ahead and just rebuild it now
                            
                            %this totally rebuilds it
                            %tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
                            
                            %this pulls right node up and rebuilds it using
                            %right node info
                            right_best_var = tree_temp(1).best_variable;
                            if(iscell(tree_temp(1).variables(right_best_var).cutpoint))
                                right_best_cutpoint = tree_temp(1).variables(right_best_var).cutpoint;
                                if(SUPER_VERBOSE) fprintf('(transpose_tree) rebuilding node using right decision info\n'); end
                                tree=rebuild_subtree(tree,here,right_best_var,right_best_cutpoint);
                            else % if the cutpoint is empty, totally rebuild using passed info
                                fprintf('(transpose_tree) warning: cutpoint not found for pre-existing split, rebuilding node\n');
                                tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
                            end
                                
                            
                        else % ~(ll||lr) && ~(rl||rr)
                            if(VERBOSE) fprintf('(transpose_tree) left is leaf, right is leaf\n');end
                            if(SUPER_VERBOSE) fprintf('(transpose_tree) here=%d,var=%d,cutpoint=%f\n',here,var,cutpoint);end
                            
                            %set new test, then add instances below
                            %because all the instance counts are saved at
                            %the node, can just set new test and rebuild
                            %below it.
                            
                            tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
                            
                            %first clear out the left and right subtrees
%                             free_node_recursively(tree,left);
%                             free_node_recursively(tree,right);
%                             tree = get_child_node(tree,here,'left');
%                             tree = get_child_node(tree,here,'right');
%                             
%                             %set best variable & cutpoint at this node
%                             tree(here).best_variable = var;
%                             tree(here).variables(var).cutpoint{1}=cutpoint;
%                             
                            
                            
                            
                            
                        end
            
                     end %end (ll||lr)
            %
            %
        else % ~right
            if(VERBOSE) fprintf('(transpose_tree) tree has only left branch\n');end
            %         %remove all variable info
            %         %free tree node(here)
            %         %tree(here) =
            tree_temp = tree(left);
            left_best_var = tree_temp(1).best_variable;
            if(iscell(tree_temp(1).variables(left_best_var).cutpoint))
                left_best_cutpoint = tree_temp(1).variables(left_best_var).cutpoint;
                if(SUPER_VERBOSE) fprintf('(transpose_tree) rebuilding node using left decision info\n'); end
                tree=rebuild_subtree(tree,here,left_best_var,left_best_cutpoint);
            else % if the cutpoint is empty, totally rebuild using passed info
                fprintf('(transpose_tree) warning: cutpoint not found for pre-existing split, rebuilding node\n');
                tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
            end
            
        end
    else % ~left
        if(right)
            if(VERBOSE) fprintf('(transpose_tree) tree has only right branch\n');end
            %         %remove all variable info
            %         %free tree node(here)
            %         %tree(here) = right
            tree_temp = tree(right);
            right_best_var = tree_temp(1).best_variable;
            if(iscell(tree_temp(1).variables(right_best_var).cutpoint))
                right_best_cutpoint = tree_temp(1).variables(right_best_var).cutpoint;
                if(SUPER_VERBOSE) fprintf('(transpose_tree) rebuilding node using right decision info\n'); end
                tree=rebuild_subtree(tree,here,right_best_var,right_best_cutpoint);
            else % if the cutpoint is empty, totally rebuild using passed info
                fprintf('(transpose_tree) warning: cutpoint not found for pre-existing split, rebuilding node\n');
                tree=rebuild_subtree(tree,here,var,num2cell(cutpoint));
            end
            
            
        else  % ~left && ~right
            if(VERBOSE) end
                fprintf('(transpose_tree) error: can''t transpose a leaf\n');
        end
    end
    
else
    if(VERBOSE) fprintf('(transpose_tree): error: no best variable');end
end

% %%%%%%%%%%%%%%%%%%% END iterate through all possible decision/leaf configurations
%
% if(tree(here).left || tree(here).right)
%     %check_class_counts_for_variables(tree,here);
% end
%
% tree(here).flags.stale = 1;
