function result = check_numeric(input)
%checks if the input string is a number
%author: J. Brooks Zurn

try str2num(input);
    result = 1;
catch
    result = 0;
end
