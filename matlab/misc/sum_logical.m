function result = sum_logical(input)
%convert a logical array to numerical and sum it
%author: J. Brooks Zurn

[rows cols] = size(input);
%temp = zeros(rows,cols);
result = 0;

for i=1:rows
    for j=1:cols
        if(input(i,j))
            result = result + 1;
        end
    end
end

            
