function run_xvals_gda_randomized(dataset,n_xval,root_dir,kernel_type,arg)
%create crossvalidation sets

% dataset = 'robot_onebadwrist';
% n_xval = 10;

% root_dir = 'C:\Users\Brooks\Documents\MATLAB\robot\';
filename = strcat(root_dir,dataset);
filename_kernel = strcat(root_dir,dataset,'_',kernel_type);

% load(filename,'zip_train_data','zip_train_classes');
% dir_location = strcat(root_dir,'/',dataset);
dir_location = strcat(root_dir,'/',dataset);

if(~exist(dir_location,'dir'))
    mkdir(dir_location)
    %if the directory doesn't exist, sval data probably doesn't either
end
    load(filename,'zip_train_data','zip_train_classes');
    [n_instances n_attributes] = size(zip_train_data);
    rand_list = rand(n_instances,1);
    [dummy rand_ix] = sort(rand_list);
    rand_train_data = zip_train_data(rand_ix,:);
    rand_train_classes = zip_train_classes(rand_ix,1);
    
    split_xval_groups(rand_train_data,rand_train_classes,n_xval,dataset);

%%%split_xval_groups(zip_train_data,zip_train_classes,n_xval,dataset);
%they will all be split the same since its not randomized

%transform all the datasets into kernel feature space
gda_transform_xval(dataset,arg,n_xval,dir_location,kernel_type);

%now call xval
gda_dataset = strcat(dataset,'_',kernel_type);

%%xval(dataset,n_xval,dir_location);
xval(gda_dataset,n_xval,filename);




%test crossvalidation sets


