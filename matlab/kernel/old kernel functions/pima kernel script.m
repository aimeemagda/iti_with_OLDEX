
filestem = 'pima';

%for i=0.1:0.1:100
for i=1:10:100
    const = i;
    const
    
    train_fname = sprintf('pima_kernel_const%3.3f',const);
    iti_out = iti(filestem,'kernel_pass_mat_train_fast','rbf',const,zip_train_data,zip_train_classes,'kernel_pass_mat_test_set',zip_test_data,zip_test_classes,'T',train_fname);
    
end