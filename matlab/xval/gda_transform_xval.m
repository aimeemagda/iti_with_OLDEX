function gda_transform_xval(dataset,arg,n_xval,dir_location,kernel_type)
%use kernel gda to transform pre-existing cross-validation data sets
%author: J. Brooks Zurn
%inputs:
%dataset: string, name of dataset 
%n_xval: number of crossvalidations in folder
%dir_location: location of crossvalidation files
%outputs: none

filestem = dir_location;
%names_name = sprintf('names.%s','original');
%names_name = strcat('names.',);
%names_name = 'names_noit';
num_digits = get_num_digits(n_xval);

% train_fname = 'robot_xval_01';
% test_fname = 'robot_xval_01';

fprintf('\n');
for i=1:n_xval
    fprintf('Processing xval=%d\n',i);
    train_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));
    test_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));
    
    load(train_fname,'zip_train_data','zip_train_classes','zip_test_data','zip_test_classes');
    %convert classes to a numeric list so GDA can handle it
    [zip_train_classes_numeric zip_train_classes_numeric_key] = get_numeric_classes(zip_train_classes);
    in_data.X = zip_train_data';
    in_data.y = zip_train_classes_numeric';
    in_data.name = dataset;
    model_data = gda(in_data,struct('ker',kernel_type,'arg',arg));
    out_data = kernelproj( in_data, model_data );
    %figure; ppatterns( out_data );
    zip_train_data = out_data.X';
    
    [zip_test_classes_numeric zip_test_classes_numeric_key] = get_numeric_classes(zip_test_classes);
    in_data.X = zip_test_data';
    in_data.y = zip_test_classes_numeric';
    in_data.name = dataset;
    %model_data = gda(in_data,struct('ker','rbf','arg',arg));
    out_data = kernelproj( in_data, model_data );
    %figure; ppatterns( out_data );
    zip_test_data = out_data.X';

    gda_fname = sprintf('%s_%s_xval_%s',dataset,kernel_type,num2str_leading_zeros(i,num_digits,0));
    save(gda_fname, 'zip_train_data','zip_test_data','zip_train_classes','zip_test_classes');
    % tree_original = iti(filestem,'load_mat_train_fast',train_fname,'load_mat_test_set',test_fname,'T',test_fname,'G');
    % save(train_fname,'tree_original','-append');
end