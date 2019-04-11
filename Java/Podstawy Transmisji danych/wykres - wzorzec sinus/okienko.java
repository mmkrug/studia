import java.awt.*;
import javax.swing.*;
//import java.lang.Math.*;



public class okienko extends JPanel{


    double poczatek = -2 * Math.PI;
    double koniec   = 2 * Math.PI;
    double krok     = 0.01;
    int ilosc_krokow = (int)((Math.abs(poczatek-koniec))/krok)+1;
    static double max_value = 3;//Double.MIN_VALUE;//2;
    static double min_value = -2;//Double.MAX_VALUE;//max_value-max_value-max_value;
    double wysokosc = Math.abs(min_value-max_value);
    int iteracje = 0;
    double punkt_1[] = {poczatek,0};
    double punkt_2[] = {0,0};
    double wartosci_X[] = new double[(int) ilosc_krokow+1];
    double wartosci_Y[] = new double[(int) ilosc_krokow+1];

    int X_ekranu = 0;
    int Y_ekranu = 0;
    double krok_ekranowy_X;


    public void paintComponent(Graphics g){
        // ^---You need a paintComponent method to paint pictures
        super.paintComponent(g);
        // ^---You need to equip the variable g into super.paintComponent to draw pictures
        this.setBackground(Color.lightGray);
        // ^---This sets the background color

        Dimension wymiar = getSize();

        //g.setColor(Color.BLUE);
        // ^---This sets the color you want to use
        //g.fillRect(0, 0, 10, 10);
        // ^---This draws a rectangle using the color you selected
        //g.setColor(new Color(190,81,215));
        //g.fillRect(11, 11, 10, 10);

        //g.setColor(Color.RED);

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

//            g.drawLine((int)(Math.abs(koniec-Math.abs(poczatek))/Math.abs(koniec-poczatek)*wymiar.width),
//                    0,
//                    (int)(Math.abs(koniec-Math.abs(poczatek))/Math.abs(koniec-poczatek)*wymiar.width),
//                    wymiar.height);

        }

        //####### OBLICZANIE WARTOSCI FUNKCJI ########


        g.setColor(Color.blue);
        double y=0;

        // obliczenia, wpisanie do tablic
        double x=poczatek;
        for(int i=0;i<=ilosc_krokow;i++){
            //x = i/(double)ilosc_krokow * wymiar.width;
            wartosci_X[i] = x;
            //###################### FUNKCJA #####################
            wartosci_Y[i] = Math.sin(x);
            //###################### FUNKCJA #####################
            x += krok;

            if(wartosci_Y[i]>max_value){
                max_value = wartosci_Y[i];
            }
            if(wartosci_Y[i]<min_value){
                min_value = wartosci_Y[i];
            }
            System.out.println(i +".  Minimum: "+min_value+"| Maximum: "+max_value);

            //System.out.println(i+"xx: ("+wartosci_X[i]+","+wartosci_Y[i]+")");

        }



        System.out.println(ilosc_krokow);
        System.out.println();

        krok_ekranowy_X = wymiar.width/(double)ilosc_krokow;
        System.out.println("Wymiar.width: "+wymiar.width+"  ilosc krokow: "+ilosc_krokow+"  /=" + krok_ekranowy_X+ " #######");
        // rysowanie
        for(int i=0;i<ilosc_krokow;i++){
            X_ekranu = (int)(((double)i/(ilosc_krokow-1))*wymiar.width);
            g.drawLine( X_ekranu,
                    (int)(Math.abs(wartosci_Y[i]-max_value)/wysokosc*wymiar.height),
                    (int)((((double)i+1)/(ilosc_krokow-1))*wymiar.width),
                    (int)(Math.abs(wartosci_Y[i+1]-max_value)/wysokosc*wymiar.height));



//            if(i%5==0){
//                g.drawString(""+i,X_ekranu,(int)(Math.abs(wartosci_Y[i]-max_value)/wysokosc*wymiar.height)/2);
//            }

//            System.out.print("X: "+(X_ekranu)+"   i:");
//            System.out.println(i+": ("+(int)(Math.abs(wartosci_Y[i]-max_value)/wysokosc*wymiar.height)/2+", "+(int)(Math.abs(wartosci_Y[i+1]-max_value)/wysokosc*wymiar.height)/2+")");
//            X_ekranu += (double)krok_ekranowy_X;

        }

        //System.out.println("Ilość kroków: " + ilosc_krokow);

        //krok_ekranowy_X = wymiar.width/ilosc_krokow;

    }


    public static void main(String[] args){

        JFrame f = new JFrame("Sinusoida");
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        okienko graphics = new okienko();
        f.add(graphics);

        f.setSize(1616,840);
        f.setVisible(true);
        f.setResizable(false);
    }

}