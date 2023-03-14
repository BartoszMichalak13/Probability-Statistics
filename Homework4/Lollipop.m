%Generally we create an A matrix of adjacency
%We then check all places where it's equal to 1 (there is an edge)
%and we randomly choose an edge from m-th node
%and we do it again for new node

%You may see that I changed approach written above
%as calculating all potential neighbours was proven
%(at least for me) to be quite bad considering run time
%of this program. 
K=5;          %small K <=> I could not find a way to optimize code
n=100;
Timetable=zeros(((2000/50)-1),K);
while n<=2000
    k=1;
    Fullcovrage = uint32(1):uint32(n);
    m=floor((2/3)*n);
    A = zeros(n);
    A(1:m,1:m) = ones(m) - eye(m);   %CLIQUE 
    p=n-m;
    fill=ones(1,p-1);
    C = diag(fill,-1)+diag(fill,1);    %path
    A(m+1:n,m+1:n) = diag(fill,-1)+diag(fill,1);
    %we just need to connect CLIQUE to PATH
    A(m,m+1)=1;
    A(m+1,m)=1;
    while k<=K  
        startnode=randi([1,m-1]);
        time=0;
        Coverage=zeros(1,n);
        C=0;
        Coverage(startnode)=startnode;  %because where we started
        %is also where we have been
        while C==0
            if startnode==n 
                startnode=startnode-1;
            elseif startnode>m
                node=round(rand);    %gen random node
                if node==0
                    node=-1;
                end
                startnode=startnode + node;
            elseif startnode==m
                node=randi([1,m+1]);          %gen random node
                while node==startnode       %if it's same as current
                    node=randi([1,m+1]);      %gen random node
                end
                startnode=node;
            else
                node=randi([1,m]);          %gen random node
                while node==startnode       %if it's same as current
                    node=randi([1,m]);      %gen random node
                end
                startnode=node;
            end
            %startnode=node;

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
saveas(gcf,'Lollypop.pdf')
saveas(gcf,'Lollypop.fig')
