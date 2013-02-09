
'l','string1'
    %load a train set from a C4.5 format datafile located in
    %directory filestem
    %note: can specify a file from a subdirectory in filestem
    %by specifying the directory in the command option, 
    %i.e. 'l','special_test_set/test_set'
    %assumes data filename is in format '*.data'
'f'
    %build a tree using fast train mode from a loaded train set
    %not applicable if tree already loaded and trained from *.mat data
'i'
    %build a tree using incremental train mode from a loaded train set
    %not applicable if tree already loaded and trained from *.mat data
'load_mat_train_fast','string1'
    %loads training data from a .mat file and trains it offline
    %training data must be stored in a matrix named
    %'zip_train_data'.  Training classes must be stored in a
    %cell array called 'zip_train_classes
'convert_data_c45_to_mat'  
    %loads training data from C4.5 format file, saves & returns
    %the data in the .mat format used here (zip_train_data
    %numeric array, zip_train_classes cell array).
    %this needs 1 argument after - the string filename of the
    %C4.5 format datafile to read.
'make_mat_xval_sets','string1'
    %take (loaded_ training data), split into cross-validation sets, and
    %save the xval sets to files named 'filename_xval_xx.mat' where xx is
    %the number of the crossvalidation set
    %data is stored in file as 'zip_train_data', 'zip_train_classes',
    %'zip_test_data', and 'zip_test_classes'
    %if data doesn't exist in memory as zip_train_data, program displays
    %a warning, does NOT make xval sets, and continues on.
'I'
    %compute and store the test results instance-by-instance
    %this is not functional yet (2009-0527)
's','string1'
    %save the tree (only!) in a .mat file
    %note: matlab will overwrite file if it exists, without
    %confirmation
'load_mat_test_set','string1'
    %loads test data from a .mat file
    %test data must be stored in a matrix named
    %'zip_test_data'.  Test classes must be stored in a
    %cell array called 'zip_test_classes'
'pass_mat_train_fast',train_data,train_classes
    %loads training data passed to function as an input and trains tree offline
    %this needs TWO arguments after it - train_data and
    %train_classes.  train_data must be a numeric matrix,
    %train_classes a cell array of strings.
'q','string1'
    %load a test set from a C4.5 format datafile located in
    %directory filestem
    %note: can specify a file from a subdirectory in filestem
    %by specifying the directory in the command option, 
    %i.e. 'q','special_test_set/test_set'
    %assumes data filename is in format '*.data'
'pass_mat_test_set',test_data,test_classes
    %loads test data passed in varargin, must be followed by
    %two inputs - the numeric test set data, and the cell array
    %of test set classes
't'
    %test tree using previously loaded test data
    %display results to screen
'T','string1'
    %tests existing tree using previously loaded test set, and 
    %appends the results to a file named 'test.results', 
    %located in the root directory
'r','string1'
    %restore a previously saved tree from a .mat file
    %tree variable in file must be named 'tree'
    %doesn't check whether tree is ITI structure 
    %or classregtree object!!
'F'
    %converts existing tree to classregtree format
    %stores previous tree as iti_tree
    %requires Statistics Toolbox V7.0 (matlab R2008b)
'G'
    %converts iti-format tree to classregtree format, and 
    %displays the tree using a graphical viewer
    %requires Statistics Toolbox V7.0 (matlab R2008b)
'output_type','string1'
    %set the format of the tree output by the iti program
    %based on user input.  
    %NOTE: when it assigns the tree type, it doesn't check
    %whether the tree is a valid member of that type
'names_name','string1'
    %reset the names settings using a different names file
    %Warning: this may affect the class names, number of attributes, and
    %attribute names.