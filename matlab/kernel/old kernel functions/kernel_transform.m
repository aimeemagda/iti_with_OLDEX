function result = kernel_transform(kernel_type,a,b,c)
%perform a kernel transform on a pair of variables
%the actual equations for the kernels were based on stprtool, file
%kernel_fun.c
%http://cmp.felk.cvut.cz/cmp/software/stprtool/
%
%author: J. Brooks Zurn
%inputs:
%kernel_type: the type of kernel transform to perform
%a,b: the two input matrices
%c: a constant relevant to the kernel equation (if applicable)
%   for linear kernel, c isn't used
%   for polynomial kernel, c is a 1x2 array [c1 c2]
%   for rbf kernel, c is a scalar
%   for tanh kernel, c is a 1x2 array [c1 c2]

%outputs:
%result: the result of the kernel function

switch kernel_type
    case 'linear'
        %a'*b
        result = dot(a,b);
    case 'polynomial'
        %(a'*b+arg[2])^arg[1]
        result = power(dot(a,b)+c(2),c(1));
    case 'rbf'
        %exp(-0.5*||a-b||^2/c^2)
        result = exp( -0.5*(dot(a-b,a-b))/(c*c) ); %as in stprtool file kernel_fun.c
    case 'sigmoid'
        %tanh(arg[1]*(a'*b)+arg[2])
        result = tanh(c(1)*dot(a,b) + c(2));
    case 'custom'
        %user-defined kernel.  here, a simple linear kernel.
        result = dot(a,b);
        
    otherwise
        fprintf('error: invalid kernel type %s. no kernel transform performed./n',kernel_type);
end

          