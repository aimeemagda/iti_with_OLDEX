function [last_val,less_ccs,best_val,best_merit,tree,best_val_ix] = set_merit_by_ks_distance_numeric(tree,here,variable,last_val,less_ccs)
%* For each cutpoint, evaluate the merit_by_ks_distance that would result from
%* splitting on the boolean variable (var < cutpoint).
%* author: Paul Utgoff
%modified by J. Brooks Zurn

%accessed in this function:
%variable *v, int this_var, value_count_node *nd,
%value_count_node **last_val, class_count_node **less_ccs)
%DEBUG_MERIT = 0;
global DEBUG_MERIT
PRECISION = 100000; %precision is limited to 6 digits
global n_classes
global current_inst_tag

global tree_class_counts
% global tree_class_counts_tags
global tree_numeric_value_counts

best_val = 0;
best_merit = 0;

best_val_ix = 0;

%last_val = 0;
%less_ccs = 0;
%less_ccs = zeros(n_classes,1);
%  /* do an in-order traversal of the value tree */  <-------------------
%  /* take care of numeric values in left subtree */ <-------------------
%skip this because this version doesn't use a value tree, it examines
%the whole set

%if (*last_val && nd->key.numeric != ITI_INFINITY && different_class_sets(*last_val,nd))
%    /* compute merit_by_ks_distance */
if(DEBUG_MERIT)
    fprintf('\nClass counts for variable %s\n',tree(here).variables(variable).variable_key);
    for i=1:n_classes
        fprintf('(%s %d)',tree(here).class_counts(i).key,tree(here).class_counts(i).count);
    end
    fprintf('\n');
end


%fprintf('set_merit_by_ks_distance_numeric');
%figure out number of values
%[n_classes n_values] = size(tree(here).variables(variable).class_counts);
[n_classes n_values] = size(tree_class_counts(here).variables(variable).class_counts);

value_metric_values = zeros(1,n_values);

%get a list of cumulative sums
%n_greater_this_class = cell2mat(tree(here).variables(variable).class_counts);
%n_this_class = cumsum(n_greater_this_class,2); %cumulative total
%n_less_this_class = zeros(n_classes,n_values);
% n_greater = cell2mat(tree(here).variables(variable).class_counts);
% n_total = cumsum(n_greater,2); %cumulative total
% n_less = zeros(n_classes,n_values);
%
% for value_num=1:n_values
%     %n_this_class = n_total(:,value_num);
%     if(value_num > 1)
%         %n_less(:,value_num) = n_total(:,value_num-1) + 0.5;
%         n_less(:,value_num) = n_total(:,value_num-1);
%     end
% end


n_total_iti = zeros(n_classes,1); %TOTAL CLASS COUNTS
n_less_iti = zeros(n_classes,1);  %CLASS COUNTS EQUAL TO THE SPLIT VAL
n_greater_iti = zeros(n_classes,1); %CLASS COUNTS OUTSIDE THE SPLIT VAL

%temp_val_counts = cell2mat(tree(here).variables(variable).class_counts);
temp_val_counts = cell2mat(tree_class_counts(here).variables(variable).class_counts);

%if(~array_is_empty(tree(here).variables(variable).numeric_value_counts))
if(~array_is_empty(tree_numeric_value_counts(here).variables(variable).numeric_value_counts))

    for j=1:n_values
        
        
        %if more than one value, and different classes between this and
        %last value
        if(last_val&&(j>1)&&(different_class_sets(tree,here,variable,last_val,j)))
            for i=1:n_classes
                n_total_iti(i,1) = tree(here).class_counts(i).count;
                %n_less_iti(i,1) = tree(here).variables(variable).class_counts{i,j};
                n_less_iti(i,1) = tree_class_counts(here).variables(variable).class_counts{i,j};
                n_greater_iti(i,1) = n_total_iti(i,1)-n_less_iti(i,1);
                
                if(DEBUG_MERIT)
                    fprintf('  %s: less :%0.0f, greater %0.0f, total %0.0f\n',tree(here).class_counts(i).key,(n_less_iti(i,1)),n_greater_iti(i,1),n_total_iti(i,1));
                end %end DEBUG_MERIT
                
                %n_less_iti(i,1) = 0.5 + less_ccs(i,1); %n_less_this_class
                %was int, so the 0.5 served
                %to round up for truncating.
                
                n_less_iti(i,1) = sum(temp_val_counts(i,1:(j-1)));
                
                
                
            end
            
            
            %%%%%%
            dist_temp = ks_distance_of_counts(n_less_iti,n_greater_iti,n_total_iti,variable,j);
            dist = round(dist_temp*PRECISION);  %truncate to PRECISION number of digits
            
            tree(here).variables(variable).metric_value;
            if(dist>best_merit)
                
                best_merit = dist;
                best_val_ix = j;
            end
            
            %%%%%%%%%%%%new
        end %end if(lastval&&j>1&&different_class_sets
        last_val = j;
        
        for i=1:n_classes
            %less_ccs(i,1) = less_ccs(i,1) + tree(here).variables(variable).class_counts{i,j};
            less_ccs(i,1) = less_ccs(i,1) + tree_class_counts(here).variables(variable).class_counts{i,j};
        end
        
    end %end cycling through values
    %%%%%%%%%%%%end new
    
    if(best_val_ix>1)
        if(array_is_empty(tree(here).variables(variable).metric_value))
            
            tree(here).variables(variable).metric_value{1}=best_merit;
%             lower_val = tree(here).variables(variable).numeric_value_counts{best_val_ix-1};
%             higher_val = tree(here).variables(variable).numeric_value_counts{best_val_ix};
            lower_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix-1};
            higher_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix};
            difference = ((higher_val - lower_val)/2) + lower_val;
            tree(here).variables(variable).new_cutpoint{1} = difference;
            
            best_val = difference;
            
            %tree(here).variables(variable).new_cutpoint{1}=((tree(here).variables(variable).numeric_value_counts{j}-tree(here).variables(variable).numeric_value_counts{last_val})/2)+tree(here).variables(variable).numeric_value_counts{last_val};
        elseif(iscell(tree(here).variables(variable).metric_value))
            tree(here).variables(variable).metric_value{1}=best_merit;
%             lower_val = tree(here).variables(variable).numeric_value_counts{best_val_ix-1};
%             higher_val = tree(here).variables(variable).numeric_value_counts{best_val_ix};
            lower_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix-1};
            higher_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix};
            difference = ((higher_val - lower_val)/2) + lower_val;
            tree(here).variables(variable).new_cutpoint{1} = difference;
            
            best_val = difference;
            
        else %assume it's numeric.
            tree(here).variables(variable).metric_value=num2cell(best_merit);
%             lower_val = tree(here).variables(variable).numeric_value_counts{best_val_ix-1};
%             higher_val = tree(here).variables(variable).numeric_value_counts{best_val_ix};
            lower_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix-1};
            higher_val = tree_numeric_value_counts(here).variables(variable).numeric_value_counts{best_val_ix};
            difference = ((higher_val - lower_val)/2) + lower_val;
            tree(here).variables(variable).new_cutpoint{1} = difference;
            
        end
        
    else %didn't find a best_val_ix for some reason (maybe numeric_value_counts == {1x1}), but need to set output anyway 
        
        if(iscell(tree(here).variables(variable).metric_value))
            tree(here).variables(variable).metric_value{1} = 0;
        else
            tree(here).variables(variable).metric_value = num2cell(0);
        end
        
        tree(here).variables(variable).new_cutpoint = [];
        
        
        
    end %end if(best_val_ix > 1)
    
    
end %end if numeric_value_counts is not empty


