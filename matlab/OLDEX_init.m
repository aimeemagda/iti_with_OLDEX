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
%tree_oldex_1 = load_names(filename);
%tree_oldex_2 = load_names(filename);

%also, now n_variables should be initialized.

begin_cpu = tic;

%load data
load(filename,'zip_train_data','zip_train_classes');

%are there NaNs in data?
%nan_rows = find_nan_rows(zip_train_data);
%nan_ix = find(nan_rows);
%non_nan_rows = ~nan_rows;
%non_nan_ix = find(~nan_rows);
nan_matrix = logical2mat(isnan(zip_train_data));
%how many different nan profiles are there in data?
unique_nan_rows = rank(nan_matrix);

%NaNs: each column profile of nans is a separate tree.
if(unique_nan_rows>0)
    %induces a tree for each nan profile
    
    
    %trees are same regardless of induction order
    %so, induce the initial tree from non-nan data prior to nan rows
    %use that tree as an initial tree for subsequent nan trees
    meta_tree(1:unique_nan_rows) = tree;
    
    for i=1:unique_nan_rows
        %induce tree for each NaN profile
    end
else %if there are no NaNs in data, simply induce the first tree
    %induce tree
    tree = fast_train_mat_passed(tree,zip_train_data,zip_train_classes);
end
%return tree
