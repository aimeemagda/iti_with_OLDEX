function tmp = get_class_count_node()
%* obtain class_count node - avoid malloc
%* author: Paul Utgoff
%modified by J. Brooks Zurn

tmp = initialize_type('class_count_node');

%%% ignore this until have a way to record and pass free nodes
%if (free_class_count_nodes)
%    { tmp = free_class_count_nodes;
%      free_class_count_nodes = free_class_count_nodes->next;
%    }
%  else
%    { tmp = (class_count_node *) malloc(sizeof(class_count_node));

%      if (!tmp)
%	abort_iti("Error in get_class_count_node, malloc returns NULL");

