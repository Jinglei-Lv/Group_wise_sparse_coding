 
clear

A=[];
Hg1=[];
Pg1=[]

for i=1:15
    fname=['sub',num2str(i),'_A.txt'];
    A(i,:,:)=load(fname);
end

[Hg1,Pg1]=ttest(input);
Hg1=reshape(Hg1,size(Hg1,2),size(Hg1,3));
Pg1=reshape(Pg1,size(Pg1,2),size(Pg1,3));


A={};
Hg2=[];
Pg2=[]

for i=17:31
    fname=['sub',num2str(i),'_A.txt'];
    A{i-16}=load(fname);
end
for i=1:size(A{1},1)
    for j=1:size(A{1},2)
        for k=1:length(A)
            input(k)=A{k}(i,j);
        end
        [Hg2(i,j),Pg2(i,j)]=ttest(input);
    end
end

A={};
Hg3=[];
Pg3=[]

for i=32:44
    fname=['sub',num2str(i),'_A.txt'];
    A{i-31}=load(fname);
end
for i=1:size(A{1},1)
    for j=1:size(A{1},2)
        for k=1:length(A)
            input(k)=A{k}(i,j);
        end
        [Hg3(i,j),Pg3(i,j)]=ttest(input);
    end
end

save all



