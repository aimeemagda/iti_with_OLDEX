function xval = get_xval(data,n_groups)
%split data into cross-validation groups
%return an array designating which
%author: J. Brooks Zurn
%inputs:
%data: [p x q] array of training data. each row p is an instance. 
%n_groups: number of cross-validation groups
%outputs: [p x n_groups] logical array, each column corresponds to a
%crossvalidation set.  1 == include this row, 0 == exclude this row

% to access xval groups: data1 = data(xval(:,1),:);

[instances attributes] = size(data);

% full_sets = floor(instances/n_groups);
% left_overs = modulo(instances/n_groups);
% 
xval_temp = zeros(instances,n_groups);

xval_numeric = zeros(instances,1);
for i=1:instances
    xval_numeric(i,1) = round(modulo(i,n_groups));
end

for j=1:n_groups
    for i=1:instances
    xval_temp(i,j)=(round(modulo(i,n_groups))==round(j-1));
    end
end

xval = logical(xval_temp);

