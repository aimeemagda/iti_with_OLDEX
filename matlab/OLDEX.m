%function [tree_oldex_1,tree_oldex_2] = OLDEX(tree,tree_oldex_1,tree_oldex_2,filename)
function [tree_oldex_1,tree_oldex_2] = OLDEX(filename)

%use OLDEX to fill two different trees with appropriate data
%author: J. Brooks Zurn
%inputs:
%tree1,tree2: pre-initialized but empty trees
%filename: file containing zip_train_data and zip_train_classes
%outputs:
%tree1,tree2: filled and restructured trees

global total_cpu

global n_variables
global n_OLDEX_variables

%globalize the basic tree structures
global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

%globalize the oldex tree structures
global tree_oldex_1_class_counts
global tree_oldex_1_class_counts_tags
global tree_oldex_1_numeric_value_counts

global tree_oldex_2_class_counts
global tree_oldex_2_class_counts_tags
global tree_oldex_2_numeric_value_counts

%initialize tree structures if they doesn't exist
tree = load_names(filename);
tree_oldex_1 = load_names(filename);
tree_oldex_2 = load_names(filename);

begin_cpu = tic;

%load data
load(filename,'zip_train_data','zip_train_classes');

%are there NaNs in data?
%figure out which data belongs with which tree
nan_rows = find_nan_rows(zip_train_data);
nan_ix = find(nan_rows);
non_nan_rows = ~nan_rows;
non_nan_ix = find(~nan_rows);

%what is start row of NaNs?
[nan_rows nan_cols] = size(nan_ix);
if(nan_rows>0)
    start_row = nan_ix(1,1);
else
    %induce tree
    tree = fast_train_mat_passed(tree,zip_train_data,zip_train_classes);
end
%return tree
