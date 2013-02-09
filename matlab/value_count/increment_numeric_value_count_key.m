function v_tree = increment_numeric_value_count_key(v_tree,numval,class_key,n)
%* increment a value count by a specified amount
%* insert value count node if needed
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs:
%v_tree: value_count_node
%numval:double
%class_key: string
%n: int

%this function needs to be updated!!

NULL = 0;

if (does_node_exist(v_tree))
    if (numval < v_tree.key.numeric) %if less than value
        v_tree.left = increment_numeric_value_count_key(v_tree.left,numval,class_key,n);
        h1 = get_height(v_tree.left);
        h2 = conditional(v_tree.right,get_height(v_tree.right),-1);
        v_tree.height = 1 + max(h1,h2);
        v_tree = balance_value_count_tree(v_tree);
    elseif (numval > v_tree.key.numeric) %if greater than value
          v_tree.right = increment_numeric_value_count_key(v_tree.right,numval,class_key,n);
          h1 = conditional(v_tree.left,get_height(v_tree.left),-1);
          h2 = get_height(v_tree.right);
          v_tree.height = 1 + max(h1,h2);
          v_tree = balance_value_count_tree(v_tree);
    else %otherwise it's equal
          v_tree.class_counts = increment_class_count_key(v_tree.class_counts,class_key,n);
          v_tree.count = v_tree.count + n;
    end
else %if node doesn't exist initialize it
    if (n < 1) %check and make sure 
       fprintf('increment_numeric_value_count_key(%f,%3.2f,%s,%d) <----- look\n',v_tree,numval,class_key,n);
    end    

      v_tree = get_value_count_node();
      v_tree.left = v_tree.right = NULL;
      v_tree.height = 0;
      v_tree.key.numeric = numval;
      v_tree.count = n;
      v_tree.class_counts = increment_class_count_key(NULL,class_key,n);
end

