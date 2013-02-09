function dist = ks_distance_of_counts(n_less,n_greater,n_total,variable,value)
%* Compute a form of kolmogorov-smirnov distance for a list of probs.
%note: it returns the max distance between two 'super classes'
%(combinations of the most probable classes).  it doesn't return which
%classes correspond to the best distance, because the test doesn't need to 
%know which classes this test performs the best for.  it's only looking for
%the best value to cut on.
%
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs:
%n_less: count of instances which test < current value (add .5 so that it tests in between values)
%n_greater: difference between counts for current value and last value
%n_this_class: cumulative total of all instances <= this value
%   ('n_this_class' from previous function)
%variable: the current variable
%value: the current value of that variable
%outputs:
%dist: the ks distance for every variable supplied

%DEBUG_MERIT = 0;
global DEBUG_MERIT

%get number of classes and number of values
[n_classes n_values] = size(n_total);
dist = zeros(1,n_values);

%first get rid of classes with total==0, they mess up the sorting algorithm

if (n_values==1)
    total_classes_present_ix = n_total > 0;
    n_total_present = n_total(total_classes_present_ix);
    n_greater_present = n_greater(total_classes_present_ix);
    n_less_present = n_less(total_classes_present_ix);
    
    clear n_total n_greater n_less
    n_total = n_total_present;
    n_greater = n_greater_present;
    n_less = n_less_present;
    
    
    n_classes = sum_logical(total_classes_present_ix);

    clear n_total_present n_greater_present n_less_present total_classes_present_ix
    
end


if(DEBUG_MERIT)
  fprintf('   T    F   tot\n');
  fprintf('+----+----+----+\n');
  for i=1:n_classes
      fprintf('|%4.0f|%4.0f|%4.0f|',n_less(i,1),n_greater(i,1),n_total(i,1));
      if(n_less(i,1)>n_total(i,1))
          fprintf('  <--------- error');
      end
      fprintf('\n');
  end
  fprintf('+----+----+----+\n');
end %end DEBUG_MERIT



%temp_class_probs = zeros(n_classes,n_values);
%max_class_probs = zeros(n_classes,1); %max value of each class probability

%algorithm: 
%1) compute the class probabilities for each value w.r.t. 'n_less' and 'n_greater'          
%2) pick a value for the current variable
%3) sort the classes in descending order for current value w.r.t. 
%           a) 'n_less', and
%           b)'n_greater'
%4) compute superclass probability distances for this value w.r.t.
%           a) 'n_less', and
%           b)'n_greater'
%5) compute total dist for current value (dist(1,current_value) = dist_low + dist_high)
%6) repeat 2)-5) until dists for all values have been computed
%7) return array of dists


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1) compute the class probabilities for each value w.r.t. 'n_less' and 'n_greater'          
n_less_prob = get_n_prob(n_less,n_total,n_classes,n_values);
n_greater_prob = get_n_prob(n_greater,n_total,n_classes,n_values);

%2) pick a value for the current variable
for current_value = 1:n_values

%3) sort the classes in descending order for current value w.r.t. 
%           a) 'n_less'
    [n_less_prob_sortbyless(:,1) temp_sorted_ix] = sort(n_less_prob(:,current_value),'descend');
    n_less_sortbyless = n_less(temp_sorted_ix,current_value);
    n_greater_sortbyless = n_greater(temp_sorted_ix,current_value);
    n_total_sortbyless = n_total(temp_sorted_ix,current_value);

%           b)'n_greater'
    [n_greater_prob_sortbygreater(:,1) temp_sorted_ix] = sort(n_greater_prob(:,current_value),'descend');
    n_less_sortbygreater = n_less(temp_sorted_ix,current_value);
    n_greater_sortbygreater = n_greater(temp_sorted_ix,current_value);
    n_total_sortbygreater = n_total(temp_sorted_ix,current_value);
    
%now compute the 'superclass' distances
%what ARE the superclasses?

