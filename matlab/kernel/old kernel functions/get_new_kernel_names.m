function [variable_name n_variables] = get_new_kernel_names(kernel_type,variable_name,n_variables)
%modify list of variable names to include new kernel-transformed attributes
%author: J. Brooks Zurn
%inputs:
%kernel_type: the type of kernel
%variable_name: the current cell array containing variable (attribute) names
%n_variables: the current number of variables (attributes)
%outputs:
%variable_name: cell array containing the kernel-augmented list of names
%n_variables: a count of the new number of variables (attributes)


%how many new variables do we need for this kernel?
%what are their names?

%switch kernel type% new_variable_name = {};
% new_variables_count = 0;

switch kernel_type
    case 'rbf'
        %new_variables_count = n_variables*n_variables;
        new_variables_count = (n_variables*n_variables - n_variables)/2;
        new_variable_name = cell(new_variables_count,1);

        
        %for i=1:new_variables_count
       
            %att1 = round(floor((i-1)/n_variables)+1); %round to int to avoid random double problem
            %att2 = round(modulo((i-1),n_variables)+1);
        
            %new_variable_name{i,1} = horzcat('rbf(',variable_name{att1,1},',',variable_name{att2,1},')');
            
            count=0;
            for i=1:n_variables
                for j=1:n_variables
                    if i<j
                        count=count+1;
                        new_variable_name{count,1} = horzcat('rbf(',variable_name{i,1},',',variable_name{j,1},')');
                    end
                end
            end


    otherwise
        fprintf('\ninvalid kernel type.  skipping kernel transformation procedure.');
        return;
end


%put them together and return

variable_name = vertcat(variable_name,new_variable_name);
n_variables = n_variables + new_variables_count;
