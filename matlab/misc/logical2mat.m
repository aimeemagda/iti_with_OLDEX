function matrix = logical2mat(array)
%convert a 2D logical array to numerical values
%author: J. Brooks Zurn

if(islogical(array))
    [rows cols] = size(array);
    if(rows&&cols)
        matrix = zeros(rows,cols);
        for i=1:rows
            for j=1:cols
                if(array(i,j))
                    matrix(i,j)=1;
                end
            end
        end
    else
        fprintf('(logical2mat) warning: empty logical matrix, returning 0\n');
        matrix=0;
    end
end
