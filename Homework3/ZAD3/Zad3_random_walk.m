N=100;
while N<=100000
    v=-N:2:N;
    k=10000;
    %Skalowanie z 2^N nie jest dobrym pomyslem (dlugo sie liczy) :)
    %NumofOut=2.^N;
    Dn=0;
    Ln=0;
    Pn=zeros(1,k);
    %NumofOut=N*1000;
    J=0;
    S=0;
    X=0;
    I=0;
    while J<k
        while I<N   %w tej petli liczmy S
            X=randi([0 1],1,1);
            if X==0
                X=-1;
            end
            if S>0
                Dn=1;
            end
            S=S+X;
            if S>0
                Dn=1;
            end
            I=I+1;
            Ln=Ln+Dn;
            Dn=0;
        end
        S=0;
        I=0;
        
        Pn(J+1)=Ln/N;
        Ln=0;
        J=J+1;
    end
    J=0;
    histogram(Pn,'Normalization','pdf');
    title("N = " + N);
    xlabel("Pn");
    ylabel("PDF");
    legend('Random Walk');
    fmt='N%dWykres1';
    saveas(gcf,sprintf(fmt,N),'png')
    saveas(gcf,sprintf(fmt,N),'fig')

    N=N*10;
end
