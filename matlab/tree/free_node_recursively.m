function tree = free_node_recursively(tree,node)
%clear a node for reuse
%author: J. Brooks Zurn
%recursively call this node until we get to the bottom of the tree, then
%start clearing the nodes.  Note: this function will remove all data from
%node and all its children; however, you have to remove the original 
%reference to the node yourself, outside of this function!!

if(tree(node).left || tree(node).right) %as long as there's a child node,
                                        %function will be recursively 
                                        %trapped in this 'if' statement
                                        
    if(tree(node).left) %first go to the bottom in the leftward direction
        tree = free_node_recursively(tree,tree(node).left);
    end
    %when at a leaf, there will be no right branch and it will go ahead and
    %clear the leaf. when it returns to the calling function, it will check
    % the right branch and recursively clear that one too.
    if(tree(node).right) 
        tree = free_node_recursively(tree,tree(node).right);
    end
end

%now that we've cleared every child node, clear current node

%clear node
if(tree(node).parent>0)  %if it's the root node (0), leave parent as 0 and leave inst info alone
    
tree(node).instances = [];
tree(node).class_counts = [];
tree(node).variables = [];
tree(node).parent = -1; %the -1 flag on parent node tells get_next_open_node
                        %that this node is free
end                     
                        
                        
tree(node).left = 0;
tree(node).right = 0;
%leave here alone, this is an address. tree(node_to_move).here = ;
tree(node).best_variable = 0;
tree(node).class = 0;
%ignore flags tree(node_to_move).flags = ;
tree(node).variable_name = [];
%leave min_insts_second_majority tree(node_to_move).min_insts_second_majority = 1;



%%%%%try to avoid shape of tree problems
%[dummy tree_size] = size(tree);

%tree = shift_tree_up(tree,here);

%for i=(here+1):tree_size
%    if(tree(i).parent >-1)
        
