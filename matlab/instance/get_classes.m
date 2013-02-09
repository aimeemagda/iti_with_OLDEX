function classes = get_classes(input)
%process class line from names file format and separate the classes,
%removing the trailing period and spaces. Return lexically sorted list.
%input: a string of characters
%output: lexically sorted cell array of strings, each containing a class name.

temp1= regexp(input,',','split');
[dummy temp1_num_classes] = size(temp1);

for j=1:temp1_num_classes
    temp2 =  regexp(temp1{j},'\.','split');
    classes{j} = temp2{1,1};
end

%classes = sort(classes); %sort the classes lexically because ITI does.
                         %this helps maintain consistent displays with ITI.
