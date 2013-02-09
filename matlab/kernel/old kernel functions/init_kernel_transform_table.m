function [kernel_transform_table kernel_transform_table_ix]= init_kernel_transform_table
%create kernel transform table from data 
%author: J. Brooks Zurn
%inputs: 
%kernel_type: the type of kernel (i.e. rbf)
%train_data: the training data set
%outputs:
%kernel_transform_table: a table of the kernel transforms corresponding to
%the original training data set

global n_variables

symmetric = 1;

%get number of variables
%[temp_insts temp_variables] = size(train_data);
temp_variables = n_variables;
%new_variables_count = n_variables*n_variables;

%create an empty table the size of every possible transform
%this needs to be able to handle changing dimensions
%temp_transform_table = zeros(temp_variables*temp_variables,1); %no, need a
%temp_variables^2 cell array

kernel_trans_struct = struct('unique_vals',[],'transforms',[]);

%kernel_transform_table(1,1:temp_variables) = kernel_trans_struct;

kernel_transform_table_struct = struct('key',[],'trans',kernel_trans_struct);

table_size = (temp_variables*temp_variables - temp_variables)/2;

%show that size of symmetric table w/o diagonal is (m^2 - m)/2
% count = 0;
% for i=1:temp_variables
%     for j=1:temp_variables
%         if i>j
%             count = count + 1;
%         end
%     end
% end

kernel_transform_table(1:table_size) = kernel_transform_table_struct;

%a = row
%b = col

%initialize kernel transform table key

count = 0;
kernel_transform_table_ix_original = zeros(table_size,2);
kernel_transform_table_ix_grid = zeros(temp_variables,temp_variables);
for a=1:temp_variables
    for b=1:temp_variables
        if a<b
            count = count + 1;
            kernel_transform_table_ix_original(count,1)=a;
            kernel_transform_table_ix_original(count,2)=b;
            kernel_transform_table_ix_grid(a,b)=count;
            kernel_transform_table_ix_grid(b,a)=count;
            kernel_transform_table(count).key = [a,b];
        end
    end
end

kernel_transform_table_ix.ix = kernel_transform_table_ix_original;
kernel_transform_table_ix.grid = kernel_transform_table_ix_grid;