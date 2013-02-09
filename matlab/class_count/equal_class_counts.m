function is_equal = equal_class_counts(c1,c2)
%* return true if class_counts are equal
%* author: Paul Utgoff
%modified by J. Brooks Zurn

VERBOSE = 1;

global n_classes
global n_variables

is_equal=1;
is_equal_logical = zeros(n_classes,n_variables);

if(VERBOSE) fprintf('(equal_class_counts) entering function'); end

%[dummy n_values] = size(c2);

count_c2 = sum(c2,2);

for i=1:n_variables
    for j=1:n_classes
    is_equal_logical(j,i) = (c1(j,1)==count_c2(j,i));
    if(is_equal_logical(j,i))
        is_equal=0;
    end
    end
        
end

%is_equal = sum(is_equal_logical);

