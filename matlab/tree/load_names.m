function tree = load_names(filestem)
%global variables
global FALSE
FALSE = 0;
global TRUE
TRUE = 1;
global NULL
NULL = 0;

global n_training_insts
global n_testing_insts
global n_variables
global n_OLDEX_variables
global n_classes
global current_inst_tag
global current_data_format

global all_classes
global variable_name
global total_cpu
global total_transpositions
global n_transpositions
global DEBUG_MERIT

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

kernel_type = 'NULL';
global kernel_transform_table
global kernel_const


current_inst_tag = 0;
n_transpositions = 0;
total_cpu=0;

DEBUG_MERIT = 0;

%variables
min_insts_second_majority = 1;

%assign internal variables that have pre-set values
do_performance_measuring = FALSE;
do_test_incrementally = FALSE;  %%%///jbz initialize
%  n_leaves_using_fast_train,
%  total_transpositions;

fileopen_ok = 0; %%/* jbz for 'T' */
inc_test_fp = 0;

num_attributes_namesfile = 0; % /* jbz for 'N': the number of attributes for the new names file*/
get_num_attributes_readin_ok = 0; %/* jbz for 'N': figure out whether a number was read in*/

% fprintf('ITI %d.%d - (C) Copyright, U. of Massachusetts, %s, All Rights Reserved\n\n',ITI_VERSION,ITI_REVISION,COPYRIGHT_DATE);
% fprintf('Use the option "z" to see the manual.\n\n'); 
fprintf('ITI for Matlab\n');
fprintf('usage: iti(filestem,option1,parameter1,option2,parameter2,...\n\n');

do_vpruning = FALSE;

verbose_load_instances = FALSE;
n_training_insts = 0;
n_testing_insts = 0;
title(1) = 0;
tag = NULL;
train_set = NULL;
test_set = NULL;
my_train_set = NULL;   %/* jbz */
tree = NULL;

%%%%testing variable inits
tree_exists = 0;
accuracy = 0;
n_insts = 0;
n_tests = 0;
n_leaves = 0;
xpath = 0;



i_arg = 1;
i_char = 0;

%fname = sprintf('%s%s/names',DATA_PATH_NAME,filestem);
fname = sprintf('%s/names',filestem);

fp=fopen(fname,'r');

%verbose_load_instances = 1;
try 
    if (fp)
        fclose(fp);
        fprintf('Loading variable names ...');
        [variable_name n_variables all_classes] = read_variable_names(fname,verbose_load_instances);
        [dummy n_classes] = size(all_classes);  %n_classes directly from file
        fprintf(' %d loaded\n',n_variables);
        
        tree = initialize_tree(tree,min_insts_second_majority);
        tree_class_counts = initialize_tree(tree,min_insts_second_majority);
        tree_class_counts_tags = initialize_tree(tree,min_insts_second_majority);
        tree_numeric_value_counts = initialize_tree(tree,min_insts_second_majority);
        
%         if(~isstruct(tree))
%             tree= get_tree_node(tree,n_variables,n_classes,1);
%         end
%         
%         tree(1) = load_classnames_into_tree(tree(1),all_classes);
%         for i=1:n_variables
%             tree(1).variables(i).variable_key = variable_name{i,1};
%         end
%         
%         tree(1).min_insts_second_majority = min_insts_second_majority;
        
    else
        error('Unable to open file %s\n',fname);
    end
catch
    fprintf('current directory is ');
    disp('current directory is ');
    cd
    error('Problem opening names file %s (file might be absent from directory %s\n',fname,filestem);
end
