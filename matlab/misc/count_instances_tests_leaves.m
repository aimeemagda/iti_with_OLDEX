function [n_insts,n_tests,n_leaves] = count_instances_tests_leaves(tree,root,here,n_insts,n_tests,n_leaves,count_leaves)
%* Count total training instances and total number of tests needed to classify
%* author: Paul Utgoff
%modified by J. Brooks Zurn

  
  if (does_tree_exist(tree,root))
      
      
  { forall(itmp, tree->instances)
    { (*n_insts)++;
      
      /* Call classify to add n_tests needed to classify the instance */
      (void) classify(root, itmp, n_tests);
    }
    
    if ((tree->left || tree->right) && !(tree->flags & VPRUNED))
    { if (tree->left)
          count_instances_tests_leaves(root, tree->left, n_insts, n_tests, n_leaves,
                  count_leaves);
      
      if (tree->right)
          count_instances_tests_leaves(root, tree->right, n_insts, n_tests, n_leaves,
                  count_leaves);
    }
    else
    { if (count_leaves)
          (*n_leaves)++;
      
      if (tree->left)
          count_instances_tests_leaves(root, tree->left, n_insts, n_tests, n_leaves,
                  FALSE);
      
      if (tree->right)
          count_instances_tests_leaves(root, tree->right, n_insts, n_tests, n_leaves,
                  FALSE);
    }
  }
}