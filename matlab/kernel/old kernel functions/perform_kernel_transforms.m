function kernel_transforms = perform_kernel_transforms(kernel_type,const,data)
%perform kernel transforms instance by instance, record values and update
%counts
%author: J. Brooks Zurn

%kernel transformed input data have 4 components: a, b, k(a,b), tag
%note: kernel transformed list condenses tags by k(a,b).  this function doesn't
%do that.

[num_insts num_atts] = size(data);

transforms_size = (num_atts*num_atts-num_atts)/2;

kernel_transforms = zeros(num_insts,transforms_size);

%pick small set or large set for waitbar
verbose = 1;
smallset=0;

if(~verbose)
        
    current_ix = 0;
    %current_string = sprintf('Performing kernel transforms on %d instances...',num_insts);
    %h=waitbar(0,current_string);
    
    for i=1:num_insts
        
        %waitbar(1:num_insts)
        for a=1:num_atts
            for b=1:num_atts
                if a<b
                    current_ix = current_ix + 1;
                    
                    %perform transform on data
                    kernel_transforms(i,current_ix) = kernel_transform(kernel_type,data(i,a),data(i,b),const);
                    %get grid number?
                    %put into table
                    %tag is automatically the row #
                end
            end
        end
        current_ix = 0;
        
        
    end
    %close(h)
elseif(smallset)
    
    current_ix = 0;
    current_string = sprintf('Performing kernel transforms on %d instances...',num_insts);
    h=waitbar(0,current_string);
    
    for i=1:num_insts
        
        waitbar(1:num_insts)
        for a=1:num_atts
            for b=1:num_atts
                if a<b
                    current_ix = current_ix + 1;
                    
                    %perform transform on data
                    kernel_transforms(i,current_ix) = kernel_transform(kernel_type,data(i,a),data(i,b),const);
                    %get grid number?
                    %put into table
                    %tag is automatically the row #
                end
            end
        end
        current_ix = 0;
        
        
    end
    close(h)
else
    
    current_ix = 0;
    for i=1:num_insts
        current_string = sprintf('Performing kernel transforms on instance %d of %d...',i,num_insts);
        h=waitbar(0,current_string);
        
        for a=1:num_atts
            for b=1:num_atts
                if a<b
                    current_ix = current_ix + 1;
                    waitbar(current_ix/transforms_size)
                    %perform transform on data
                    kernel_transforms(i,current_ix) = kernel_transform(kernel_type,data(i,a),data(i,b),const);
                    %get grid number?
                    %put into table
                    %tag is automatically the row #
                end
            end
        end
        current_ix = 0;
        close(h)
        
    end
end