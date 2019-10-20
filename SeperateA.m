clear all

fname='sub___dsize_400_lambda_100_Amat.txt';

A=load(fname);

fname='Voxlenumbers.txt';

vnum=load(fname);

ittt=0
Arnum=[]
for i=1:length(vnum)
    Ai=A(:,ittt+1:ittt+vnum(i))
    ittt=ittt+vnum(i);
    fname=['sub',num2str(i),'_A.txt'];
    fid=fopen(fname,'w');
    for j=1:size(Ai,1)
        for k=1:size(Ai,2)
            fprintf(fid,'%f ', Ai(j,k));
        end
        fprintf(fid, '\n');
    end
    fclose(fid);
    
    for j=1:size(Ai,1)
        Arnum(j,i)=length(find(Ai(j,:)>0));
    end
    
end

fname=['Arnum.txt']
fid=fopen(fname,'w');
for i=1:size(Arnum,1);
    for j=1:size(Arnum,2);
        fprintf(fid,'%d ',Arnum(i,j));
    end
    fprintf(fid, '\n');
end
fclose(fid);
