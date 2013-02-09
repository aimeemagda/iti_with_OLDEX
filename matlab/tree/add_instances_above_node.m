function tree = add_instances_above_node(tree,insts,here)
%Add the instance at the node.  Pass it down recursively as appropriate.
%author: Paul Utgoff
%adapted for Matlab by J. Brooks Zurn
%
%inputs:
%tree: node of current tree
%insts: instances structure,
%       insts(i,j).val.symbolic== datatype or symbolic value string
%       insts(i,j).val.numeric == one numerical value: data(i,j)
%       insts(i,j).classname = class of instance
%       insts(i,j).variable_name = name of attribute
%
%outputs:
%tree: new tree with insts incorporated


global NULL
global n_classes
global all_classes
global current_inst_tag %this was incremented in batch train

VERBOSE = 0;
SUPER_VERBOSE = 0;

[num_insts n_variables] = size(insts);
inst_already_appended = 0;

%do this for all instances
if(VERBOSE) fprintf('(add_instances_above_node) begin\n'); end

for i=1:num_insts
    if(SUPER_VERBOSE) fprintf('(add_instances_above_node) inst#%dof%d\n',i,num_insts); end
    
    inst_already_appended = 0;
    tree = send_instance_down(tree,here,insts(i,:));
  
end %end do this for all instances


end
