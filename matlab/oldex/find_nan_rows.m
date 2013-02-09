function nan_rows = find_nan_rows(zip_train_data)
%find rows containing NaNs in dataset. NOTE: doesn't say which col has NaN.
%author: J. Brooks Zurn
%inputs:
%zip_train_data: complete data set
%outputs: 
%nan_rows: logical array indicating each row (instance) has (1) or doesn't
%have (0) any NaNs.  

[instances attributes] = size(zip_train_data);
temp_nan_rows = zeros(instances,1);

for i=1:instances
    %check row for NaN
    temp_nan_rows(i,1) = sum(isnan(zip_train_data(i,:)));
end

nan_rows = logical(temp_nan_rows);
    