function tree = move_node(tree,destination_node,node_to_move)
%move a node within the tree structure, and fix linking nodes
%removes the data from the destination node and replaces it with data from
%node_to_move
%author: J. Brooks Zurn

tree(destination_node).instances = tree(node_to_move).instances;
tree(destination_node).class_counts = tree(node_to_move).class_counts;
tree(destination_node).variables = tree(node_to_move).variables;
%leave parent the same
%leave left and right children the same
tree(destination_node).best_variable = tree(node_to_move).best_variable;
tree(destination_node).class = tree(node_to_move).class;
tree(destination_node).flags = tree(node_to_move).flags;
tree(destination_node).mdl = tree(node_to_move).mdl;
tree(destination_node).variable_name = tree(node_to_move).variable_name;
tree(destination_node).min_insts_second_majority = tree(node_to_move).min_insts_second_majority;

free_node(tree,node_to_move);
