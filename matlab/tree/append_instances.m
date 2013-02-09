function tree = append_instances(tree,here,insts,num_insts)
%append instance to leaf node
%J. Brooks Zurn
%tree
%here: current node
%insts: insts to append to current node
%num_insts: number of instances to append



if(array_is_empty(tree(here).instances))
    tree(here).instances = insts;
else
    tree(here).instances = vertcat(tree(here).instances(:,:),insts(:,:));
end
