function array_isempty = array_is_empty(myarray)
%figures out if an array is empty

[temp1 temp2] = size(myarray);

if(temp1)
    array_isempty = 0;
elseif(temp2)
    array_isempty = 0;
else
    array_isempty = 1;
end

