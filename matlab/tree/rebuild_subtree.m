function tree = rebuild_subtree(tree,here,new_best_variable,cutpoint)
%* Used by procedure transpose_tree() to rebuild the variable information
%* at a level one node of the tree.  Info is sum of info at two children.
%* author: Paul Utgoff
%modified by J. Brooks Zurn 
%usage: tree = rebuild_subtree(lr,rr,v,root_best_value_key,tree(here).variables(v).cutpoint)
%
%inputs:
%tree: the tree
%here: the current tree node
%left: location of left branch
%right: location of right branch
%var: best variable of tree
%val_key: a string
%cutpoint: the cutpoint of the best variable

global tree_class_counts
global tree_class_counts_tags
global tree_numeric_value_counts

VERBOSE = 0;
SUPER_VERBOSE = 1;

%tree(here) ??? has all the class_count info necessary to rebuild the tree
%IFF I create a  bin of instance counts for each class count
%so clear all subtrees and rebuild.
%this is not what ITI does, but i'm going to try it and see if it's fast
%enough

%note: this function was called because restructuring was necessary. so
%don't check if it's necessary, just do it.

fprintf('*'); %display a rebuilding token

%recursively free all children
% tree = free_node_recursively(tree,tree(here).left);
% tree = free_node_recursively(tree,tree(here).right);
tree=free_children_recursively(tree,here);

tree_class_counts=free_children_recursively(tree_class_counts,here);
tree_class_counts_tags=free_children_recursively(tree_class_counts_tags,here);
tree_numeric_value_counts=free_children_recursively(tree_numeric_value_counts,here);

%initialize children
tree = get_child_node(tree,here,'left');
tree = get_child_node(tree,here,'right');

tree_class_counts = get_child_node(tree_class_counts,here,'left');
tree_class_counts = get_child_node(tree_class_counts,here,'right');
tree_class_counts_tags = get_child_node(tree_class_counts_tags,here,'left');
tree_class_counts_tags = get_child_node(tree_class_counts_tags,here,'right');
tree_numeric_value_counts = get_child_node(tree_numeric_value_counts,here,'left');
tree_numeric_value_counts = get_child_node(tree_numeric_value_counts,here,'right');


tree(here).best_variable = new_best_variable;
%if(~iscell(cutpoint))
    %tree(here).variables(new_best_variable).cutpoint = num2cell(cutpoint);
%else
    tree(here).variables(new_best_variable).cutpoint = cutpoint;
%end


%send current counts down through the test

tree = rebuild_instances_below_node(tree,here,1); %ensure = 1;