%4) compute superclass probability distances for this value w.r.t.
%           a) 'n_less', and
%           b)'n_greater'
    
    %SORTBYLESS
    super1_n_less = 0;%zeros(n_classes,1);
    super1_n_greater = 0;%zeros(n_classes,1);
    super1_n_total = 0;%zeros(n_classes,1);

    super2_n_less = 0;%zeros(n_classes,1);
    super2_n_greater = 0;%zeros(n_classes,1);
    super2_n_total = 0;%zeros(n_classes,1);
    
    dist_low = 0;
    for current_class = 1:(n_classes-1)
       d1=n_less_prob_sortbyless(current_class,1)-n_less_prob_sortbyless(current_class+1,1);
       %d1

       if(d1>=dist_low) %if this is currently the best distance, cumulatively update the height of the superclass
           dist_low = d1;
           %fprintf('\nd1>=dist_low,n_less_sortbyless(%d,1)=%d',current_class,n_less_sortbyless(current_class,1));

           %super1_n_less(current_class,1) = super1_n_less(current_class,1) + n_less_sortbyless(current_class,1) + super2_n_less(current_class,1);
           %super2_n_less(current_class,1) = 0;
           super1_n_less = super1_n_less + n_less_sortbyless(current_class,1) + super2_n_less;
           super2_n_less = 0;

           %super1_n_greater(current_class,1) = super1_n_greater(current_class,1) + n_greater_sortbyless(current_class,1) + super2_n_greater(current_class,1);
           %super2_n_greater(current_class,1) = 0;
           super1_n_greater = super1_n_greater + n_greater_sortbyless(current_class,1) + super2_n_greater;
           super2_n_greater = 0;

           %super1_n_total(current_class,1) = super1_n_total(current_class,1) + n_total_sortbyless(current_class,1) + super2_n_total(current_class,1);
           %super2_n_total(current_class,1) = 0;
           super1_n_total = super1_n_total + n_total_sortbyless(current_class,1) + super2_n_total;
           super2_n_total = 0;

       else %if this is NOT currently the best distance, increase the height of the bottom of the superclass
           %super2_n_less(current_class,1) = super2_n_less(current_class,1) + n_less_sortbyless(current_class,1);
           %super2_n_greater(current_class,1) = super2_n_greater(current_class,1) + n_greater_sortbyless(current_class,1);
           %super2_n_total(current_class,1) = super2_n_total(current_class,1) + n_total_sortbyless(current_class,1);
           super2_n_less = super2_n_less + n_less_sortbyless(current_class,1);
           super2_n_greater = super2_n_greater + n_greater_sortbyless(current_class,1);
           super2_n_total = super2_n_total + n_total_sortbyless(current_class,1);
       
       end
       
    end %end cycling through the values of the current class and update the bottom superclass with the last (lowest classcount) class
    %super2_n_less(n_classes,1) = super2_n_less(n_classes,1) + n_less_sortbyless(n_classes,1);
    %super2_n_greater(n_classes,1) = super2_n_greater(n_classes,1) + n_greater_sortbyless(n_classes,1);
    %super2_n_total(n_classes,1) = super2_n_total(n_classes,1) + n_total_sortbyless(n_classes,1);
    super2_n_less = super2_n_less + n_less_sortbyless(n_classes,1);
    super2_n_greater = super2_n_greater + n_greater_sortbyless(n_classes,1);
    super2_n_total = super2_n_total + n_total_sortbyless(n_classes,1);

    
    %%%CHECK THIS!!
    %if(super1_n_total(current_class,1)>0)
    %   if(super2_n_total(current_class,1)>0)
    %       dist_low = abs(super1_n_less(current_class,1)/super1_n_total(current_class,1)) - (super1_n_less(current_class,1)/super1_n_total(current_class,1));
    %   else
    %       fprintf('\nerror.  super2_n_total(current_class,1) == 0. div by 0 error.\n');
    %   end
    %else
    %   fprintf('\nerror.  super1_n_total(current_class,1) == 0. div by 0 error.\n');
    %end
    
    if(super1_n_total>0)
       if(super2_n_total>0)
           %fprintf('\ncurrent_value=%d,super1_n_less=%d,super1_n_total=%d,super2_n_less=%d,super2_n_total=%d',current_value,super1_n_less,super1_n_total,super2_n_less,super2_n_total);
           dist_low = abs((super1_n_less/super1_n_total) - (super2_n_less/super2_n_total));
       else
           fprintf('\nerror.  super2_n_total(current_class,1) == 0. div by 0 error. (n_less, current_value=%d)\n',current_value);
       end
    else
       fprintf('\nerror.  super1_n_total(current_class,1) == 0. div by 0 error.(n_less, current_value=%d)\n',current_value);
    end

