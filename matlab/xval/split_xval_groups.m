function split_xval_groups(all_data,all_classes,n_groups,data_name)
%create n_groups xval sets and save them to n_groups files
%it creates n_groups of unique, exhaustive train/test sets by counting off.
%author: J. Brooks Zurn
%inputs:
%all_data: complete data set
%all_classes: corresponding classes
%n_groups: number of cross-validation sets to create
%data_name: filename prefix (i.e. 'robot')
%outputs: 

% n_groups = 10;
% data_name = 'robot';
%data = load all_data
%classes = load all_classes

xval = get_xval(all_data,n_groups);
num_digits = get_num_digits(n_groups);

%notes: 2011/08/11: fixed missing '\groupname' for writing out xval .mat files
%extract the group name from the filestem
filestem_split = regexp(data_name,'\','split','freespacing');
[dummy filestem_size] = size(filestem_split);
data_stem = filestem_split{1,filestem_size};

%split the data
for i=1:n_groups
    clear zip_train_data zip_test_data zip_train_classes zip_test_classes
    zip_train_data = all_data(~xval(:,i),:);
    zip_test_data = all_data(xval(:,i),:);
    zip_train_classes = all_classes(~xval(:,i),:);
    zip_test_classes = all_classes(xval(:,i),:);

    xval_tag = num2str_leading_zeros(i,num_digits,0);
    filename = strcat(data_name,'\',data_stem,'_xval_',xval_tag);
    save(filename,'zip_train_data','zip_test_data','zip_train_classes','zip_test_classes');
    
end

fprintf('\n%d xval groups created and stored for dataset %s.\n',n_groups,data_name);