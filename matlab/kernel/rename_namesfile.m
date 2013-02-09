function  rename_namesfile(namesfile)
%rename the input filename as 'names' (no extension), for use with ITI
%do not prompt to overwrite
%J. Brooks Zurn
%inputs: namesfile: the name of the file to be renamed 'names' 

fid = fopen(namesfile);
temp=textscan(fid,'%s');
fclose(fid);

temp2=temp{1};
[lines dummy] = size(temp2);


fid2=fopen('names','w');

for i=1:lines
    fprintf(fid2,'%s\n',temp2{i,1});
end

fclose(fid2);