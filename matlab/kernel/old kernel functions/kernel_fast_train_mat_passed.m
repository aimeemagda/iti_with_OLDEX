function tree = kernel_fast_train_mat_passed(kernel_type,kernel_transform_table,kernel_transform_table_ix,tree,train_data,train_classes)
%train tree and kernel-transforms off-line
%author: J. Brooks Zurn
%modified from Paul Utgoff

global total_cpu

begin_cpu = tic;
% tree = quick_load_mat_passed(tree,data,classes);
% tree = get_node_class(tree,1);

%%%%%kernel stuff here
%load train data into tree format, leaving
%space for kernel attributes
tree = kernel_quick_load_mat_passed(kernel_type,kernel_transform_table,kernel_transform_table_ix,tree,train_data,train_classes);

%get kernel transform table using unique
%vals from tree format var
fprintf('filling kernel transform table...');
%kernel_transform_table = fill_kernel_transform_table(kernel_type,kernel_transform_table,kernel_transform_table_ix);

%create kernel transform table from tree and data
%kernel_transform_table = get_kernel_transform_table(kernel_type,data);


%select kernel trans atts to include

%test KS dist? do i need a table to
%store ks dists ?





%%%%% expand tree

tree = split_node_if_impure(tree,1);
tree = ensure_best_variable(tree,1);

total_cpu = toc(begin_cpu);


