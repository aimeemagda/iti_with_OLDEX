function run_xvals_gda(dataset,n_xval,root_dir,kernel_type)
%create crossvalidation sets

% dataset = 'robot_onebadwrist';
% n_xval = 10;
% root_dir = 'C:\Users\Brooks\Documents\MATLAB\robot\';
filename = strcat(root_dir,dataset);
% load(filename,'zip_train_data','zip_train_classes');
% dir_location = strcat(root_dir,'/',dataset);
dir_location = strcat(root_dir,'/',dataset);

if(~exist(dir_location,'dir'))
    mkdir(dir_location)
    load(filename,'zip_train_data','zip_train_classes');
    %if the directory doesn't exist, sval data probably doesn't either
    split_xval_groups(zip_train_data,zip_train_classes,n_xval,dataset);
end

%%%split_xval_groups(zip_train_data,zip_train_classes,n_xval,dataset);
%they will all be split the same since its not randomized

%transform all the datasets into kernel feature space
gda_transform_xval(dataset,n_xval,dir_location);

%now call xval
gda_dataset = strcat(dataset,'_',kernel_type);

%%xval(dataset,n_xval,dir_location);
xval(gda_dataset,n_xval,filename);




%test crossvalidation sets


