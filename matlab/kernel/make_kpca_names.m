function make_kpca_names(namesfile)
%create a names file called 'names.kpca' based on an original names file
%note: ensure first line is classes,and attribute names start on second
%line
%J.Brooks Zurn
%inputs: namesfile: the original names file

fid = fopen(namesfile);
temp=textscan(fid,'%s');
fclose(fid);

temp2=temp{1};
[lines dummy] = size(temp2);


fid2=fopen('names.kpca','w');

fprintf(fid2,'%s\n',temp2{1,1});
for i=2:lines
    fprintf(fid2,'kpca_%s\n',temp2{i,1});
end

fclose(fid2);