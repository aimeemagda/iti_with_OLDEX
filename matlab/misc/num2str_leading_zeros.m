function mystring = num2str_leading_zeros(num,num_digits,num_decimal_places)
%convert a number to a string with appropriate # of leading zeros
%numbers after decimal point are rounded to num_decimal_places
%if num_digits is smaller than number of digits > 0, the original number is
%used
%author: J. Brooks Zurn
%inputs:
%num:number to convert
%num_digits: the number of digits
%num_decimal_places: maximum number of decimal places
%outputs: string with appropriate number of leading zeros padded

%how many leading zeros are needed?

[dummy length]=size(num2str(round(num)));

%get string

%get part > 0
temp_num = floor(abs(num));
temp_string = num2str(temp_num);

%get part < 0
if(num_decimal_places>0)
    temp_decimal_part = (abs(num)-temp_num)*10^(num_decimal_places);
    temp_decimal = num2str(floor(abs(temp_decimal_part)));
    temp_string = strcat(temp_string,'-',temp_decimal);
end

%pad with leading zeros
if (length<num_digits)
    num_zeros = num_digits - length;
    
    for i=1:num_zeros
        temp_string = strcat('0',temp_string);
    end
end

mystring = temp_string;
