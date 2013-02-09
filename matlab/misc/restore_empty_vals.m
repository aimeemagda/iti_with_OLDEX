function temp_cell = restore_empty_vals(tags)
%restores empty values in cell array
%author: J. Brooks Zurn

[rows cols] = size(tags);

%temp_cell

if(rows&&cols)
    for i=1:cols
        for j=1:rows
            if(~tags(j,i))
                temp_cell{j,i}=[];
            else
                temp_cell{j,i}=tags(j,i);
            end
            
        end
    end
else
    temp_cell = cell(rows,cols); %return an empty cell of the original dims
end