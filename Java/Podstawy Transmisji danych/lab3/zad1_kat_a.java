import javax.swing.*;
import java.awt.*;
//import java.lang.Math.*;


public class zad1_kat_a extends JPanel{

    int A_m=1;
    double k_P= 1.5;

    int f_m=2;
    int f_n=32;

    double Fs=16*f_n;

    double poczatek = 0;
    double koniec   = 1;
    double krok     = 1/Fs;
    int ilosc_probek = (int)((Math.abs(koniec-poczatek))/krok);
    static double max_value = 2;
    static double min_value = -2;
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
            g.drawString("X", wymiar.width - 9, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height));
            g.drawString("" + poczatek, 0, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height) + 12);
            g.drawString("" + koniec, wymiar.width - 22, (int)(Math.abs(0-max_value)/wysokosc*wymiar.height) + 12);

            g.drawLine( 0,
                    (int)(Math.abs(0-max_value)/wysokosc*wymiar.height),
                    wymiar.width,
                    (int)(Math.abs(0-max_value)/wysokosc*wymiar.height));
        }

        // Oś Y
        {
            g.drawString("Y  " + max_value, (int)(Math.abs(poczatek)/Math.abs(koniec-poczatek)*wymiar.width) - 9, 12);
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
            //x = i/(double)ilosc_probek * wymiar.width;
            wartosci_X[i] = x;



            //###################### FUNKCJA #####################
            // sygnal informacyjny:     A_m * Math.sin(2*Math.PI*f_m*x);
            // modulacja amplitudy:     (k_A*(A_m * Math.sin(2*Math.PI*f_m*x))+1)*Math.cos(Math.PI*2*f_n*x);;
            wartosci_Y[i] =  Math.cos(Math.PI*2*f_n*x + k_P*A_m * Math.sin(2*Math.PI*f_m*x));


            //###################### FUNKCJA #####################


            x = poczatek + i/Fs;
            //x += krok;
            if(wartosci_Y[i]>max_value){
                max_value = wartosci_Y[i];
            }
            if(wartosci_Y[i]<min_value){
                min_value = wartosci_Y[i];
            }

            System.out.println("I: "+i+"  X="+wartosci_X[i]+", Y="+wartosci_Y[i]);


        }



        // rysowanie
        for(int i=0;i<ilosc_probek-1;i++){
            X_ekranu = (int)(((double)i/(ilosc_probek))*wymiar.width);
            g.drawLine( X_ekranu,
                    (int)(Math.abs(wartosci_Y[i]-max_value)/wysokosc*wymiar.height),
                    (int)((((double)i+1)/(ilosc_probek))*wymiar.width),
                    (int)(Math.abs(wartosci_Y[i+1]-max_value)/wysokosc*wymiar.height));

        }
    }


    public static void main(String[] args){

        JFrame f = new JFrame("Zad 1 a. Modulacja kąta");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        zad1_kat_a graphics = new zad1_kat_a();
        f.add(graphics);

        f.setSize(816,440);
        f.setVisible(true);
        f.setResizable(false);
    }

}