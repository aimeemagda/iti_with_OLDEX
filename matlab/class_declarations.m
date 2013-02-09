%ITI class objects

%instance structures
value = struct('symbolic',{},'numeric',[]);

instance = struct('val',value,'classname',{});
%val: values of current instance
%classname: class name of current instance
%no longer need *next b/c is next in array
%no longer need value struct b/c cell can handle both symbolic and numeric

%indirect metric structures
prob_node = struct('n_less',[0],'n_greater',[0],'n_total',[0],'less_used',[0],'greater_used',[0],'next',[0]);
%

%tree structures
class_count_node = struct('left',[0],'right',[0],'next',[0],'key',{},'count',[0],'height',[0]);
%left: pointer to left branch
%right: pointer to right branch
%next: pointer to next class_count_node
%key: pointer to string in key
%count: count of values in node
%height: height of node

value_count_node = struct('left',[0],'right',[0],'next',[0],'class_counts',[0],'key',{''},'metric_value',[0],'count',[0],'height',[0]);
%left: pointer to left branch
%right: pointer to right branch
%next: pointer to next class_count_node
%class_counts: pointer to class_counts_node
%key: pointer to string in key
%count: count of values in node
%height: height of node

variable = struct('class_counts',[0],'best_value',[0],'new_best_value',[0],'numeric_value_counts',[0],'symbolic_value_counts',[0],'cutpoint',[0],'new_cutpoint',[0],'metric_value',[0],'count',[0]);
%class_counts: pointer to class_counts_node
%best_value: pointer to value_count_node
%new_best_value: pointer to value_count_node
%numeric_value_counts: pointer to value_count_node
%symbolic_value_counts: pointer to value_count_node
%cutpoint: cutpoint for this variable
%new_cutpoint: new cutpoint for this variable
%metric_value: value of metric for this variable
%count: 

%%%%tree structures
tree_node = struct('instances',instance,'class_counts',class_count_node,'variables',variable,'left',[0],'right',[0],'next',[0],'best_variable',[0],'flags',[0],'mdl',[0]);
%'instances': instance class
%'class_counts': class_count_node class
%'variables': variable class
%'left': pointer to left branch
%'right': pointer to right branch
%'next': pointer to next branch
%'best_variable': number of best variable
%'flags': int flags
%'mdl': minimum description length









