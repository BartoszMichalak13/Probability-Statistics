N=5;
%Dla 100 wystarczy zmienic recznie N
while N<=30
    v=-N:2:N;
   
    %Skalowanie z 2^N nie jest dobrym pomyslem (dlugo sie liczy) :)
    %NumofOut=2.^N;
    NumofOut=N*1000;
    values=zeros(1,NumofOut);
    Dystrybuanta=zeros(1,N+1);
    J=0;
    S=0;
    X=0;
    I=0;
    while J<NumofOut
        while I<N   %w tej petli liczmy S
        X=randi([0 1],1,1);
            if X==0
                X=-1;
            end
        S=S+X;
        I=I+1;
        end
        values(J+1)=S;     %dopisujemy S do values
        S=0;
        I=0;
        J=J+1;
    end
    K=2;
    Dystrybuanta(1)=(sum(values==v(1))/J);
    while K<=N+1     %zliczamy ile razy dana wartość wystapila
        Dystrybuanta(K)=Dystrybuanta(K-1)+(sum(values==v(K))/J);
        K=K+1;
    end
    J=0;
    %super mozna zrobic plota i zobaczyc jak to wygląda
    plot(v,Dystrybuanta);
    hold on

    p=normcdf(v);
    plot(v,p);
    
    title("N = " + N);
    xlabel("States");
    ylabel("Values");
    hold off;
    legend('CDF(S)','normCDF');
    fmt='N%dWykres1';
    saveas(gcf,sprintf(fmt,N),'png')
    saveas(gcf,sprintf(fmt,N),'fig')

    N=N+5;
end
