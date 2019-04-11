// Michał Krug
// krug.michal@gmail.com

import java.util.Scanner;

public class Szachownica {

    public static void main(String[] args) {


        int szer_kaf = 0;
        int wys_kaf = 0;
        int szer_planszy = 0;
        int wys_planszy = 0;

        String znak_bialy = "";
        String znak_czarny = "";
        String linia1 = "";
        String linia2 = "";

        String napis = "";
        String znak = "";


        // sprawdzenie argumentow
        if(args.length ==  6){

            try {
                for(int i=0; i<4; i++){
                    if(Integer.parseInt(args[i])<1 || Integer.parseInt(args[i])>15){
                        return;
                    }
                }
                szer_kaf = Integer.parseInt(args[0]);
                wys_kaf = Integer.parseInt(args[1]);
                szer_planszy = Integer.parseInt(args[2]);
                wys_planszy = Integer.parseInt(args[3]);

            } catch(NumberFormatException e) {
                //System.out.println("exception");
                return;
            }

            if(args[4].length() == 1 && args[5].length() == 1){
                znak_bialy = args[4];
                znak_czarny = args[5];
            }
            else{
                //System.out.println("Złe dł arg. 5 i 6");
                return;
            }

        }
        else{
            //System.out.println("Zła ilość arg." + args.length);
            return;
        }

        // tworzenie "pierwszej lini" zaczynajac od bialego kafelka
        znak = znak_bialy;
        for(int i=0; i<szer_planszy; i++){
            for(int j=0; j<szer_kaf; j++){
                linia1 += znak;
            }
            if(znak==znak_czarny){
                znak = znak_bialy;
            }else{
                znak = znak_czarny;
            }
        }

        // tworzenie "innej lini" zaczynajac od czarnego kafelka
        znak = znak_czarny;
        if(wys_planszy > 1){
            for(int i=0; i<szer_planszy; i++){
                for(int j=0; j<szer_kaf; j++){
                    linia2 += znak;
                }
                if(znak==znak_czarny){
                    znak = znak_bialy;
                }else{
                    znak = znak_czarny;
                }
            }
        }

        // rysowanie calej planszy
        napis = linia1;
        for(int i=0; i<wys_planszy; i++){
            for(int j=0; j<wys_kaf; j++){
                System.out.println(napis);
            }
            if(napis == linia1){
                napis = linia2;
            }else{
                napis = linia1;
            }
        }
    }
}