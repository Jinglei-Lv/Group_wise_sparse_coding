
addpath /home/lv/bin/spm8/

for i=1:size(Pg1,1)
    for j=1:size(Pg1,2)
        Zg1map(i,j)=spm_invNcdf(1-Pg1(i,j));
        Zg2map(i,j)=spm_invNcdf(1-Pg2(i,j));
        Zg3map(i,j)=spm_invNcdf(1-Pg3(i,j));
    end
end

Zg1map(find(isnan(Zg1map)))=0;
Zg2map(find(isnan(Zg2map)))=0;
Zg3map(find(isnan(Zg3map)))=0;

dlmwrite('Zg1map.txt',Zg1map,' ');
dlmwrite('Zg2map.txt',Zg2map,' ');
dlmwrite('Zg3map.txt',Zg3map,' ');

%{
for i=1:400
    Pgnum1(i)=length(find(Pg1(i,:)<0.05));
    Pgnum2(i)=length(find(Pg2(i,:)<0.05));
    Pgnum3(i)=length(find(Pg3(i,:)<0.05));
end

g1ids=find(Pgnum1>500)-1;
g2ids=find(Pgnum2>500)-1;
g3ids=find(Pgnum3>500)-1;

Hg1map=Pg1<0.05;
Hg2map=Pg2<0.05;
Hg3map=Pg3<0.05;

%test=[sum(Hg1map')',sum(Hg2map')',sum(Hg3map')'];
plot([sum(Hg1map')',sum(Hg2map')',sum(Hg3map')']);

dlmwrite('Hg1map.txt',Hg1map,'\t');
dlmwrite('Hg2map.txt',Hg2map,'\t');
dlmwrite('Hg3map.txt',Hg3map,'\t');
dlmwrite('g1ids_start0.txt',g1ids,'\t');
dlmwrite('g2ids_start0.txt',g2ids,'\t');
dlmwrite('g3ids_start0.txt',g3ids,'\t');
%}

