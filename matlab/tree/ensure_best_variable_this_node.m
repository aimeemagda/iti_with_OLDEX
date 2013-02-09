function tree = ensure_best_variable_this_node(tree,here)
%* Ensure that the best test is installed at this node.
% * author: Paul Utgoff
%modified by J. Brooks Zurn

%global current_inst_tag

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

VERBOSE = 0;
SUPER_VERBOSE = 0;

if(VERBOSE) fprintf('entering ensure best variable this node (node#%d)\n',here); end
if(tree(here).left || tree(here).right)
    %i==variable, best_metric_value==value, best_new_merit == metric result
    [tree,i,best_metric_value,best_new_merit,best_metric_value_ix] = best_variable_by_indirect_metric(tree,here);
    
    if(i~=0)
        
        %assume numeric!!!
        
        %[maxleft minright] = get_cutpoint_var_ix(best_metric_value,tree(here).variables(i).numeric_value_counts);
        minright = best_metric_value_ix;
        maxleft = minright - 1;
        
        if((minright > 1)&&(minright>maxleft))  %if it's not greater than leftmost value, don't split the array!!
            
            if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node) getting new cutpoint for subtree\n'); end
            
            if((tree(here).best_variable ~= i)|| ((tree(here).best_variable == i)&&(tree(here).variables(i).cutpoint{1}~= tree(here).variables(i).new_cutpoint{1}))) %if the current var isn't best
                if(VERBOSE)
                    if(tree(here).best_variable ~= i)
                        fprintf('(ensure_best_variable_this_node) new var is better\n');
                    end
                end
                if(SUPER_VERBOSE)
                    if((tree(here).best_variable == i)&&(tree(here).variables(i).cutpoint{1}~= tree(here).variables(i).new_cutpoint{1}))
                        fprintf('(ensure_best_variable_this_node) new_cutpoint ~= cutpoint \n');
                        %tree(here).variables(i).cutpoint
                        %tree(here).variables(i).new_cutpoint
                    end
                end
                
                
                %check if symbolic
                if(~array_is_empty(tree(here).variables(i).symbolic_value_counts))
                    %pull_up_sym
                %elseif(~array_is_empty(tree(here).variables(i).numeric_value_counts)) %check if numeric
                elseif(~array_is_empty(tree_numeric_value_counts(here).variables(i).numeric_value_counts)) %check if numeric
                    if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node) numeric_value_counts is not empty\n'); end
                    %check if new cutpoint is same as old cutpoint
                    
                    if(iscell(tree(here).variables(i).cutpoint))
                        if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node)tree(here).variables(i).cutpoint is a cell \n'); end
                        %if(tree(here).variables(i).new_cutpoint{1}~=tree(here).variables(i).cutpoint{1}  )
                        
                        %pull_up_num  pull up subtree
                        if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node) calling pull_up_num\n'); end
                        tree = pull_up_num(tree,here,i,tree(here).variables(i).new_cutpoint{1});
                        
                        %rebuild subtree now that we've got it??
                        tree = rebuild_subtree(tree,here,i,tree(here).variables(i).new_cutpoint);
                        %else
                        if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node)new_cutpoint == cutpoint \n'); end
                        %end
                        
                    else %if it's not a cell, we'll assume it didn't exist and overwrite it
                        if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node)tree(here).variables(i).cutpoint is NOT a cell \n'); end
                        %tree(here).variables(i).cutpoint
                        %tree(here).variables(i).new_cutpoint
                        tree(here).variables(i).cutpoint=tree(here).variables(i).new_cutpoint;
                        
                        %pull_up_num  pull up subtree, assume new_cutpoint is a
                        %cell
                        if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node) calling pull_up_num\n'); end
                        tree = pull_up_num(tree,here,i,tree(here).variables(i).new_cutpoint{1});
                        
                        %rebuild subtree now that we've got it??
                        tree = rebuild_subtree(tree,here,i,tree(here).variables(i).new_cutpoint);
                        
                        
                    end
                    
                    
                end
            else %even if the current variable -is- the best, update the cutpoint.  just don't rebuild tree or pull up node.
                
                
            end %end if current variable isn't the best
            
        else     %else best cutvar is leftmost value in list
            %fprintf('x');
            if(SUPER_VERBOSE) fprintf('(ensure_best_variable_this_node) error: cutpoint is below lowest val or above highest val. don''t change new_cutpoint\n'); end
        end
        
        tree(here).flags.stale = 0;
    else %no best variable now, reduce node to leaf
        tree = free_children_recursively(tree,here);
        
        tree_class_counts = free_children_recursively(tree_class_counts,here);
        tree_class_counts_tags = free_children_recursively(tree_class_counts_tags,here);
        tree_numeric_value_counts = free_children_recursively(tree_numeric_value_counts,here);
        
    end %end if a new best variable found
    
end %end check if branches exist




