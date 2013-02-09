function [variable_name n_variables all_classes] = read_variable_names(fname,verbose_load_instances)
%* Reads variable names from file in the .names format (Quinlan's standard).
%* Varnames is initialized, anything it might have pointed to will be lost.
% * author: Paul Utgoff
%modified by J. Brooks Zurn
%changes in this version: now the output classes specified in the names
%file are used (although if the program later finds an additional output
%class when data is loaded, the class is added (will this cause memory
%problems?
%
%inputs:
%fp: pointer to opened file
%verbose_load_instances: flag to turn on verbose_load_instances
%outputs:
%variable_name: 1xn cell array of names of variables
%n_variables: number of variables read from names file

n_variables = 0;

all_classes = {};
if (verbose_load_instances)
    fprintf('Variables:');
    [dummy k] = size('Variables:');
end


A=fileread(fname);


%split text by line
Asplit = regexp(A,'\n','split','freespacing')'; %rotate results so that each line is a row.
 
%number of lines from file
[lines dummy] = size(Asplit);


%process each line
for i=1:lines
    %strip out comments, marked by pipe character |
    Asplit_comment=regexp(Asplit{i,1},'\|','split');
    
    %remove leading whitespace
    Asplit_whitespace = strtrim(Asplit_comment{1,1});
    
    if(i==1)
        all_classes = get_classes(Asplit_whitespace);
    end
    
    %look for token by splitting for it
    Asplit_token = regexp(Asplit_whitespace,':','split');
    
    [dummy tokensplit] = size(Asplit_token);
    if (tokensplit >1)
        n_variables = n_variables + 1;
        variable_name{n_variables,1}=convert_whitespace_to_underscore(Asplit_token{1,1});
        if(verbose_load_instances)
            fprintf(' %s',variable_name{n_variables,1});
        end
    end
        

    clear Asplit_*
    %period

end

if (verbose_load_instances)
    fprintf('\n');
end

