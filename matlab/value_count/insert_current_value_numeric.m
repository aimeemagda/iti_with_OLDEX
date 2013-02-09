function tree = insert_current_value_numeric(tree,here,variable,current_value,current_class)
%insert current numerical value into the list of class count values, and
%update the class counts
%author: J. Brooks Zurn
global n_classes
global current_inst_tag 

VERBOSE = 0;
SUPER_VERBOSE = 0;
if(VERBOSE) fprintf('(insert_current_value_numeric) inserting a new numeric value for inst %d (here=%d,var=%d)\n',current_inst_tag,here,variable);end

%[dummy n_classes] = size(tree(here).class_counts);
[dummy2 num_values] = size(tree(here).variables(variable).numeric_value_counts);

%find the class number of the current class
class_num_row = 0;
for i=1:n_classes
    if(strcmpi(current_class,tree(here).class_counts(i).key))
        class_num_row = i;
    end
end

if(num_values >0)
    if(SUPER_VERBOSE) fprintf('(insert_current_value_numeric) num_values>0 \n'); end
%extract cell array into numerical matrix
    numeric_list = cell2mat(tree(here).variables(variable).numeric_value_counts);
    temp = tree(here).variables(variable).class_counts;
    
    try   %error-check for empty class count cell arrays
        numeric_list_counts = cell2mat(tree(here).variables(variable).class_counts);
    catch
        [numeric_list_rows numeric_list_cols]=size(tree(here).variables(variable).class_counts);
        numeric_list_counts = zeros(numeric_list_rows,numeric_list_cols);
        for current_row = 1:numeric_list_rows
            for current_col = 1:numeric_list_cols
                if(array_is_empty(tree(here).variables(variable).class_counts{current_row,current_col}))
                    numeric_list_counts(current_row,current_col)=0;
                    tree(here).variables(variable).class_counts{current_row,current_col}=0;
                else
                    numeric_list_counts(current_row,current_col)=tree(here).variables(variable).class_counts{current_row,current_col};
                end
            end
        end
        
    end

    %insert current_value into array
    [dummy num_vals2]=size(numeric_list);
    current_location = 0;
    for i=1:num_vals2
        if(current_value>numeric_list(1,i))
            current_location = i;
        end
    end
    
    %create a new column for this value, count for current class = 1
    temp_count = zeros(n_classes,1);
    temp_count(class_num_row,1) = 1;
    
    %create a new column for tags, initialize tag array if necessary
    for i=1:n_classes
        temp_tag{i,1}=[];
    end
    temp_tag{class_num_row,1}=current_inst_tag; 
    
    [temp_tag_rows dummy] = size(tree(here).variables(variable).class_counts_tags);
    if(temp_tag_rows < n_classes)
        if(SUPER_VERBOSE) fprintf('(insert_current_value_numeric) temp_tag_rows < n_classes\n'); end
        for i=temp_tag_rows:n_classes
            tree(here).variables(variable).class_counts_tags{i,1}=[];
        end
    end
    

    if(~current_location) %it's at beginning
        if(VERBOSE) fprintf('(insert_current_value_numeric) it''s at beginning\n'); end
        numeric_list = cat(2,current_value,numeric_list);
        numeric_list_counts = cat(2,temp_count,numeric_list_counts);
        tree(here).variables(variable).class_counts_tags = cat(2,temp_tag,tree(here).variables(variable).class_counts_tags);
        
    elseif(current_location == num_vals2) %if it's at end
        if(VERBOSE) fprintf('(insert_current_value_numeric) it''s at end\n'); end
        numeric_list = cat(2,numeric_list,current_value);
        numeric_list_counts = cat(2,numeric_list_counts,temp_count);
        tree(here).variables(variable).class_counts_tags = cat(2,tree(here).variables(variable).class_counts_tags,temp_tag);

    else %it's in the middle
        if(VERBOSE) fprintf('(insert_current_value_numeric) it''s in the middle\n'); end
        %list of values
        split1 = numeric_list(1:current_location);
        split2 = numeric_list((current_location + 1):num_vals2);
        temp_numeric = cat(2,split1,current_value);
        numeric_list = cat(2,temp_numeric,split2);
        
        %counts for each value, with respect to class
        temp_list_counts = cat(2,numeric_list_counts(:,1:current_location),temp_count);
        numeric_list_counts = cat(2,temp_list_counts,numeric_list_counts(:,(current_location+1):num_vals2));
        
        %instance tags for each value count, with respect to class
        %temp_tag
        %tree(here).variables(variable).class_counts_tags

        for i=1:n_classes
            for j=1:current_location
                split_tag1{i,j} = tree(here).variables(variable).class_counts_tags{i,j};
            end
        end
        for i=1:n_classes
            for j=(current_location + 1):num_vals2
                split_tag2{i,j-current_location} = tree(here).variables(variable).class_counts_tags{i,j};
            end
        end
        %split_tag1
        %split_tag2
        temp_tags = cat(2,split_tag1,temp_tag);
        %temp2=tree(here).variables(variable).class_counts_tags;
        tree(here).variables(variable).class_counts_tags = cat(2,temp_tags,split_tag2);
        %temp3=tree(here).variables(variable).class_counts_tags;
    end
    
    
    %new_numeric_list1=cat(2,,current_value);
    %numeric_list = cat(2,new_numeric_list1,find(current_value<numeric_list));

   

else %this is the first value in the list
    if(SUPER_VERBOSE) fprintf('(insert_current_value_numeric) num_values == 0 !! \n'); end
    numeric_list = current_value;
    numeric_list_counts = zeros(n_classes,1);
    
    
    for i=1:n_classes
        %temp_tag{i,1}=[];
        tree(here).variables(variable).class_counts_tags{i,1}=[];
        
        if(i==class_num_row)
            numeric_list_counts(i,1) = 1; 
        else
            numeric_list_counts(i,1) = 0;
        end
    end
    tree(here).variables(variable).class_counts_tags{class_num_row,1}=current_inst_tag;
    %temp_tag{class_num_row,1}=current_inst_tag; 
    %tree(here).variables(variable).class_counts_tags{class_num_row,1}=current_inst_tag;
    %tree(here).variables(variable).class_counts_tags{class_num_row,1}=temp_tag;
    
end

%put numeric_list back into cell and into tree
tree(here).variables(variable).numeric_value_counts = num2cell(numeric_list);
%put class counts back into cell and into tree
tree(here).variables(variable).class_counts = num2cell(numeric_list_counts);


%fprintf('tree(here).variables(variable).numeric_value_counts=');tree(here).variables(variable).numeric_value_counts
%fprintf('tree(here).variables(variable).class_counts ='); tree(here).variables(variable).class_counts
%fprintf('tree(here).variables(variable).class_counts_tags=');tree(here).variables(variable).class_counts_tags




