#include <random>
#include <iostream>
#include <algorithm>
#include <chrono>
#include <fstream>

void writeto(int row[40000])
{
    std::ofstream myfile;
    myfile.open ("data.csv");
    myfile << "Bn;Un;Ln;Cn;Dn;Dn-Cn;n;k\n";
    for(int i = 0; i<5000; i++)
    {
        int itimeseight=i*8;
        for(int j=0; j<8; j++)
            myfile << row[itimeseight+j] << ";"; //later n
        myfile << "\n";
    }
    myfile.close();
}

int main()
{
    auto start = std::chrono::high_resolution_clock::now();//how fast (slow) this program is
    
    int row[40000];
    int n[100]; // numbrer of urns
    for(int i = 0; i<100; ++i)
    {
        n[i]=1000*(i+1);
        std::cout << n[i] <<std::endl;
    }

    int l = 0;
    while(l<100)
    {
        int number=n[l];
        int k=0;//up to 50
        while(k<50)
        {
            int urns[number];
            for(int i = 0; i<number; ++i)
            {
                urns[i]=0;
            }
            int doublecounter=0;//2 balls
            int singlecounter=0;//single ball
            int singleballin=0;//moment when ball goes in
            int twoballsin=0;
            int ballcount=0;//PODPUNKT A
            int emptyurns=0;// PODPUNKT B
            int colisionmoment=0;
            int maxballnumber=0;// PODPUNKT C

            std::mt19937 mt { std::random_device{}()};
            std::uniform_int_distribution<> ourspace{ 0, number - 1};
            while(doublecounter < number)
            { 
                ++ballcount;
                int m = ourspace(mt);
                urns[m]+=1;
                //PODPUNKT D
                if(urns[m] == 1)
                {
                    ++singlecounter;
                    if(singlecounter == number)
                        singleballin=ballcount;
                }
                else if(urns[m] == 2)
                {
                    //PODPUNKT A
                    if(doublecounter==0)
                        colisionmoment=ballcount;//moment of first colision
                    ++doublecounter;
                    //PODPUNKT E
                    if(doublecounter==number)
                        twoballsin=ballcount;
                }
                // PODPUNKT B i C
                if(ballcount==number)
                for(int i = 0; i<number; ++i)
                {
                    
                    maxballnumber=std::max(maxballnumber,urns[i]);
                    if(urns[i]==0)
                        ++emptyurns;
                }
            }   
            //PODPUNKT F
            int CD = twoballsin - singleballin;
            int rl = l * 400;
            int rk = k * 8;
            row[rl+rk]=colisionmoment;
            row[rl+rk+1]=emptyurns;
            row[rl+rk+2]=maxballnumber;
            row[rl+rk+3]=singleballin;
            row[rl+rk+4]=twoballsin;
            row[rl+rk+5]=CD;
            row[rl+rk+6]=number;
            row[rl+rk+7]=k;
            std::cout << "k" << k <<std::endl;
            std::cout << "l" << l <<std::endl;
            
            //do tablic a potem wypisac do pliku jednym rzutem na taśme
            ++k;
        }
        ++l;
    }
    writeto(row);
    auto stop = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
    std::cout << "Time " << duration.count() << "microseconds"<< std::endl; //how fast (slow) this program is
    return 0;
}