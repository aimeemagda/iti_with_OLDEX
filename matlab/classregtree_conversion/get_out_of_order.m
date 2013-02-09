function out_of_order_ix = get_out_of_order(tree2_fixed)
%get a list of nodes for which the children have lower addresses than
%their parents.  used by cleanup_for_classregtree
%author: J. Brooks Zurn
%inputs: 
%tree2_fixed: a tree with all empty nodes removed
%outputs: 
%out_of_order_ix: a list containing indices of 'out of order' nodes

[dummy tree2_size] =size(tree2_fixed);
out_of_order = zeros(tree2_size,1);

%figure out how many nodes are out of order
for i=1:tree2_size
   if(tree2_fixed(i).parent>0)
       if(tree2_fixed(i).parent > i)
           out_of_order(i,1) = 1;
       end
   end
end
%get locations of out_of_order nodes

out_of_order_ix = find(out_of_order);