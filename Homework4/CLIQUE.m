%Generally we create an A matrix of adjacency
%We then check all places where it's equal to 1 (there is an edge)
%and we randomly choose an edge from m-th node
%and we do it again for new node

%You may see that I changed approach written above
%as calculating all potential neighbours was proven
%(at least for me) to be quite bad considering run time
%of this program. 
K=1000;          %small K <=> I could not find a way to optimize code
n=100;
Timetable=zeros(((2000/50)-1),K);
while n<=2000
    k=1;
    Fullcovrage = uint32(1):uint32(n);
    A = ones(n) - eye(n);   %CLIQUE 
    while k<=K  
        startnode=randi([1,n]);
        time=0;
        Coverage=zeros(1,n);
        C=0;
        Coverage(startnode)=startnode;  %because where we started
        %is also where we have been
        while C==0
            %here I used to check for neighbours, but code was VERY slow
            %so instead (as we work on CLIQUE) we know each node is 
            %connected to every other node

            node=randi([1,n]);          %gen random node
            while node==startnode       %if it's same as current
                node=randi([1,n]);      %gen random node
            end
            startnode=node;

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
saveas(gcf,'CLIQUE.pdf')
