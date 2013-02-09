function myfixedstring = convert_whitespace_to_underscore(mystring)
%replaces mid-string whitespace with underscores
%author: J. Brooks Zurn
%input: 
%mystring
%output:
%myfixedstring

%mystring = 'this is a test';
temp = regexp(mystring,' ','split');
[dummy num_spaces] = size(temp);

myfixedstring = '';
for i=1:(num_spaces-1)
    temp2=sprintf('%s_',temp{1,i});
    myfixedstring = strcat(myfixedstring,temp2);
end
myfixedstring = strcat(myfixedstring,temp{1,num_spaces});

