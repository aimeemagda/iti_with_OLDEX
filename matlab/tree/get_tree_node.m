function tree = get_tree_node(tree,n_variables,n_classes,here)
%obtain a tree node
%author: Paul Utgoff
%modified by J. Brooks Zurn
%insts: number of instances in data set
%tmp: empty tree node, ready to go.

%in order to set the number of variables at runtime, need to initialize a
%structure of the appropriate size, -then- assign n of these structures
%into the tree array.  this process is necessary for each array whose size
%is set at runtime.

%first set up one prototype variable array
tmpvar = initialize_type('variable');

%each variable array will need n_classes spaces to store class_counts
%have to first initialize an array of size n_classes, then copy it 
%into variable prototype
tmpclass = zeros(n_classes,1);

%now put the n_classes size array into the variable prototype
tmpvar(1).class_counts = num2cell(tmpclass);


%check and see if the tree has been initialized yet. if not, 'here' will be
%the first node (1) and the variables must be assigned differently (due to
%matlab variable assignment procedures)
if(here == 1)

    tmp = initialize_type('tree_node');
    tmp.here = here;

    %set the number of variables at runtime
    for i=1:n_variables
        tmp(1).variables(i)=tmpvar;
    end
    
    %copy this entire temp array to the tree.
    tree=tmp;
else
    
    %if the tree has already been initialized (here>1), we cannot simply
    %create a temp array and assign it to the tree, because of mismatched
    %size issues.  so we will initialize another element in the already
    %created tree structure, and put the correct number of variables into
    %it.
    tree(here)=initialize_type('tree_node');
    tree(here).here = here;
 
    for i=1:n_variables
        tree(here).variables(i)=tmpvar;
    end
    
end


