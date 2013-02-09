function result = different_class_sets(tree,here,variable,v1,v2)
% * Return TRUE iff each class set has one class and it is same for both.
% * author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs:
%v1: the last value of the variable node
%v2: the current value of the variable node

global tree_class_counts
% global tree_class_counts_tags
% global tree_numeric_value_counts


c1=0;
c2=0;
n1=0;
result = 0;

%open the class counts for the current value
%all_class_counts = cell2mat(tree(here).variables(variable).class_counts);
all_class_counts = cell2mat(tree_class_counts(here).variables(variable).class_counts);
open_val = all_class_counts(:,v1); %get the class counts for just value1

[n_classes n_values] = size(open_val);

i=1;
while((i<=n_classes) && (n1<2))
    if(open_val(i,1)>0)
        if(~n1)
            c1=i;
            n1=1;
        else %if we have previously found a non-empty count
            if(c1 ~=i)
                n1 = n1 + 1;
            end
        end %end if(~n1)
    end
    i=i+1;
end

if(n1>1)
    result = 1; %TRUE
else
    n2=0;
    open_val = all_class_counts(:,v2); %get class counts for value2
    
    i=1;
    while((i<=n_classes) && (n1<2))
        if(open_val(i,1)>0)
            if(~n2)
                c2=i;
                n2=1;
            else %if we have previously found a non-empty count
                if(c2 ~=i)
                    n2 = n2 + 1;
                end
            end %end if(~n1)
        end
        i=i+1;
    end
    if(n2>1)
        result = 1;
    elseif(c1&&c2)
        if(c1~=c2)
            result = 1;
        end
    end
    
            
%     if((n2>1)||(c1~=c2))
%         result = 1;
%     end
    
end
    
    
        
            
            


