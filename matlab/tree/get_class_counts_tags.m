function class_counts_tags = get_class_counts_tags(tags,list)

%here=56;
%variable=1;
%tags=tree(here).variables(variable).class_counts_tags;
%list=asdf_leftlist;
%list=asdf_rightlist;

[rows cols]=size(tags);

% for i=1:rows
%     for j=1:cols
%         class_counts_tags{i,j}=[];
%     end
% end
class_counts_tags = cell(rows,cols); %note: if rows||cols ==0, this inits
                                     %    a 0-dimensional array on rows||cols!    
if(rows&&cols)
   
    %tags = fix_empty_vals(tags);
    
    list_collapsed = collapse_class_list(list);
    list_mat = cell2mat(list_collapsed);
    
    for this_col=1:cols
        for this_row=1:rows
            this_field = tags{this_row,this_col};
            membership = ismember(this_field,list_mat);
            
            if(sum_logical(membership)) %if any members of the field are in the list
                class_counts_tags{this_row,this_col}=this_field(membership);
            %else
                %class_counts_tags{this_row,this_col}=[];
            end
                
            %class_counts(this_row,this_col)=sum_logical(membership);
        end
    end
     
    %logical_array = logical(tags_counts);
            
%else
    %logical_array = 0;
end
