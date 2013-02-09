function outvar = initialize_type(input_string)
%initializes an ITI class structure of type input_string
%J. Brooks Zurn

%types initialized by this function:
%value
%instance
%prob_node
%class_count_node
%value_count_node
%variable
%tree_node

NULL = 0;
NO_BEST_VARIABLE = 0;

%%%%%%%%%%%%%%%instance structures
value = struct('symbolic',{},'numeric',[0]);
if(strcmp(input_string,'value'))
    outvar = value;
    return;
end

instance = struct('val',value,'classname',{},'variable_name',{});
%val: values of current instance
%classname: class name of current instance
%no longer need *next b/c is next in array
%no longer need value struct b/c cell can handle both symbolic and numeric
if(strcmp(input_string,'instance'))
    outvar = instance;
    return;
end


%%%%%%%%%%%%%%%%%%indirect metric structures
prob_node = struct('n_less',[0],'n_greater',[0],'n_total',[0],'less_used',[0],'greater_used',[0],'next',[0]);
%
if(strcmp(input_string,'prob_node'))
    outvar = prob_node;
    return;
end

%%%%%%%%%%%%%%%%%%%class count structures
class_count_node = struct('left',[0],'right',[0],'next',[0],'key',{},'count',[0],'height',[0]);
%left: pointer to left branch
%right: pointer to right branch
%next: pointer to next class_count_node
%key: pointer to string in key
%count: count of values in node
%height: height of node
if(strcmp(input_string,'class_count_node'))
    outvar = class_count_node;
    return;
end

key = struct('symbolic',{''},'numeric',[]);

value_count_node = struct('left',[0],'right',[0],'next',[0],'class_counts',[0],'key',key,'metric_value',[0],'count',[0],'height',[0]);
%left: pointer to left branch
%right: pointer to right branch
%next: pointer to next class_count_node
%class_counts: pointer to class_counts_node
%key: pointer to string in key
%count: count of values in node
%height: height of node
if(strcmp(input_string,'value_count_node'))
    outvar = value_count_node;
    return;
end

%'numeric_value_counts',[0],...          %pointer to value_count_node

%variable = struct(...
%    'class_counts',[0],...                  %pointer to class_counts_node
%    'best_value',[0],...                    %pointer to value_count_node
%    'new_best_value',[0],...                %pointer to value_count_node
%    'numeric_value_counts',{},...          %pointer to value_count_node
%    'symbolic_value_counts',{},...         %pointer to value_count_node
%    'missing_value_counts',{},...          %just tally up missing in an int.
%    'cutpoint',[0],...                      %cutpoint for this variable
%    'new_cutpoint',[0],...                  %new cutpoint for this variable
%    'metric_value',[0],...                  %value of metric for this variable
%    'count',[0],...                           %total count of values
%    'variable_key',{});                       %name of this variable



%initialize variables

variable = struct('class_counts',{},... %'class_counts',NULL,...
    'class_counts_tags',{},... %'class_counts',NULL,...
    'symbolic_value_counts',{},... %'symbolic_value_counts',NULL,...
    'best_value',NULL,...
    'new_best_value',NULL,...
    'numeric_value_counts',{},...    %'numeric_value_counts',NULL,...
    'missing_value_counts',{},...  %'missing_value_counts',NULL,...
    'cutpoint',0.0,...
    'new_cutpoint',0.0,...
    'metric_value',0.0,...
    'new_metric_value',0.0,...    
    'count',0,...
    'variable_key',{});                       %name of this variable

if(strcmp(input_string,'variable'))
    outvar = variable;
    return;
end

%%%%%%%%%%%%%%%tree structures
flags_struct = struct('stale',[],'vpruned',[]);
flags_struct.stale = 0;
flags_struct.vpruned = 0;

%tree_node = struct('instances',instance,'class_counts',class_count_node,'variables',variable,'left',[0],'right',[0],'next',[0],'best_variable',[0],'flags',[0],'mdl',[0],'variable_name',{});
tree_node = struct('instances',instance,'class_counts',class_count_node,...
    'variables',variable,'parent',0,'left',0,'right',0,'here',1,'next',0,...
    'best_variable',0,'class',0,'flags',flags_struct,'mdl',[0],'variable_name',{},...
    'min_insts_second_majority',0);
%'instances': instance class
%'class_counts': class_count_node class
%'variables': variable class
%'parent': the parent node of the current node
%'left': pointer to left branch
%'right': pointer to right branch
%'next': pointer to next branch
%'best_variable': number of best variable
%'flags': int flags
%'mdl': minimum description length

%initialize tree

tree_node(1).best_variable = NO_BEST_VARIABLE;
tree_node(1).parent = 0;
tree_node(1).left = NULL;
tree_node(1).right = NULL;
tree_node(1).here = 1;
tree_node(1).class = 0;
%tree_node->flags = ~STALE & ~VPRUNED; %not sure what this does, so separating 
%this into structure fields. jbz
%tree_node(1).stale = 0; % stale: true = 1;
%tree_node(1).vpruned = 0; %vpruned: true = 1;
tree_node(1).flags = flags_struct;
tree_node(1).class_counts = NULL;
tree_node(1).mdl = 0.0;
tree_node(1).min_insts_second_majority = 0;


%return tree if this is the designated class
if(strcmp(input_string,'tree_node'))
    outvar = tree_node;
    return;
end

%%%%if we've reached this point, no valid type was specified.
fprintf('\ninvalid type for initialization. initialized to 0.\n');

outvar = 0;