if(DEBUG_MERIT)
    fprintf(' fabs(%d/%d - %d/%d) == %0.6f\n',super1_n_less,super1_n_total,super2_n_less,super2_n_total,dist_low);
end %end DEBUG_MERIT

    %done with dist_low.  now compute dist_high  
    %SORTBYGREATER
    super1_n_less = 0;%zeros(n_classes,1);
    super1_n_greater = 0;%zeros(n_classes,1);
    super1_n_total = 0;%zeros(n_classes,1);

    super2_n_less = 0;%zeros(n_classes,1);
    super2_n_greater = 0;%zeros(n_classes,1);
    super2_n_total = 0;%zeros(n_classes,1);

    dist_high = 0;
    for current_class = 1:(n_classes-1)
       d1=n_greater_prob_sortbygreater(current_class,1)-n_greater_prob_sortbygreater(current_class+1,1);
       %d1
       
       if(d1>=dist_high) %if this is currently the best distance, cumulatively update the height of the superclass
           dist_high = d1;
           %fprintf('\nd1>=dist_high');

           %super1_n_less(current_class,1) = super1_n_less(current_class,1) + n_less_sortbygreater(current_class,1) + super2_n_less(current_class,1)%;
           super1_n_less = super1_n_less + n_less_sortbygreater(current_class,1) + super2_n_less;
           super2_n_less = 0;

           super1_n_greater = super1_n_greater + n_greater_sortbygreater(current_class,1) + super2_n_greater;
           super2_n_greater = 0;

           super1_n_total = super1_n_total + n_total_sortbygreater(current_class,1) + super2_n_total;
           super2_n_total = 0;
       else %if this is NOT currently the best distance, increase the height of the bottom of the superclass
           super2_n_less = super2_n_less + n_less_sortbygreater(current_class,1);
           super2_n_greater = super2_n_greater + n_greater_sortbygreater(current_class,1);
           super2_n_total = super2_n_total + n_total_sortbygreater(current_class,1);
       end
       
    end %end cycling through the values of the current class and update the bottom superclass with the last (lowest classcount) class
    super2_n_less = super2_n_less + n_less_sortbygreater(n_classes,1);
    super2_n_greater = super2_n_greater + n_greater_sortbygreater(n_classes,1);
    super2_n_total = super2_n_total + n_total_sortbygreater(n_classes,1);
%%%CHECK THIS!!
    %if(super1_n_total(current_class,1)>0)
    if(super1_n_total>0)
       %if(super2_n_total(current_class,1)>0)
       if(super2_n_total>0)
           %dist_high = abs(super1_n_greater(current_class,1)/super1_n_total(current_class,1)) - (super1_n_greater(current_class,1)/super1_n_total(current_class,1));
           %fprintf('\ncurrent_value=%d,super1_n_greater=%d,super1_n_total=%d,super2_n_greater=%d,super2_n_total=%d',current_value,super1_n_greater,super1_n_total,super2_n_greater,super2_n_total);
           dist_high = abs((super1_n_greater/super1_n_total) - (super2_n_greater/super2_n_total));
       else
           fprintf('\nerror.  super2_n_total(current_class,1) == 0. div by 0 error.(n_greater, current_value=%d)\n',current_value);
       end
    else
       fprintf('\nerror.  super1_n_total(current_class,1) == 0. div by 0 error.(n_greater, current_value=%d)\n',current_value);
    end
    
if(DEBUG_MERIT)
    fprintf(' fabs(%d/%d - %d/%d) == %0.6f\n',super1_n_greater,super1_n_total,super2_n_less,super2_n_total,dist_high);
end %end DEBUG_MERIT

    %5) compute total dist for current value (dist(1,current_value) = dist_low + dist_high)
   
    %dist_low
    %dist_high
    dist(1,current_value) = dist_low + dist_high;
       
    
end %6) repeat 2)-5) until dists for all values have been computed

%7) return array of dists
%this is implicit since dist has already been filled.


    
    