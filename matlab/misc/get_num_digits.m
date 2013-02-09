function num_digits = get_num_digits(num)
%get the max number of digits
%author: J. Brooks Zurn
%inputs:
%num: input number
%outputs: maximum number of digits

temp_num = num2str(floor(abs(num)));

[dummy num_digits] = size(temp_num);
