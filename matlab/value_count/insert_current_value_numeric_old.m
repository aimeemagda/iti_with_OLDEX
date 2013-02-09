function tree = insert_current_value_numeric(tree,here,variable,current_value,current_class)
%insert current numerical value into the list of class count values, and
%update the class counts
%author: J. Brooks Zurn

[dummy num_classes] = size(tree(here).class_counts);
[dummy2 num_values] = size(tree(here).variables(variable).numeric_value_counts);

%find the class number of the current class
class_num_row = 0;
for i=1:num_classes
    if(strcmpi(current_class,tree(here).class_counts(i).key))
        class_num_row = i;
    end
end

if(num_values >0)
%extract cell array into numerical matrix
    numeric_list = cell2mat(tree(here).variables(variable).numeric_value_counts);
    numeric_list_counts = cell2mat(tree(here).variables(variable).class_counts);

    %insert current_value into array
    found_greater = find(current_value>numeric_list);
    if(found_greater) %if index > 0
        if(found_greater(1,1)>1)
            numeric_list_1 = cat(2,numeric_list(1:found_greater(1,1)-1),current_value);
            numeric_list = cat(2,numeric_list_1,numeric_list(found_greater(1,1):num_values));
        else
            numeric_list_1 = cat(2,numeric_list(1,1),current_value);
            numeric_list = cat(2,numeric_list_1,numeric_list(2:num_values));
        end
    else
        numeric_list = cat(2,current_value,numeric_list);
    end
    
    %new_numeric_list1=cat(2,,current_value);
    %numeric_list = cat(2,new_numeric_list1,find(current_value<numeric_list));

    %figure out where current value is
    found = find(current_value == numeric_list);

    %resize class counts list
    %insert a place at the location of the current value
    if(num_values > 1)
        numeric_list_counts1 = numeric_list_counts(:,1:(found-1));
        numeric_list_counts2 = cat(2,numeric_list_counts1,zeros(num_classes,1));
        numeric_list_counts = cat(2,numeric_list_counts2,numeric_list_counts(:,found:num_values));
    else
        %there are only two values, which is first?
        if(current_value == numeric_list(1,1)) %if the new value is first
            numeric_list_counts = cat(2,zeros(num_classes,1),numeric_list_counts);
        else %otherwise it's second
            numeric_list_counts = cat(2,numeric_list_counts,zeros(num_classes,1));
        end
            
    end

    %update the count of the (newly inserted) current value
    numeric_list_counts(class_num_row,found) = 1; %1 since we're only looking at one new value

else %this is the first value in the list
    numeric_list = current_value;
    numeric_list_counts(class_num_row,1) = 1; 
    
end

%put numeric_list back into cell and into tree
tree(here).variables(variable).numeric_value_counts = num2cell(numeric_list);
%put class counts back into cell and into tree
tree(here).variables(variable).class_counts = num2cell(numeric_list_counts);




