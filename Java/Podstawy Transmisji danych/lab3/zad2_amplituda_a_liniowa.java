import javax.swing.*;
import java.awt.*;
//import java.lang.Math.*;


public class zad2_amplituda_a_liniowa extends JPanel{

    int A_m=1;
    double k_A=0.8;

    int f_m=2;
    int f_n=32;

    double Fs=16*f_n;




    double poczatek = 0;
    double koniec   = 1;
    double krok     = 1/Fs;
    int ilosc_probek = (int)((Math.abs(koniec-poczatek))/krok);
    static double max_value = 40;//Double.MIN_VALUE;//2;
    static double min_value = -150;//Double.MAX_VALUE;//max_value-max_value-max_value;
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
            g.drawString("" + Fs/2, wymiar.width - 28, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height) + 12);

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

        // obliczenia, wpisanie do tablic
        double x=poczatek;
        for(int i=0;i<ilosc_probek;i++){
            wartosci_X[i] = x;


            //###################### FUNKCJA #####################

            wartosci_Y[i] = //A_m * Math.sin(2*Math.PI*f_m*x);
                    (k_A*(A_m * Math.sin(2*Math.PI*f_m*x))+1)*Math.cos(Math.PI*2*f_n*x);

            //###################### FUNKCJA #####################

            //System.out.println("X="+wartosci_X[i]+"   Y="+wartosci_Y[i]);

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


        for(int i=0;i<ilosc_probek;i++){
            M[i] = Math.sqrt(Math.pow(dft_real[i],2) + Math.pow(dft_imag[i],2));
            Mprim[i] = 10 * Math.log10(M[i]);

            if(Mprim[i]>max_value){
                max_value = Mprim[i];
            }
            if(Mprim[i]<min_value){
                min_value = Mprim[i];
            }

        }


        // rysowanie
        for(int i=0;i<ilosc_probek/2;i++){

            X_ekranu = (int)(((double)i/(ilosc_probek/2))*wymiar.width);
            g.drawLine( X_ekranu,
                    (int)(Math.abs(Mprim[i]-max_value)/wysokosc*wymiar.height),
                    (int)((((double)i+1)/(ilosc_probek/2))*wymiar.width),
                    (int)(Math.abs(Mprim[i+1]-max_value)/wysokosc*wymiar.height));

        }
    }


    public static void main(String[] args){
        JFrame f = new JFrame("Zad 2 a. Widmo modulacji amplitudy");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


        zad2_amplituda_a_liniowa graphics = new zad2_amplituda_a_liniowa();
        f.add(graphics);

        f.setSize(816,440);
        f.setVisible(true);
        f.setResizable(false);
    }

}