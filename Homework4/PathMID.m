%Generally we create an A matrix of adjacency
%We then check all places where it's equal to 1 (there is an edge)
%and we randomly choose an edge from m-th node
%and we do it again for new node

%You may see that I changed approach written above
%as calculating all potential neighbours was proven
%(at least for me) to be quite bad considering run time
%of this program. 
K=100;           %small K <=> I could not find a way to optimize code
                %or computations involved are really nasty
n=100;
Timetable=zeros(((2000/50)-1),K);
while n<=2000
    k=1;
    Fullcovrage = uint32(1):uint32(n);
    %%A = ones(n) - eye(n);   %CLIQUE 
    fill=ones(1,n);
    A = diag(fill,-1)+diag(fill,1);         %Path
    while k<=K  
        %FOR PATH STARTING IN THE MIDDLE UNCOMMENT 2ND LINE AND COMMENT 1ST
        %FOR PATH STARTING AT THE END DO THE OPPOSITE
        %startnode=1; 
        startnode=n/2; 

        time=0;
        Coverage=zeros(1,n);
        C=0;
        Coverage(startnode)=startnode;

        while C==0

            if startnode==1 
                startnode=startnode+1;
            elseif startnode==n 
                startnode=startnode-1;
            else
                node=round(rand);    %gen random node
                if node==0
                    node=-1;
                end
                startnode=startnode + node;
            end
            Coverage(startnode)=startnode;
            C=isequal(Coverage,Fullcovrage);%if equal then we visited all nodes
            time=time + 1;
        end
        Timetable(((n/50)-1),k)=time;
        k=k+1;
    end
    n=n+50;
end
avgtime=mean(Timetable,2);%mean of a row
N=linspace(100,2000,39);
figure(1)
scatter(N,Timetable,5,"blue",'filled')
hold on
scatter(N,avgtime,10,"red",'filled')
hold off
saveas(gcf,'PATHMID.pdf')
