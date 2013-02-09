function output = modulo(input,divisor)
%this function computes the modulo of a number


dividend = input/divisor;

wholenum = floor(dividend);

remainder = dividend - wholenum;

output = remainder*divisor;

return;

