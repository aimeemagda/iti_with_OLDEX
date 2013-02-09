iti_with_OLDEX
==============

ITI implemented in matlab, with online context identifier OLDEX

Usage:
-------------------------------
TO RUN ITI:

filestem = 'C:\Users\YOUR_USERNAME_HERE\Documents\MATLAB\iti_with_OLDEX\pima\';
dataset = 'pima';
filename = strcat(filestem,dataset);

load(filename,'zip_train_data','zip_train_classes'); 
tree_original = iti(filestem,'pass_mat_train_fast',zip_train_data,zip_train_classes);
view_iti(tree_original)  %%PLOTTING THE TREE REQUIRES MATLAB STATISTICS TOOLBOX

TO RUN OLDEX:

[tree_oldex_1,tree_oldex_2] = OLDEX(filename)

-------------------------------

Notes:

OLDEX is described in the following open-access paper.  Here, the implementation is hard-coded for two trees.
http://journals.cambridge.org/repo_A84w3rW2 

The ITI matlab program creates EXACTLY the same decision tree as ITI (http://www-lrn.cs.umass.edu/iti/index.html) for multiclass, numerical (not symbolic) data.  I have not tested it for missing values.  

In ITI, the two most important processes influencing tree structure are (1) variable and cut value selection via the KS distance, and (2) recursive tree restructuring after new data is incorporated.  Both these processes are REQUIRED to produce the same tree as ITI.

Notes: ITI produces EXACTLY the same tree on-line AND off-line, so comparing test results for the online tree vs. the offline tree only makes sense for comparing cpu time.   I have not yet implemented incremental accuracy testing.

Changes in this version:
-to increase the amount of data the program can process without crashing, the size of the tree structure has been reduced by separating it into multiple variables.  Later, this will be addressed by removing the redundancy of the data.


Known bugs:

-convert_iti_to_classregtree: this only creates a viewable tree when invoked internally in iti() using 'G'.  As of 2009-0530 it doesn't work for trees returned externally when the tree = iti(...) command is invoked.

-convert_iti_to_classregree: results are unreliable when data has numeric classnames, even when the classnames are referenced as strings.  avoid by assigning string class names instead of numbers (make sure they have same labels in 'names').  A cell array of string numbers 0-9 can be converted to the written names (zero, one, ...) using the function get_distribution()

