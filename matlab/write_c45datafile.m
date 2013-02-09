function write_c45datafile(data,classes,out_directory,filename)
%writes out data to iti format files
%program will write to filename.data
%
%data: [instances x (augmented) attributes]
%classes: [n x 1] cell array of string format names
%out_directory: directory to put iti files in
%filename: stem for iti file 

[instances attributes] = size(data);

writeout_string = '';

fid = fopen(sprintf('%s%s.data',out_directory,filename),'w');

for i=1:instances
    writeout_string = '';
    for j=1:attributes
        writeout_string = strcat(writeout_string,sprintf('%s,',num2str(data(i,j))));
    end
    writeout_string = strcat(writeout_string,sprintf('%s.',classes{i,1}));
    fprintf(fid,writeout_string);
    fprintf(fid,'\n');
end

fclose(fid);


    
    