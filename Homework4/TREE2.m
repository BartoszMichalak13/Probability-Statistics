%Generally we create an A matrix of adjacency
%We then check all places where it's equal to 1 (there is an edge)
%and we randomly choose an edge from m-th node
%and we do it again for new node
K=100;          %small K <=> I could not find a way to optimize code
n=100;
Timetable=zeros(((2000/50)-1),K);
while n<=2000
    k=1;
    Fullcovrage = uint32(1):uint32(n);
    %%A = ones(n) - eye(n);   %CLIQUE 
    %A for binary tree is a bit harder to make
    %Simple idea is to count how many many numbers are in fullrows
    %Besides last full row and fill them in 

    A=zeros(n);
    %what we gonna need
    lastfullrow=floor(log2(n));%for n=100 it should be 6
    usednumbers=(2.^(lastfullrow-1))-1;%that is 31 because it's
    %last row with full row beneath it
    
    %so if c>usednumbers we need new method for filling our matrix
    parents=usednumbers+1;%how many nodes
    unused=n-usednumbers-parents;%unused nodes left for las
    %fullLRnodes=floor(unused/2);
    %pnodes=n-fullLRnodes-1;
    %doublechildren=unused1-parents;%how many nodes will have 2 children
       

    %BINARY TREE CREATION 
    
    c=0;
    Q=1;
    d=0;
    for c=1:n
        if c<=usednumbers
            if c==1%first row
                A(1,2)=1;
                A(1,3)=1;
            else%full rows with full row beneath them
                A(c,floor(c/2))=1;%parent node
                A(c,2*c)=1;
                A(c,(2*c)+1)=1;
  
            end
        elseif c<=usednumbers+parents %here we fill last full row
            if unused>0 
                A(c,floor(c/2))=1;
                A(c,2*c)=1;
                if unused>=2
                    A(c,(2*c)+1)=1;
                end

                unused = unused - 2;
            else   
                A(c,floor(c/2))=1;           
            end
        else
            A(c,floor(c/2))=1;
        end
    end
    

    [i,j]=find(A);
    B=[j,i];
    while k<=K  
        startnode=1; 
        
        time=0;
        Coverage=zeros(1,n);
        C=0;
        Coverage(startnode)=startnode;

        while C==0
            [o,p]=find(B(:,1)==startnode);
            Moves=[B(o,2)];
            startnode=Moves(randi([1,size(Moves,1)])); 

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
saveas(gcf,'TREE2.pdf')
saveas(gcf,'TREE2.fig')
