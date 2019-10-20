clear all
 
addpath /usr/local/spams-matlab/2.3/build

setenv('MKL_NUM_THREADS','1')
setenv('MKL_SERIAL','YES')
setenv('MKL_DYNAMIC','NO')



    
    path=['.'];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Load Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    x=[]
    vnum=[]
    for subid=1:44
        
        fname=['../Whole_b_signals_AHu_std334/',num2str(subid),'_std334_whole_b_signals.txt'];

        xtest=load(fname);
	x=[x;xtest];
	vnum=[vnum,size(xtest,1)];
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Normalize %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %
        x=x'
        xmean=mean(x);
        stdx=std(x);
        for i=1:size(x,1)
            x(i,:)=(x(i,:)-xmean)./stdx;
        end
  %%%%%%%%%%%%%%%%%%%%%%%%%%% D learning    %%%%%%%%%%%%%%%%%%%%%%%%%%
        for lanmda=100
            for dsize=20
                lan=lanmda/100;
                ds=(dsize)*10;
                    
                param.K=ds;  % learns a dictionary with ds elements
                param.lambda=lan;
                param.numThreads=7; % number of threads
                param.batchsize=500;
                param.iter=10000;
                param.posAlpha=true;
                tic
                D = mexTrainDL(x,param);
                t=toc;
                sprintf('time of computation for Dictionary Learning: %f\n',t);

                param.mode=2;
                param.lambda=lan;
                param.lambda2=0;
                param.pos=true;
                param.numThreads=7; % number of processors/cores to use; the default choice is -1
                                % and uses all the cores of the machine

                sprintf('Evaluating cost function...\n');
                tic
        %%%%%%%%%%%%%%%%%%%%  A learning %%%%%%%%%%%%%%%%%%%%%
                A=mexLasso(x,D,param);
                toc
                sprintf('time of computation for parsecoding: %f\n',t);
                A=full(A);
                D=full(D);
                
                R1=mean(0.5*sum((x-D*A).^2));
                R2=mean(param.lambda*sum(abs(A)));
                R=[R1,R2];
                

                fname=[path,'/sub_','_dsize_',num2str(dsize*10),'_lambda_',num2str(lanmda),'_Dmat.txt']
                fid=fopen(fname,'w');
                
                for i=1:size(D,1)
                    for j=1:size(D,2)
                        fprintf(fid,'%f ',D(i,j));
                    end
                    fprintf(fid,'\n');
                end
                fclose(fid);



                fname=[path,'/sub_','_','_dsize_',num2str(dsize*10),'_lambda_',num2str(lanmda),'_Amat.txt']
                fid=fopen(fname,'w');
                
                for i=1:size(A,1)
                    for j=1:size(A,2)
                        fprintf(fid,'%f ',A(i,j));
                    end
                    fprintf(fid,'\n');
                end
                fclose(fid);

                fname=[path,'/','sub_','_R.txt']
                fid=fopen(fname,'w');
                for i=1:size(R,1)
                    for j=1:size(R,2)
                        fprintf(fid,'%f ',R(i,j));
                    end
                    fprintf(fid,'\n');
                end
                fclose(fid);

            end %end of dsize
        end %end of lambda
 
	        fname=[path,'/','Voxlenumbers.txt']
                fid=fopen(fname,'w');
                for i=1:length(vnum)
		   fprintf(fid,'%d ',vnum(i));
		end
		fclose(fid);





