import javax.swing.*;
import java.awt.*;

import static java.sql.Types.NULL;
//import java.lang.Math.*;


public class zad3_kat_b_log extends JPanel{

    int A_m=1;
    double k_P= 3;

    int f_m=2;
    int f_n=32;

    double f_min = NULL;
    double f_max = NULL;

    double Fs=16*f_n;




    double poczatek = 0;
    double koniec   = 1;
    double krok     = 1/Fs;
    int ilosc_probek = (int)((Math.abs(koniec-poczatek))/krok);
    static double max_value = 50;//Double.MIN_VALUE;//2;
    static double min_value = -200;//Double.MAX_VALUE;//max_value-max_value-max_value;
    double wysokosc = Math.abs(min_value-max_value);
    double wartosci_X[] = new double[(int) ilosc_probek];
    double wartosci_Y[] = new double[(int) ilosc_probek];


    int X_ekranu = 0;
    int Y_ekranu = 0;


    public void paintComponent(Graphics g){

        super.paintComponent(g);
        this.setBackground(Color.lightGray);

        Dimension wymiar = getSize();

        // Oś X
        {
            g.drawString("Hz", wymiar.width - 18, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height));
            g.drawString("" + poczatek, 0, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height) + 12);
            //g.drawString("" + Fs/2, wymiar.width - 28, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height) + 12);

