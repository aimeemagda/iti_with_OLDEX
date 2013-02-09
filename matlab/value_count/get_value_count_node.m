function tmp = get_value_count_node()
%* obtain value_count node - avoid malloc
%* author: Paul Utgoff
%modified by J. Brooks Zurn

tmp = initialize_type('value_count_node');

if (free_value_count_nodes)
    tmp = free_value_count_nodes;
    free_value_count_nodes = free_value_count_nodes.next;
    
%else %actually we're going to ignore this since tmp is already allocated
      %in matlab
      %tmp = (value_count_node *) malloc(sizeof(value_count_node));

      %if (!tmp)
      %abort_iti("Error in get_value_count_node, malloc returns NULL");

      %/*
      %n_value_count_nodes_malloced++;
      %printf("%4d value_count_nodes malloced\n",n_value_count_nodes_malloced);
      %*/
      %end
 end

