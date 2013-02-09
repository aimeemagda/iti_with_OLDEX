function view_iti(tree)
%view an ITI using the classregtree viewer
%author: J. Brooks Zurn
%requires the ITI toolbox and the Statistics Toolbox
%input: tree - an ITI-format decision tree
%output: none


tree = cleanup_for_classregtree(tree);
iti_carttree = convert_iti_to_classregtree(tree);
iti_classregtree = classregtree(iti_carttree);
view(iti_classregtree)