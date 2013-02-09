function iti_carttree = convert_iti_to_classregtree(iti_tree)
%takes iti tree and extracts the classregtree format children

[dummy n_nodes] = size(iti_tree); %nodes in ITI tree
[dummy n_vars] = size(iti_tree(1).variables);
%[dummy n_classes] = size(iti_tree(1).class_counts);
%check and make sure all the class counts are the same size
class_counts_sizes = zeros(n_nodes,1);
for i=1:n_nodes
[dummy class_counts_sizes(i,1)] = size(iti_tree(i).class_counts);
end
diff_sizes = unique(class_counts_sizes);
[temp_classes num_sizes] = size(diff_sizes);
if(num_sizes>1)
    error('(convert_iti_to_classregtree) error: inconsistent number of sizes in tree class_counts values\n');
else
    n_classes = diff_sizes;
end
doclass= 1;
%Method = 'ITI';
Method = 'classification';

%get number of nodes that are not orphaned
cart_nodes = 0;
for i=1:n_nodes
    if(iti_tree(i).parent >-1)
        cart_nodes = cart_nodes + 1;
    end
end

% children = zeros(n_nodes,2);
% var = zeros(n_nodes,1);
% cut = zeros(n_nodes,1);
% prunelist = zeros(n_nodes,1);
% node(1:n_nodes,1) = 1:n_nodes;
% parent = zeros(n_nodes,1);
% %class = zeros(n_nodes,1);
% classcounts = zeros(n_nodes,n_classes);

children = zeros(cart_nodes,2);
var = zeros(cart_nodes,1);
%cut = zeros(cart_nodes,1);
cut = cell(cart_nodes,1); %fix for stats toolbox, matlab v2009a student version
prunelist = zeros(cart_nodes,1);
node(1:cart_nodes,1) = 1:cart_nodes;
parent = zeros(cart_nodes,1);
%class = zeros(cart_nodes,1);
classcounts = zeros(cart_nodes,n_classes);


for i=1:n_vars
    names{i}=iti_tree(1).variables(i).variable_key;
end

for i=1:n_classes
    classname{i,1} = iti_tree(1).class_counts(i).key;
end

i_cart = 0;
for i=1:n_nodes
    if(iti_tree(i).parent>-1)
        i_cart = i_cart + 1;

        parent(i_cart,1) = iti_tree(i).parent;
        children(i_cart,1) = iti_tree(i).left;
        children(i_cart,2) = iti_tree(i).right;
        if(iti_tree(i).best_variable)
            var(i_cart,1) = iti_tree(i).best_variable;
              %remove for stats toolbox r2009a student edition
%             if(iscell(iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1}))
%                 cut(i_cart,1) = cell2mat(iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1});
%             else
%                 cut(i_cart,1)=iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1};
%             end

            %fix for stats toolbox in matlab r2009a student version
            if(iscell(iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1}))
                cut(i_cart,1) = cell2mat(iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1});
            else
                cut{i_cart,1}=iti_tree(i).variables(iti_tree(i).best_variable).cutpoint{1,1};
            end
        else
            var(i_cart,1) = 0;
            %cut(i_cart,1) = 0; 
            cut{i_cart,1} = 0; %fix for stats toolbox in matlab r2009a student version
        end
        if(iti_tree(i).class)
            class(i_cart,1) = iti_tree(i).class;
        else
            class(i_cart,1) = 1; %just default it to first class for now
        end


        for j=1:n_classes
            classcounts(i_cart,j)=iti_tree(i).class_counts(j).count;
        end
        %%prunelist: leave as 0's
    end %end if parent>-1
end %end n_nodes

%sort

%node        [cart_nodes x 1]
%parent      [cart_nodes x 1]
%children    [cart_nodes x 2]
%var         [cart_nodes x 1]
%cut         [cart_nodes x 1]
%class       [cart_nodes x 1]
%classcount  [cart_nodes x n_classes]

% [parent_sorted sort_ix] = sort(parent);
% node_sorted = node(sort_ix);
% children_sorted(:,1)=children(sort_ix,1);
% children_sorted(:,2)=children(sort_ix,2);
% var_sorted = var(sort_ix);
% cut_sorted = cut(sort_ix);
% class_sorted = class(sort_ix);
% for i=1:n_classes
%     classcounts_sorted(:,i)=classcounts(sort_ix,i);
% end


%for i=1:n_nodes
%    iti_carttree.children(i) = children(i,:);
%end
%iti_carttree.children = children;
%iti_carttree.var = var;
%iti_carttree.cut = cut;
%iti_carttree.prunelist = prunelist;

iti_carttree.method    = Method;
iti_carttree.node      = node;

iti_carttree.parent    = parent;
iti_carttree.class     = class;
iti_carttree.var       = var;
iti_carttree.cut       = cut;
iti_carttree.children  = children;
% iti_carttree.parent    = parent_sorted;
% iti_carttree.class     = class_sorted;
% iti_carttree.var       = var_sorted;
% iti_carttree.cut       = cut_sorted;
% iti_carttree.children  = children_sorted;

iti_carttree.nodeprob  = zeros(cart_nodes,1);
iti_carttree.nodeerr   = zeros(cart_nodes,1);
iti_carttree.risk      = zeros(cart_nodes,1);
iti_carttree.nodesize  = zeros(cart_nodes,1);
iti_carttree.npred     = n_vars;
iti_carttree.catcols   = [];
iti_carttree.names     = names;
if doclass
   %if ~haveprior, Prior=[]; end
   iti_carttree.prior     = [];
   iti_carttree.nclasses  = n_classes;
   iti_carttree.cost      = [];
   iti_carttree.classprob = zeros(cart_nodes,2);
   iti_carttree.classcount= classcounts;
   %iti_carttree.classcount= classcounts_sorted;
   iti_carttree.classname = classname;
end

%iti_carttree.prunelist(1:n_nodes,1) = n_nodes;  %force no pruning
%iti_carttree.prunelist(1:n_nodes,1) = 14;  %force no pruning