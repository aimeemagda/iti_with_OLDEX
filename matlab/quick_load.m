function tree = quick_load(filename,tree,n_training_insts,n_variables,n_classes,all_classes)
%quick load data from C4.5 format file into top node of tree (here ==1)
%author: J. Brooks Zurn

%fast load for fast_train

%set 'train_fname'
%train_fname = sprintf('zip_train_data_%s_x%d_y%d_c%d',kernel_type,current_x,current_y,const);
%load correct test data set
%[data,classes] = load_C45(train_fname,n_training_insts,n_variables);
[data,classes] = load_C45(filename,n_training_insts,n_variables);

%[n_training_insts n_variables] = size(data);

numeric_value_counts = cell(1,n_variables);
num_vals_by_variable = zeros(1,n_variables);

for i=1:n_variables
    numeric_vals = unique(data(:,i));
    [num_vals dummy]=size(numeric_vals);
    %     class_counts=zeros(num_vals,1);
    %     for j=1:num_vals
    %     class_counts(j,1)=sum(numeric_vals(j,1)==zip_train_data(:,i));
    %     end
    numeric_value_counts{i}=num2cell(numeric_vals');
    num_vals_by_variable(i)=num_vals;
end

%split set by class
split_class_counts = cell(1,n_classes);
split_class_counts_tags = cell(1,n_classes);
split_class_nvc = cell(1,n_classes);
class_totals = zeros(1,n_classes);
ix = (1:n_training_insts)';
for i=1:n_classes
    class1 = strcmp(classes,all_classes{i});
    class_totals(i) = sum(class1);
    data_class1 = data(class1,:);
    data_class1_ix = ix(class1,:);
    this_class_nvc = cell(1,n_variables);
    this_class_cc = cell(1,n_variables);
    this_class_cct = cell(1,n_variables);
    for j=1:n_variables
        numeric_vals = unique(data_class1(:,j));
        [num_vals dummy]=size(numeric_vals);
        this_class_nvc{j}=num2cell(numeric_vals');
        
        temp_class_counts=zeros(num_vals,1);
        temp_class_counts_tags = cell(1,num_vals);
        for k=1:num_vals
            temp_this_val = numeric_vals(k,1)==data_class1(:,j);
            temp_class_counts(k,1)=sum(temp_this_val);
            temp_class_counts_tags{k}=data_class1_ix(temp_this_val,1)';
        end
        this_class_cc{j}=num2cell(temp_class_counts');
        this_class_cct{j} = temp_class_counts_tags;
    end
    split_class_counts{i}=this_class_cc;
    split_class_counts_tags{i}=this_class_cct;
    split_class_nvc{i}=this_class_nvc;
    
end

%put the class counts for each class on separate rows
all_class_counts = cell(1,n_variables);
all_class_counts_tags = cell(1,n_variables);

for i=1:n_variables
    all_vals = cell2mat(numeric_value_counts{i});
    all_num_vals = num_vals_by_variable(i);
    this_var_all_class_counts = zeros(n_classes,all_num_vals);
    this_var_all_class_counts_tags = cell(n_classes,all_num_vals);
    
    for j=1:n_classes
        this_class_vals_temp = split_class_nvc{j};
        class_vals = cell2mat(this_class_vals_temp{i});
    
        [intersect_vals all_vals_ix class_vals_ix] = intersect(all_vals,class_vals);
        
        this_class_counts_temp = split_class_counts{j};
        this_class_counts_tags_temp = split_class_counts_tags{j};
        this_class_counts = cell2mat(this_class_counts_temp{i});
        this_class_counts_tags = this_class_counts_tags_temp{i};
        
        [dummy this_class_num_vals] = size(all_vals_ix);
        for k=1:this_class_num_vals
            this_var_all_class_counts(j,all_vals_ix(k))=this_class_counts(1,class_vals_ix(k));
            this_var_all_class_counts_tags(j,all_vals_ix(k))=this_class_counts_tags(1,class_vals_ix(k));
            
        end
    end %end n_classes
    all_class_counts{i} = num2cell(this_var_all_class_counts);
    all_class_counts_tags{i} = this_var_all_class_counts_tags;
end %end for n_variables

%now we have all vals and counts, load them into tree

for i=1:n_variables
    tree(1).variables(i).class_counts = all_class_counts{i};
    tree(1).variables(i).class_counts_tags = all_class_counts_tags{i};
    tree(1).variables(i).numeric_value_counts = numeric_value_counts{i};
end

for i=1:n_classes
    tree(1).class_counts(i).count=class_totals(i);
end
