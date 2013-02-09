function tree = batch_train(tree,train_set,test_set,do_vpruning,do_performance_measuring,do_test_incrementally)
%Absorb each training instance one at a time.
%author: Paul Utgoff
%modified by: J. Brooks Zurn
%inputs:
%tree: input tree
%train_set: insts struct(insts.data, insts.classes) = training instances
%***do I need to add pointers to the instance classes???
%test_set: test instances struct
%do_vpruning: flag to indicate pruning
%do_performance_measuring,do_test_incrementally: flags
%
%outputs:               
%tree_node: a pointer to a tree node

%itmp = initialize_type('instance');
global current_inst_tag
global total_cpu
global total_transpositions

VERBOSE = 0;
SUPER_VERBOSE = 0;
itmp = train_set;
%begin_cpu = cpu_used();
begin_cpu = tic;
last_cpu = begin_cpu;
total_transpositions = 0;
i = 0;
accuracy = -1.0;

%incorporate each instance into tree
%get number of instances
[instances attributes] = size(train_set);

%troubleshooting: limit number of training instances
%instances = 20;

for i=1:instances
%for i=7:instances
    current_inst_tag = current_inst_tag + 1;
     
    if(SUPER_VERBOSE) 
        fprintf('inst#%d,time=%d\n',i,toc(last_cpu)); 
    end
    fprintf('.'); %display a . on screen for each incorporated instance i
   
    if(~(modulo(i,100)))
        fprintf('\n'); %put a newline for every 100 insts. a quick visual aid.
    end
    save datadump

    n_transpositions = 0;
    
    if (or(do_performance_measuring,do_test_incrementally))
				%last_cpu = cpu_used();
                last_cpu = tic;
    end
    
  
    %%%%***incorporate the instance!!
    %fprintf('now add instances')
    %itmp(i,:);
    %tree(1,1).class_counts = 0;
    tree = add_instances_above_node(tree,itmp(i,:),1); %start at top node (tree.here = 1)
    %tree(1,1).class_counts

    

    %performance measuring or test incrementally
    if (or(do_performance_measuring,do_test_incrementally))
        add_cpu = toc(last_cpu);	
    end
    
    if (do_performance_measuring)
        %fprintf(trace_fp,'a %13.12f\n',add_cpu);
    end
    
    %ensure best variable
    tree = ensure_best_variable(tree,1);
%     tree = free_children_recursively(tree,1);
%     [tree,i,best_metric_value,best_new_merit] = best_variable_by_indirect_metric(tree,1);
%     tree = rebuild_subtree(tree,1,i,best_metric_value);
%     
    %prune if specified
    if (do_vpruning)
        %vprune(tree);
    end
 
    %# of transpositions
    total_transpositions = total_transpositions+n_transpositions;
    
    %writeout info for performance measuring/plots and test incrementally
    if (or(do_performance_measuring,do_test_incrementally))
        del_cpu = toc(last_cpu);
        n_instances=0;
        n_tests=0;
        n_leaves=0;
        %count_instances_tests_leaves(tree,tree,&n_instances,&n_tests,&n_leaves,TRUE);
        %xtests = conditional(n_instances,((n_tests+0.0)/n_instances),0.0);
        %if (test_set) accuracy = test_set_accuracy(tree,test_set);
        if(do_performance_measuring)
            %fprintf(trace_fp,'l %4d %4d %4d %8d %8.4f %8.4f %8.4f\n',i,n_instances,2*n_leaves-1,n_transpositions,del_cpu,xtests,accuracy);
        end
        if(do_test_incrementally)
            %fprintf(inc_test_fp, 'instance%d\t%d\t%3.2f\t%d\t%4.3f\t%5.4f%d\n',i,n_leaves,xtests,n_instances,accuracy*100,total_cpu,total_transpositions);
        end
    end
    
    
end %end all instances
fprintf('\n'); 


%total cpu is now used
total_cpu = toc(begin_cpu);

%return tree, we're done