            g.drawLine( 0,
                    (int)(Math.abs(0-max_value)/wysokosc*wymiar.height),
                    wymiar.width,
                    (int)(Math.abs(0-max_value)/wysokosc*wymiar.height));
        }

        // Oś Y
        {
            g.drawString("db  " + max_value, (int)(Math.abs(poczatek)/Math.abs(koniec-poczatek)*wymiar.width), 12);
            g.drawString("" + (min_value), (int)(Math.abs(poczatek)/Math.abs(koniec-poczatek)*wymiar.width) + 8, wymiar.height);

            if(poczatek<0){
                g.drawLine((int)(Math.abs(poczatek)/Math.abs(koniec-poczatek)*wymiar.width),
                        0,
                        (int)(Math.abs(poczatek)/Math.abs(koniec-poczatek)*wymiar.width),
                        wymiar.height);
            }
        }




        //####### OBLICZANIE WARTOSCI FUNKCJI ########

        g.setColor(Color.blue);
        double y=0;
        double[] logarytmiczna = new double[(int) ilosc_probek];
        int granica = 1;
        int licznik = 2;
        int mnoznik = 1;
        boolean zmiana = false;
        g.setColor(Color.gray);


        // obliczenia, wpisanie do tablic
        double x=poczatek;
        for(int i=0;i<ilosc_probek;i++){
            // skala od 1 do 10000, Fs/4 iteracji na przejscie 10^0 -> 10^1. skala log

            // wszystkie wartosci tablicy.
            logarytmiczna[i] = Math.pow(10,(double)i/(Fs/4));
            if(logarytmiczna[i]>=granica){

                // przekroczylo kolejna wartosc, narysuj linie
                g.drawLine( (int)(((double)i/ilosc_probek)*wymiar.width),
                        0,
                        (int)(((double)i/ilosc_probek)*wymiar.width),
                        wymiar.height);

                // podpisanie wartosci na skali log.
                if(zmiana) {
                    g.drawString("" + (int) logarytmiczna[i], (int) (((double) i / ilosc_probek) * wymiar.width), wymiar.height);
                    zmiana = false;
                }
                else{
                    zmiana = true;
                    g.drawString("" + (int) logarytmiczna[i], (int) (((double) i / ilosc_probek) * wymiar.width), wymiar.height-10);
                }

                // wyznaczenie nastepnego punktu do narysowania lini
                granica = licznik * mnoznik;
                licznik++;
                if(licznik%10==0){
                    licznik=1;
                    mnoznik *= 10;
                }

            }

            //###################### FUNKCJA #####################

            wartosci_Y[i] =  Math.cos(Math.PI*2*f_n*x + k_P*A_m * Math.sin(2*Math.PI*f_m*x));



            //###################### FUNKCJA #####################


            x += krok;
        }

        // DFT
        double[] dft_real = new double[(int) ilosc_probek];
        double[] dft_imag = new double[(int) ilosc_probek];
        int N = ilosc_probek;


        long startTime_dft = System.nanoTime();

        for (int k = 0; k < N; k++) {
            double suma_real = 0;
            double suma_imag = 0;
            for (int n = 0; n < N; n++) {
                double angle = 2 * Math.PI * k * n / N;
                suma_real +=  wartosci_Y[n] * Math.cos(angle) + wartosci_Y[n] * Math.sin(angle);
                suma_imag += -wartosci_Y[n] * Math.sin(angle) + wartosci_Y[n] * Math.cos(angle);
            }
            dft_real[k] = suma_real;
            dft_imag[k] = suma_imag;

        }

        long stopTime_dft = System.nanoTime();
        long duration_dft = stopTime_dft - startTime_dft;
        //duration = TimeUnit.SECONDS.convert(duration, TimeUnit.NANOSECONDS);
        System.out.println("Czas: " + duration_dft/1000000 + "[ms]");

        //widmo aplitudowae M(k)
        double[] M = new double[(int) ilosc_probek];
        //skala decybelowa
        double[] Mprim = new double[(int) ilosc_probek];


        for(int i=0;i<ilosc_probek/2;i++){
            M[i] = Math.sqrt(Math.pow(dft_real[i],2) + Math.pow(dft_imag[i],2));
            Mprim[i] = 10 * Math.log10(M[i]);

            if(Mprim[i]>max_value){
                max_value = Mprim[i];
            }
            if(Mprim[i]<min_value){
                min_value = Mprim[i];
            }

            if(Mprim[i]>-3){
                f_max = i;

                if(f_min == NULL){
                    f_min = i;
                }

                System.out.println("i= "+i+"  fmin= "+f_min+"  fmax= "+f_max);
            }



        }

        // rysowanie granic fmin, fmax
        {
            g.setColor(Color.red);
            // -3db
            g.drawLine( 0,
                    (int)(Math.abs(-3-max_value)/wysokosc*wymiar.height),
                    wymiar.width,
                    (int)(Math.abs(-3-max_value)/wysokosc*wymiar.height));


            int i = 0;
            int j = 0;
            while(logarytmiczna[i] < f_min){
                //System.out.println(i+"= "+logarytmiczna[i]);
                i++;
            }
            while(logarytmiczna[j] < f_max){
                j++;
            }

            g.drawLine((int) ((double)i/ilosc_probek*wymiar.width),
                    0,
                    (int) ((double)i/ilosc_probek*wymiar.width),
                    wymiar.height);

            g.drawLine((int) ((double)j/ilosc_probek*wymiar.width),
                    0,
                    (int) ((double)j/ilosc_probek*wymiar.width),
                    wymiar.height);
        }


        g.setColor(Color.blue);

        // rysowanie
        int j = 0;
        int k = 0;

        // wartosci szerokosci: od 0 do 800 . aktualna pozycja liniowa - (int)(((double)i/(ilosc_probek/2))*wymiar.width)
        // wartosci log:        od 1 do 10000

        for(int i=0;i<(ilosc_probek/2)-1;i++){
            j=0;k=0;
            //dopasowanie wartosci liniowej do log. znalezienie indeksu
            while(logarytmiczna[j]<i){
                j++;
            }

            while(logarytmiczna[k]<(i+1)){
                k++;
            }

            g.drawLine((int) (((double) j / ilosc_probek) * wymiar.width),
                    (int)(Math.abs(Mprim[i]-max_value)/wysokosc*wymiar.height),
                    (int) (((double) k / ilosc_probek) * wymiar.width),
                    (int)(Math.abs(Mprim[i+1]-max_value)/wysokosc*wymiar.height)
            );
        }

        System.out.println("fmin:"+f_min);
        System.out.println("fmax:"+f_max);
        System.out.println("pasmo:"+(f_max-f_min));
    }


    public static void main(String[] args){
        JFrame f = new JFrame("Zad 3 b. Widmo modulacji kąta log");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


        zad3_kat_b_log graphics = new zad3_kat_b_log();
        f.add(graphics);

        f.setSize(816,440);
        f.setVisible(true);
        f.setResizable(false);

    }

}