function tree = fast_train2(tree,filename,n_training_insts,n_variables,n_classes,all_classes)
global total_cpu

begin_cpu = tic;
tree = quick_load(filename,tree,n_training_insts,n_variables,n_classes,all_classes);
tree = get_node_class(tree,1);


tree = split_node_if_impure(tree,1);
tree = ensure_best_variable(tree,1);

total_cpu = toc(begin_cpu);