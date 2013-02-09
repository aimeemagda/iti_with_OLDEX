function free_node(tree,node)
%clear a node for reuse
%author: J. Brooks Zurn

%clear node_to_move
tree(node).instances = [];
tree(node).class_counts = [];
tree(node).variables = [];
tree(node).parent = -1;
tree(node).left = 0;
tree(node).right = 0;
%leave here alone, this is an address. tree(node_to_move).here = ;
tree(node).best_variable = 0;
tree(node).class = 0;
%ignore flags tree(node_to_move).flags = ;
tree(node).variable_name = [];
%leave min_insts_second_majority tree(node_to_move).min_insts_second_majority = 1;
