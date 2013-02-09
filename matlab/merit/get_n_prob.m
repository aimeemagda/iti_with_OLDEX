function n_prob = get_n_prob(n_original,n_total,n_classes,n_values)
%get probabilities from counts of value occurences
%author: J. Brooks Zurn
%modified from Paul Utgoff

n_prob = zeros(n_classes,n_values);

for current_val=1:n_values
    for current_class = 1:n_classes
        if(n_total(current_class,current_val))  %avoid divide by 0
            n_prob(current_class,current_val) = n_original(current_class,current_val)/n_total(current_class,current_val);
        else
            n_prob(current_class,current_val) = 0;
        end
    end
end