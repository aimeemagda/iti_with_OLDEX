function print_instance(inst)
%* Print the instance - for debugging.
% * author: Paul Utgoff
%modified by J. Brooks Zurn

[instances n_variables] = size(inst);

  fprintf('%s',inst.classname);
  for i=1:n_variables
    fprintf(' %s=',inst(1,1).variable_name{i});

      if (strcmp(inst.val(1,i).symbolic,'NUMERIC'))
	fprintf('%5.3f',inst(1,i).val.numeric);
      elseif (strcmp(inst(1,i).val.symbolic,'MISSING'))
	fprintf('?');
      else
	fprintf('%s',inst(1,i).val.symbolic);
      end
      fprintf('\n');
  end
  
