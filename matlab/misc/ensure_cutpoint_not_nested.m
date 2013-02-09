function cutpoint_fixed = ensure_cutpoint_not_nested(cutpoint)
%fixes nested cutpoints
    %fprintf('entering cutpoint_fixed\n');

temp = cutpoint;
count = 0;

%cutpoint
while(iscell(temp))
    %clear temp;
    count = count + 1;
    %temp = cell2mat(temp);
    temp = temp{1,1};
end
if(count>0)
    %fprintf('fixed nested cutpoint, nested %d times\n',count);
else
    %fprintf('cutpoint not nested\n',count);
    %cutpoint_fixed = cutpoint;
end

cutpoint_fixed{1,1} = temp;
%cutpoint_fixed




