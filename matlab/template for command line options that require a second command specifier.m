%template to create new command line options for ITI
%important parameters:
%mystring: the command line string argument that triggers this option
%input_string: the command line string argument following mystring that gives
%important information for the option (i.e. filenames, etc).
%
%TO MODIFY:
%1) replace "mystring" with desired command line option name (CASE SENSITIVE)
%2) insert code that depends on "input_string" argument

case 'mystring'
    current_option_string = varargin{current_argument};
    if(((nargin-1) - current_argument)>0)  %make sure the current argument isn't the last one
        current_argument = current_argument + 1;
        if(ischar(varargin{current_argument}))  %ensures the following argument is a string
            input_string = varargin{current_argument};
            
            %%%%%%%%%%%%%%%%%%%insert code here %%%%%%%
            
            
            %%%%%%%%%%%%%%%%%%%end insert code here %%%
        end %end ischar(varargin...
    else
        save datadump_main
        error('error. no input arguments after ''%s''. saving data.\n',current_option_string);
    end
    
    current_argument = current_argument + 1;
    
    %%%%NOTE: if this is the last case in the list, need to append the following:
    %otherwise
        %insert default handling procedure
    %end