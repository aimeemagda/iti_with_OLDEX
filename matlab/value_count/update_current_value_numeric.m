function tree = update_current_value_numeric(tree,here,variable,current_value,current_class)
%update class counts for numerical values
%author: J. Brooks Zurn
%tree(here).variables(variable).numeric_value_counts
global n_classes
global current_inst_tag

VERBOSE = 0;
empty_count = 0;

%find the class number of the current class
class_num_row = 0;
for i=1:n_classes
    if(strcmpi(current_class,tree(here).class_counts(i).key))
        class_num_row = i;
    end
end

%find the column corresponding to the variable's value for the current inst
numeric_list = cell2mat(tree(here).variables(variable).numeric_value_counts);

[found_current_value current_value_location] = ismember(current_value,numeric_list);



if(iscell(tree(here).variables(variable).class_counts))
    %numeric_list_counts = cell2mat(tree(here).variables(variable).class_counts);
    
%     try   %error-check for empty class count cell arrays
         numeric_list_counts = cell2mat(tree(here).variables(variable).class_counts);
%     catch
%         fprintf('(update_current_value_numeric) warning: empty class_count row\n');
%         empty_count = 1;
%         [numeric_list_rows numeric_list_cols]=size(tree(here).variables(variable).class_counts);
%         numeric_list_counts = zeros(numeric_list_rows,numeric_list_cols);
%         for current_row = 1:numeric_list_rows
%             for current_col = 1:numeric_list_cols
%                 if(array_is_empty(tree(here).variables(variable).class_counts{current_row,current_col}))
%                     numeric_list_counts(current_row,current_col)=0;
%                     tree(here).variables(variable).class_counts{current_row,current_col} = 0;
%                 else
%                     numeric_list_counts(current_row,current_col)=tree(here).variables(variable).class_counts{current_row,current_col};
%                 end
%             end
%         end
%         
%     end
else
    numeric_list_counts = tree(here).variables(variable).class_counts;
end

try
    array_is_empty(tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location});
catch
    empty_count=1;
end

%current_value_location = find(current_value==numeric_list);


%class_num_row = 0;
for i=1:n_classes
    if(strcmpi(current_class,tree(here).class_counts(i).key))
        class_num_row = i;
    end
end

%increment the counts of this class and variable value
numeric_list_counts(class_num_row,current_value_location) = numeric_list_counts(class_num_row,current_value_location) + 1;

%store the incremented count
tree(here).variables(variable).class_counts = num2cell(numeric_list_counts);

if(VERBOSE) fprintf('(update_current_value_numeric) updating counts and tags\n'); end
%record the tag for the count value (for later use in tree restructuring)
%if(iscell(tree(here).variables(variable).class_counts_tags))
if(empty_count)
    tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location} = current_inst_tag;
else
    if(~array_is_empty(tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location}))
        tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location} = horzcat(tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location},current_inst_tag);
    else
        tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location} = current_inst_tag;
    end
end
%else
%    tree(here).variables(variable).class_counts_tags{class_num_row,current_value_location} = current_inst_tag;
%end

