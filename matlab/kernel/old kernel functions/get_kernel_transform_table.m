function kernel_transform_table = get_kernel_transform_table(kernel_type,train_data)
%create kernel transform table from data 
%author: J. Brooks Zurn
%inputs: 
%kernel_type: the type of kernel (i.e. rbf)
%train_data: the training data set
%outputs:
%kernel_transform_table: a table of the kernel transforms corresponding to
%the original training data set

global n_variables
global kernel_const

symmetric = 1;

%get number of variables
[temp_insts temp_variables] = size(train_data);
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
kernel_transform_table_ix = zeros(table_size,2);
kernel_transform_table_ix_grid = zeros(temp_variables,temp_variables);
for a=1:temp_variables
    for b=1:temp_variables
        if a<b
            count = count + 1;
            kernel_transform_table_ix(count,1)=a;
            kernel_transform_table_ix(count,2)=b;
            kernel_transform_table_ix_grid(a,b)=count;
            kernel_transform_table_ix_grid(b,a)=count;
            kernel_transform_table(count).key = [a,b];
        end
    end
end

%fill kernel structure

%fill unique list
unique_vals = unique(train_data(:,1));

temp_struct = kernel_trans_struct;

temp_struct.unique_vals = unique_vals;
[size_unique dummy] = size(unique_vals);
temp_table = zeros(size_unique,size_unique);

%fill kernel trans
for i=1:2
    for j=1:2
        %kernel eq!
        temp_table = unique_vals(i)*unique_vals(j);
    end
end

% %for current_variable = 1:temp_variables
% a = 1;
% b = 2;
% 
% %if a<b
% 
% %do stuff
% %store in table(a,b)
% %copy into table(b,a)
% 
% %end
% 
% 
%     %which attribute has more unique values?
%     
%     
% %     unique_a = unique(train_data(:,a));
% %     unique_b = unique(train_data(:,b));
% %     
% %     
% %     
% %     
% %     unique_values = unique(train_data(:,current_variable));
% %     [num_unique_values dummy] = size(unique_values);
% %     
%     %create a key of the x,y vals for the transform table
%     temp_transform_table_ix = zeros(num_unique_values*num_unique_values,2);
%     temp_transform_table_ix_grid = zeros(num_unique_values,num_unique_values);
%     temp_transform_table_key = zeros(num_unique_values*num_unique_values,2);
%     %create an empty table to contain the transforms
%     temp_transform_table = zeros(num_unique_values*num_unique_values,1);
%     
%     for i=1:(num_unique_values*num_unique_values)
%         val1 = round(floor((i-1)/num_unique_values)+1); %round to int to avoid random double problem
%         val2 = round(modulo((i-1),num_unique_values)+1);
%         temp_transform_table_ix(i,1)=val1;
%         temp_transform_table_ix(i,2)=val2;
%         temp_transform_table_ix_grid(val1,val2)=i;
%         temp_transform_table_key(i,1) = unique_values(val1,1);
%         temp_transform_table_key(i,2) = unique_values(val2,1);
%     end
%     
%     %fill the transform table
%     
%             %get the current pair for transforming
%             for i=1:num_unique_values*num_unique_values
%                 val1 = round(floor((i-1)/num_unique_values)+1); %round to int to avoid random double problem
%                 val2 = round(modulo((i-1),num_unique_values)+1);
%                 
%                 %assume it's symmetric
%                 if(val2<val1)  
%                     temp_transform_table(i,1) = kernel_transform(kernel_type,temp_transform_table_key(i,1),temp_transform_table_key(i,2),kernel_const);
%                 elseif(val1<val2)
%                     temp_transform_table(temp_transform_table_ix_grid(val2,val1))=temp_transform_table(i,1);
%                 else
%                     temp_transform_table(i,1) = kernel_transform(kernel_type,temp_transform_table_key(i,1),temp_transform_table_key(i,2),kernel_const);
%                 end
%                     
%             end
%             
%             
%             
% %end
%     
% 
% end
% 
