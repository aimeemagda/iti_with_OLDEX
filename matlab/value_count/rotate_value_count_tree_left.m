function v_tree=rotate_value_count_tree_left(v_tree)
%* for AVL rebalancing
%* author: Paul Utgoff
%modified by J. Brooks Zurn
%input: 
%v_tree:value count tree
%output: 
%v_tree:balanced value count tree

old_right = initialize_type('value_count_node');
middle = old_right;
new_left = old_right;

  %/* make attach points */
  old_right = v_tree.right;
  middle = old_right.left;
  new_left = v_tree;

  %/* reattach pieces */
  old_right.left = new_left;
  new_left.right = middle;
  v_tree = old_right;

  %/* reset height left sub_v_tree */
  h1 = conditional(new_left.left,get_height(new_left.left),-1);
  h2 = conditional(middle,middle.height,-1);
  new_left.height = 1 + max(h1,h2);
  
  %/* reset height v_tree */
  h1 = new_left.height;
  h2 = conditional(v_tree.right,get_height(v_tree.right),-1);
  v_tree.height = 1 + max(h1,h2);
