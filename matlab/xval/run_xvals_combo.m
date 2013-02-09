function run_xvals_combo(dataset,n_xval,root_dir,kernel_type)
%concatenate kernel attributes onto data, test xvals
%J. Brooks Zurn

%dir_location = strcat(root_dir,'/',dataset);
dir_location = strcat(root_dir,dataset);

if(~exist(dir_location,'dir'))
    mkdir(dir_location)
%     load(filename,'zip_train_data','zip_train_classes');
%     %if the directory doesn't exist, sval data probably doesn't either
%     split_xval_groups(zip_train_data,zip_train_classes,n_xval,dataset);
end

%filestem = dir_location;
%filestem = root_dir;
num_digits = get_num_digits(n_xval);

for i=1:n_xval
    original_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));
    kernel_fname = sprintf('%s_%s_xval_%s',dataset,kernel_type,num2str_leading_zeros(i,num_digits,0));
    %kernel_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));
    combo_fname = sprintf('%s_%s_combo_xval_%s',dataset,kernel_type,num2str_leading_zeros(i,num_digits,0));

    load(original_fname,'zip_train_data','zip_test_data');
    temp = zip_train_data;
    temp2= zip_test_data;
    
    load(kernel_fname,'zip_train_data','zip_test_data','zip_train_classes','zip_test_classes');
    zip_train_data = horzcat(temp,zip_train_data);
    zip_test_data = horzcat(temp2,zip_test_data);

    save(combo_fname,'zip_train_data','zip_test_data','zip_train_classes','zip_test_classes');
end

%now call xval
combo_dataset = strcat(dataset,'_',kernel_type,'_combo');

combo_filename = strcat(root_dir,combo_dataset);

%run the cross-validations
xval(combo_dataset,n_xval,combo_filename);




%test crossvalidation sets


