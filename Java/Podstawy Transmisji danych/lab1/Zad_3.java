import java.awt.*;
import javax.swing.*;
//import java.lang.Math.*;



public class Zad_3 extends JPanel{

    double f=100;
    double Fs=4000;
    double o = Math.PI;
    int T=1;




    double poczatek = 0;
    double koniec   = T;
    double krok     = 1/Fs;
    int ilosc_krokow = (int)((Math.abs(koniec-poczatek))/krok)+1;
    static double max_value = 1.5;//Double.MIN_VALUE;//2;
    static double min_value = -0.2;//Double.MAX_VALUE;//max_value-max_value-max_value;
    double wysokosc = Math.abs(min_value-max_value);
    double wartosci_X[] = new double[(int) ilosc_krokow+1];
    double wartosci_Y[] = new double[(int) ilosc_krokow+1];

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
        for(int i=0;i<ilosc_krokow;i++){
            //x = i/(double)ilosc_krokow * wymiar.width;
            wartosci_X[i] = x;

            //x(n) = cos(2PI * f * t + o) * (t/2)^0.12
            //y(n) = (n^2)/(n+1)
            //v(n) = 3x(n)^7 * sqrt((|y(n)|))

            //###################### FUNKCJA #####################
            if(i<ilosc_krokow*0.4){
                //System.out.println("X: "+x+" kroki*0.4: "+ilosc_krokow*0.4);
                wartosci_Y[i] = Math.pow(0.8,x)-1;
            }
            else if(i<ilosc_krokow*0.6){
                //System.out.println("Case < 0.6");
                wartosci_Y[i] = -1.8 * x * Math.cos(16*Math.PI * x / Fs + Math.PI);
            }
            else if(i<ilosc_krokow*0.8){
                //System.out.println("Case < 0.8");
                wartosci_Y[i] = 0.72 * x;
            }
            else{
                wartosci_Y[i] = Math.pow(0.29*x,8) * Math.sin(31*Math.PI*x/Fs)+0.55;
            }

            //###################### FUNKCJA #####################


            x += krok;
            if(wartosci_Y[i]>max_value){
                max_value = wartosci_Y[i];
            }
            if(wartosci_Y[i]<min_value){
                min_value = wartosci_Y[i];
            }

            //System.out.println("I: "+i+"  X="+wartosci_X[i]+", Y="+wartosci_Y[i]);


        }



        // rysowanie
        double flaga = 0.4;
        for(int i=0;i<ilosc_krokow;i++){

            if(wartosci_X[i+1]>=flaga){
                flaga+=0.2;
                continue;
            }

            X_ekranu = (int)(((double)i/(ilosc_krokow-1))*wymiar.width);
            g.drawLine( X_ekranu,
                    (int)(Math.abs(wartosci_Y[i]-max_value)/wysokosc*wymiar.height),
                    (int)((((double)i+1)/(ilosc_krokow-1))*wymiar.width),
                    (int)(Math.abs(wartosci_Y[i+1]-max_value)/wysokosc*wymiar.height));


        }
    }


    public static void main(String[] args){

        JFrame f = new JFrame("Zad 3.");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        Zad_3 graphics = new Zad_3();
        f.add(graphics);

        f.setSize(816,440);
        f.setVisible(true);
        f.setResizable(false);
    }

}