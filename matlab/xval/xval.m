function xval(dataset,n_xval,dir_location)
%run cross-validation 
%author: J. Brooks Zurn
%inputs:
%dataset: string, name of dataset 
%n_xval: number of crossvalidations in folder
%dir_location: location of crossvalidation files
%outputs: none

% n_xval = 10;
% dataset = 'robot';
% dir_location = 'C:\Users\Brooks\Documents\MATLAB\robot\';


%filestem = sprintf('%s%s',dir_location,dataset);
filestem = dir_location;
%names_name = sprintf('names.%s','original');
%names_name = strcat('names.',);
%names_name = 'names_noit';
num_digits = get_num_digits(n_xval);

% train_fname = 'robot_xval_01';
% test_fname = 'robot_xval_01';


for i=1:n_xval
    train_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));
    test_fname = sprintf('%s_xval_%s',dataset,num2str_leading_zeros(i,num_digits,0));

%tree_original = iti(filestem,'names_name',names_name,'l',train_fname,'f','q',test_fname,'T',train_fname,'G');
%tree_original = iti(filestem,'names_name',names_name,'load_mat_train_fast',train_fname,'load_mat_test_set',train_fname,'G');
%tree_original = iti(filestem,'load_mat_train_fast',train_fname,'load_mat_test_set',test_fname,'T',test_fname,'G');
tree_original = iti(filestem,'load_mat_train_fast',train_fname,'load_mat_test_set',test_fname,'T',test_fname);
save(train_fname,'tree_original','-append');
%save train_fname tree_original -append
end