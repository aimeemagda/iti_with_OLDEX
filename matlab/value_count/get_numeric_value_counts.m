function tree = get_numeric_value_counts(tree,here,variable,this_inst,current_inst_num)
%fill the array of numeric value counts for each value
%author: J. Brooks Zurn
%

%numeric_value_counts is an [n,m] array.
%rows are for each class
%columns indicate cutpoints
%each entry is cumulative count <= this cutpoint for this class
%
VERBOSE = 0;
SUPER_VERBOSE = 0;
global current_inst_tag


%[dummy num_classes] = size(tree(here).class_counts);

if(VERBOSE) fprintf('(get_numeric_value_counts) entering function \n'); end
%for i=1:num_classes
    
    %the sorted classnames are in tree(here).class_counts(i).key
    %if(strcmpi(this_inst.classname,tree(here).class_counts(i).key))
        current_class = this_inst.classname;
        current_value = this_inst.val;
        
        %find current_value in the numeric value count list
        %if it's not there, insert it
        matrix_of_values = cell2mat(tree(here).variables(variable).numeric_value_counts);
        %matrix_of_values = tree(here).variables(variable).numeric_value_counts;
        [tempsize1 tempsize2] = size(matrix_of_values);
        %if(matrix_of_values)
        if(tempsize1&&tempsize2)
            if(find(current_value == matrix_of_values))
                %found = find(current_value == matrix_of_values);
                found = 1;
            else
                found = 0;
            end
        else
            found = 0;
        end
        if(SUPER_VERBOSE) fprintf('(get_numeric_value_counts) found=%d \n',found); end
        
        %tree(here).variables(variable).numeric_value_counts
        %current_value
        %matrix_of_values
        %found
        %if((here == 1)&&(current_inst_num==1))
        %    tree = insert_current_value_numeric(tree,here,variable,current_value,current_class);
        %else
            if(~found)
                if(SUPER_VERBOSE) fprintf('(get_numeric_value_counts)insert_current_value_numeric\n');end
                tree = insert_current_value_numeric(tree,here,variable,current_value,current_class);
            else
                if(SUPER_VERBOSE) fprintf('(get_numeric_value_counts)update_current_value_numeric\n');end
                tree = update_current_value_numeric(tree,here,variable,current_value,current_class);
            end
        %end
        %tree(here).variables(variable).numeric_value_counts
        %found
        %insert current_value into numeric value count array
        %increment class counts <= current_value
        
        %tree(here).variables(variable).numeric_value_counts{} = tree(here).variables(j).numeric_value_counts + 1;
    %end
%end
    