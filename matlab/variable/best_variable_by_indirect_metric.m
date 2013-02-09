function [tree,new_best_variable,best_metric_value,best_new_merit,best_metric_value_ix] = best_variable_by_indirect_metric(tree,here)
%* Find the best test to place at the decision node.
%* Can return NULL.
%* author: Paul Utgoff
%modified by J. Brooks Zurn 

new_best_variable = 0;
best_metric_value = 0;
best_new_merit = 0;

[best_metric_value, new_best_variable, best_new_merit, tree,best_metric_value_ix] = update_merit_by_ks_distance(tree,here);



 