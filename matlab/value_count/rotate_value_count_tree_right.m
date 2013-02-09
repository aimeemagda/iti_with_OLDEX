function rotate_value_count_tree_right(v_tree)
%* for AVL rebalancing
% * author: Paul Utgoff
%modified by J. Brooks Zurn
%input: v_tree: value_count_node
%output: v_tree: balanced value_count_node

old_left = initialize_type('value_count_node');
middle = old_left;
new_right = old_left;

  %/* make attach points */
  old_left = v_tree.left;
  middle = old_left.right;
  new_right = v_tree;

  %/* reattach pieces */
  old_left.right = new_right;
  new_right.left = middle;
  v_tree = old_left;

  %/* reset height right sub_v_tree */
  h1 = conditional(new_right.right,get_height(new_right.right),-1);
  h2 = conditional(middle,middle.height,-1);
  new_right.height = 1 + max(h1,h2);
  
  %/* reset height v_tree */
  h1 = new_right.height;
  h2 = conditional(v_tree.left,get_height(v_tree.left),-1);
  v_tree.height = 1 + max(h1,h2);
