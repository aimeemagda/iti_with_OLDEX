function try_gda_x_times(num_times_to_repeat,dataset,n_xval,root_dir,kernel_type,arg)
%try the gda function n times



try
    run_xvals_gda_randomized(dataset,n_xval,root_dir,kernel_type,arg)
catch
    if(num_times_to_repeat>0)
    try_gda_x_times((num_times_to_repeat-1),dataset,n_xval,root_dir,kernel_type,arg);
    else

    fprintf('\ntried multiple times and could not avoid error.\n');
    rethrow(lasterror);
    end
end

