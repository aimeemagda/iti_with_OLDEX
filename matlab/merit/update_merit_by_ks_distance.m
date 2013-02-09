function [best_metric_value, new_best_variable, new_best_merit, tree,best_new_metric_value_ix] = update_merit_by_ks_distance(tree,here)
%* Pick the best test according to the ks-distance metric.
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%first this function finds the best variable/cutpoints for all variables
%then it figures out which variable/cutpoint is the best.
%
%inputs:
%v: current variable
%tree: the current tree
%here: the current node of the tree
%outputs:
%best_metric_value:the best metric value found (can be NULL)
%new_best_variable: the new best variable (can be NULL)
%DEBUG_MERIT = 0;
global DEBUG_MERIT
global n_variables
global n_classes
global current_inst_tag

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

%[dummy n_variables] = size(tree(1).variables);
VERBOSE = 0;

best_metric_value = 0;
new_best_variable = 0;
new_best_value = 0; 
new_best_merit = 0;
best_new_metric_value_ix=0;

current_best_metric_value = 0;
%current_new_best_variable = -1;
current_new_best_variable = 0;
current_new_best_merit = 0;

%locally_best_value = initialize_type('value_count_node');
%last_val = locally_best_value;
%less_ccs = initialize_type('class_count_node');



if(VERBOSE)fprintf('Enter update_merit_by_ks_distance()\n'); end

%find the best variable/cutpoints for all variables
%best_val = zeros(n_variables,1);
%best_merit = zeros(n_variables,1);
best_new_val = zeros(n_variables,1);
best_new_merit = zeros(n_variables,1);
best_metric_value_ix = zeros(n_variables,1);

for variable=1:n_variables
    
    
   %is this variable numeric or symbolic?
   
   %if symbolic
   %if(tree(here).variables(i).symbolic_value_counts
   if(~array_is_empty(tree(here).variables(variable).symbolic_value_counts))
       if(DEBUG_MERIT) fprintf('     symbolic\n'); end
       %fprintf('\nentering set_merit_by_ks_distance_symbolic\n');
        %init locally_best_value = NULL;
        %locally_best_value = ...
        %set_merit_by_ks_distance_symbolic(tree,here,variable,tree(here).variables(i).symbolic_value_counts);
             %tree(here).variables(i).new_best_value = locally_best_value;
                %if(locally_best_value)
                    %tree(here).variables(i).metric_value = 0.0;
                %end
   %elseif(tree(here).variables(i).numeric_value_counts)
   %elseif(~array_is_empty(tree(here).variables(variable).numeric_value_counts))
   elseif(~array_is_empty(tree_numeric_value_counts(here).variables(variable).numeric_value_counts))    
       if(DEBUG_MERIT) 
       end
           %fprintf('\nentering set_merit_by_ks_distance_numeric\n');                
                    %if(tree(here).variables(i).numeric_value_counts)
                    less_ccs = zeros(n_classes,1);
                    last_val = 0;
                    %tree(here).variables(i).metric_value = 0.0;
            
                    [last_val,less_ccs,best_new_val(variable,1),best_new_merit(variable,1),tree,best_metric_value_ix(variable,1)] = set_merit_by_ks_distance_numeric(tree,here,variable,last_val,less_ccs);
                    
%             if(DEBUG_MERIT)
%                 fprintf('  considering var %s (%d)\n',tree(here).variables(variable).variable_key,variable);
%             end
                    
                    %tree = update_metric_values(tree,here,best_new_val,best_new_merit,n_variables);
   end

end

for variable=1:n_variables

            
            if(DEBUG_MERIT)
                fprintf('(update_merit_by_ks_distance) current_inst_tag=%d\n',current_inst_tag);
%                 tree(here).variables(variable).new_cutpoint
%                 best_new_merit(variable,1)
%                 current_new_best_merit
%                 current_new_best_variable
                fprintf('  considering var %s (%d)\n',tree(here).variables(variable).variable_key,variable);
                
                fprintf('     numeric\n'); 
                %tree(here).variables(variable).new_cutpoint{1,1}
                if(~array_is_empty(tree(here).variables(variable).new_cutpoint))
                fprintf('       new_cutpoint: %3.2f\n',tree(here).variables(variable).new_cutpoint{1,1});
                fprintf('       metric_value: %3.0f\n',best_new_merit(variable,1));
                end
                %fprintf('       *best_metric_value: %3.2f\n',current_best_metric_value);
                fprintf('       *best_metric_value: %3.0f\n',current_new_best_merit);
                fprintf('       *new_best_variable: %3.0f\n',current_new_best_variable);
            end
            
                if(best_new_merit(variable,1)>0)  %need this to avoid an indexing error when no new_best_variable has been found yet
                    %if((best_new_merit(variable,1)>current_best_metric_value)||(best_new_merit(variable,1)==current_best_metric_value && get_c_strcmp(tree(here).variables(variable).variable_key,tree(here).variables(current_new_best_variable).variable_key) < 0))
                    if((best_new_merit(variable,1)>current_new_best_merit)||((best_new_merit(variable,1)==current_new_best_merit) && (get_c_strcmp(tree(here).variables(variable).variable_key,tree(here).variables(current_new_best_variable).variable_key) < 0)))
                        current_new_best_variable = variable;
                        %current_best_metric_value = best_new_merit(variable,1);
                        current_best_metric_value = best_new_val(variable,1);
                        current_new_best_merit = best_new_merit(variable,1);
                        best_new_metric_value_ix = best_metric_value_ix(variable,1);
                    end
                end
                    
                
end   
        

best_metric_value = current_best_metric_value;
new_best_variable = current_new_best_variable;
new_best_merit = current_new_best_merit;

