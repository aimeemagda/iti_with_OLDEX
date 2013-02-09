function tree = fast_train_mat_passed(tree,data,classes)
global total_cpu

begin_cpu = tic;
tree = quick_load_mat_passed(tree,data,classes);
tree = get_node_class(tree,1);


tree = split_node_if_impure(tree,1);
tree = ensure_best_variable(tree,1);

total_cpu = toc(begin_cpu);