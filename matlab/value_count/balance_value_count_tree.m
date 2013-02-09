function v_tree = balance_value_count_tree(v_tree)
%* ensure that value count tree is AVL
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%inputs
%v_tree: value_count_node

sub_v_tree = initialize_type('value_count_node');

  h1 = conditional(v_tree.left,get_height(v_tree.left),-1;
  h2 = conditional(v_tree.right,get_height(v_tree.right), -1);

  if (h1 > h2+1)%/* v_tree too deep to the left */
      sub_v_tree = v_tree.left;

      h1 = conditional(sub_v_tree.left,get_height(sub_v_tree.left),-1);
      h2 = conditional(sub_v_tree.right,get_height(sub_v_tree.right),-1);

      if (h1 >= h2)%/* sub_v_tree too deep to the left */
        v_tree = rotate_value_count_tree_right(v_tree);
      else %/* sub_v_tree too deep to the right */
	  v_tree->left = rotate_value_count_tree_left(sub_v_tree);
	  v_tree = rotate_value_count_tree_right(v_tree);
      end
  else
      if (h2 > h1+1)%/* v_tree too deep to the right */
          sub_v_tree = v_tree.right;

          h1 = conditional(sub_v_tree.right,get_height(sub_v_tree.right),-1);
          h2 = conditional(sub_v_tree.left,get_height(sub_v_tree.left),-1);

          if (h1 >= h2) % /* sub_v_tree too deep to the right */
          v_tree = rotate_value_count_tree_left(v_tree);
          else % /* sub_v_tree too deep to the left */
              v_tree->right = rotate_value_count_tree_right(sub_v_tree);
              v_tree = rotate_value_count_tree_left(v_tree);
          end
      end
  end
  
  