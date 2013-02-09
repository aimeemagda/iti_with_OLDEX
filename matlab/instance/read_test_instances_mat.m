function [insts] = read_test_instances_mat(filename)
%read in a .mat file and convert data to iti format
%j.brooks zurn

global variable_name
global n_testing_insts

insts = initialize_type('instance');

load(filename,'zip_test_data','zip_test_classes');

[n_testing_insts test_class_variables]=size(zip_test_data);


for i=1:n_testing_insts
    for j=1:test_class_variables
        insts(i,j).symbolic = 'NUMERIC';
        insts(i,j).val = zip_test_data(i,j);
        
        insts(i,j).variable_name = variable_name{j};
        insts(i,j).classname = zip_test_classes{i,1};
        
    end
end
