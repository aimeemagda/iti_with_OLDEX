function value = get_c_strcmp(string1,string2)
%approximate the <>= operation of the 'c' language function strcmp
%if string1 is lexically lower than string2, return -1
%if string1 > string2, return +1
%if string1 == string2, return 0
%author: J. Brooks Zurn

if(strcmp(string1,string2))
    value=0;
else
    cell1 = {string1};
    cell2 = {string2};
    list = vertcat(cell1,cell2);
    sorted = issorted(list);
    
    if(sorted) %if string1 (the first string in list) is lexically lower
        value = -1;
    else
        value = 1;
    end
end

        
    