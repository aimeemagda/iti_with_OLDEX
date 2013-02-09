function [instances n_instances] = read_instances(fname,instances,verbose_load_instances,variable_name,n_variables)
%* Reads intances from file in the .data format (Quinlan's standard).
%* Sets instances to head of list of instances.
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs: 
%fp: pointer to file
%instances: pointer to instances
%verbose_load_instances: flag
%n_variables (jbz): number of variables from names file, for error-checking
%outputs:
%instances: filled with instances from file fp
%n_instances: # of insts read from file fp

%int state,pushed_state;
%char buf[100],*pbuf;

insts = initialize_type('instance');
itmp = insts;

%insts = NULL;
n_instances = 0;

if (verbose_load_instances)
    fprintf('\n');	%/* set up to start displaying on screen if applicable */
end

%for entire file
%lets try loading entire file as in read_variable_names.  maybe it won't
%be too big. if it is we'll try reading it one line at a time.
A=fileread(fname);

%split text by line
Asplit = regexp(A,'\n','split','freespacing')'; %rotate results so that each line is a row.
%number of lines from file
[lines dummy] = size(Asplit);
%remove whitespace 
for i=1:lines
    Asplit{i,1}=strtrim(Asplit{i,1});
end
%remove blank lines
for i=1:lines
    if(~strcmp(Asplit{i,1},''))
        n_instances = n_instances + 1;
        Asplit_cleaned{n_instances,1}=Asplit{i,1};
    end
end
clear Asplit;
Asplit = Asplit_cleaned;
clear Asplit_cleaned; %try to keep the ram requirements down

%now process individual lines
for i=1:n_instances
    
    %first strip out any comments
    temp1 = regexp(Asplit{i,1},'\|','split','freespacing');
    temp2 = {temp1{1,1}};
    
    %split by comma delimiter
    this_line = regexp(temp2{1,1},',','split','freespacing'); 
    
    clear temp*
    
    %confirm correct number of variables (remember last 'var' is the class)
    %if there's a problem, save the
    %current data to a .mat file before crashing.
    [dummy num_cols] = size(this_line);
    
    if(~((num_cols-1) == n_variables))
        save datadump_read_instances;
        error(sprintf('Error.  invalid number of data columns in %s,row %d. Saving previously loaded data and exiting.',fname,i));
    end
    
    
    %put them into the data structure appropriately
    %first get class so only have to do it once
    %get rid of trailing period and whitespace
    temp1 = regexp(strtrim(this_line{1,num_cols}),'\.','split','freespacing');
    output_class = convert_whitespace_to_underscore(temp1{1,1});
    
    clear temp*
    
    for j=1:(num_cols-1)
        %first get rid of any leading/trailing whitespace
        this_line{1,j} = strtrim(this_line{1,j});
        
        if(or(strcmp(this_line{1,j},'?'),strcmp(this_line{1,j},'')))
            insts(i,j).symbolic = 'MISSING';        %is it missing?
        elseif(str2num(this_line{1,j}))         %is it numerical?
            insts(i,j).symbolic = 'NUMERIC';
            insts(i,j).val = str2num(this_line{1,j});
        elseif(ischar(this_line{1,j}))              %is it a string? 
            temp = this_line{1,j};
            
            if(strcmp(temp,'0'))
                insts(i,j).symbolic = 'NUMERIC';
                insts(i,j).val = 0;
            else
                insts(i,j).symbolic = convert_whitespace_to_underscore(this_line{1,j});
            end
        else                                        %what is it??
            fprintf('\nWarning: type of instance %d, col %d is unknown.',i,j);
            insts(i,j).symbolic = this_line{1,j};
        end
        
        insts(i,j).variable_name = variable_name{j};
        insts(i,j).classname = output_class; %this is a waste of space but don't know a better way right now
        
        if(verbose_load_instances)
            fprintf('%s,',this_line{1,j});
        end
     
    
    end
    if(verbose_load_instances)
        fprintf('%s\n',output_class);
    end

    
end

instances = insts;
