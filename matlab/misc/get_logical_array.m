function logical_array = get_logical_array(tags,list)

%here=56;
%variable=1;
%tags=tree(here).variables(variable).class_counts_tags;
%list=asdf_leftlist;
%list=asdf_rightlist;

[rows cols]=size(tags);

tags_counts = zeros(rows,cols);
if(rows&&cols)
   
    tags = fix_empty_vals(tags);
    
    list_collapsed = collapse_class_list(list);
    list_mat = cell2mat(list_collapsed);
    
    for this_col=1:cols
        for this_row=1:rows
            this_field = tags{this_row,this_col};
            membership = ismember(this_field,list_mat);
            tags_counts(this_row,this_col)=sum_logical(membership);
        end
    end
            
            
    tags_mat=cell2mat(tags);
    
    %list=fix_empty_vals(list);
    
    
    
    logical_array = ismember(tags_mat,list_mat);
else
    logical_array = 0;
end
