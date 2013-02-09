function tags = fix_empty_vals(tags)
%fixes empty values in cell array
%author: J. Brooks Zurn

[rows cols] = size(tags);

if(rows&&cols)
    for i=1:cols
        for j=1:rows
            if(array_is_empty(tags{j,i}))
                tags{j,i}=0;
            end
        end
    end
end