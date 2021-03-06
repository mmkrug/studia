// PTD Lab4, modulacja cyfrowa ASK

import javax.swing.*;
import java.awt.*;

import static java.sql.Types.NULL;
//import java.lang.Math.*;


public class psk extends JPanel{

    int A_1 = 1;
    int A_2 = 2;
    int T_b = 2; // 2 okresy
    int N = 2;

    double f_min = NULL;
    double f_max = NULL;

    double f_n1=(N+1)/T_b;
    double f_n2=(N+2)/T_b;
    double f_n = N * 1/T_b;

    double Fs=16*f_n;

    int bity[] = {0,1,0,0,1,1,0,0,0,1,1,1};
    double wysokosci_h[] = new double[bity.length];
    double h_optymalne =0;

    double poczatek = 0;
    double koniec   = T_b * bity.length;
    double krok     = 1/Fs;
    int ilosc_probek = (int)((Math.abs(koniec-poczatek))/krok);
    static double max_value = 1.5;
    static double min_value = -0.5;
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


        System.out.println("Ilosc bitow: "+bity.length);

        //####### OBLICZANIE WARTOSCI FUNKCJI ########

        g.setColor(Color.blue);

        // obliczenia, wpisanie do tablic
        double x=poczatek;
        double suma=0;
        int iteracja_bitow = 0;
        for(int i=0;i<ilosc_probek;i++){
            //x = i/(double)ilosc_probek * wymiar.width;
            x = poczatek + i/Fs;
            wartosci_X[i] = x;



            //###################### FUNKCJA #####################

            if(bity[iteracja_bitow]==0){
                suma += Math.abs(Math.sin(2*Math.PI*f_n*x));
                wartosci_Y[i] = suma;
            }else{
                suma += -Math.abs(Math.sin(2*Math.PI*f_n*x+Math.PI));
                wartosci_Y[i] = suma;
            }


            //wartosci_Y[i] = (double)bity[iteracja_bitow]*Math.sin(2*Math.PI*f_n*x);

            //###################### FUNKCJA #####################

            //x += krok;
//            if(wartosci_Y[i]>max_value){
//                max_value = wartosci_Y[i];
//            }
//            if(wartosci_Y[i]<min_value){
//                min_value = wartosci_Y[i];
//            }

            // zmieniac co 2 okresy, ilosc probkowania * t_b
            if(iteracja_bitow<bity.length-1) {
                if ((i!=0) && (i % (double)(ilosc_probek / bity.length) == 0)) {
                    // sprawdzenie wysokosci
                    wysokosci_h[iteracja_bitow] = suma;
                    h_optymalne += suma;
                    System.out.println("BIT ["+iteracja_bitow+"], wysokosc = "+suma);

                    //System.out.println("i: " + iteracja_bitow + ". BIT: [" + bity[iteracja_bitow] + "].");

                    iteracja_bitow++;
                    suma = 0;
                }
            }

            //System.out.println("I: "+i+"  X="+wartosci_X[i]+", Y="+wartosci_Y[i]);
        }


        h_optymalne= h_optymalne/bity.length;

        // obliczenia, wpisanie do tablic
        x=poczatek;
        suma=0;
        iteracja_bitow = 0;
        for(int i=0;i<ilosc_probek;i++){
            //x = i/(double)ilosc_probek * wymiar.width;
            x = poczatek + i/Fs;
            wartosci_X[i] = x;



            //###################### FUNKCJA #####################
            //sinusoida
            // Math.sin(2*Math.PI*f_n*x);

            //s_an(t)
            //if(bity[iteracja_bitow]==0){
            //                wartosci_Y[i] = A_1*Math.sin(2*Math.PI*f_n*x);
            //            }else{
            //                wartosci_Y[i] = A_2*Math.sin(2*Math.PI*f_n*x);
            //            }

            //x(t)
            //if(bity[iteracja_bitow]==0){
            //                wartosci_Y[i] = Math.abs(A_1*Math.sin(2*Math.PI*f_n*x));
            //            }else{
            //                wartosci_Y[i] = Math.abs(A_2*Math.sin(2*Math.PI*f_n*x));
            //            }

            // P(t)
            if(wysokosci_h[iteracja_bitow]<h_optymalne){
                wartosci_Y[i] = 0;
            }else{
                wartosci_Y[i] = 1;
            }
            if(iteracja_bitow<bity.length-1) {

                if ((i != 0) && (i % (double)(ilosc_probek / bity.length) == 0)) {
                    System.out.println("dsadsadsa"+iteracja_bitow);
                    iteracja_bitow++;
                }


            }


            //wartosci_Y[i] = (double)bity[iteracja_bitow]*Math.sin(2*Math.PI*f_n*x);

            //###################### FUNKCJA #####################

            //x += krok;
//            if(wartosci_Y[i]>max_value){
//                max_value = wartosci_Y[i];
//            }
//            if(wartosci_Y[i]<min_value){
//                min_value = wartosci_Y[i];
//            }

            //System.out.println("I: "+i+"  X="+wartosci_X[i]+", Y="+wartosci_Y[i]);


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

        JFrame f = new JFrame("Zad 1. PSK");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        psk graphics = new psk();
        f.add(graphics);

        f.setSize(816,440);
        f.setVisible(true);
        f.setResizable(false);
    }

}