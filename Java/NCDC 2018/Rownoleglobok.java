// Michał Krug
// krug.michal@gmail.com

import java.util.Scanner;

public class Rownoleglobok {

    public static void main(String[] args) {

        int szerokosc = 0;
        int wysokosc = 0;
        int kopniecie = 0;
        String napis = "";


        //	Warunki poczatkowe, przypisanie argumentów do zmiennych.
        //	Czy są 3 args?
        if (args.length == 3 ){
            // nie wiem czy najpierw przypisywanie argumentow jest dobre, ale dalszy warunek jest o wiele krotszy
            try {
                szerokosc = Integer.parseInt(args[0]);
                wysokosc = Integer.parseInt(args[1]);
                kopniecie = Integer.parseInt(args[2]);
            } catch(NumberFormatException e) {
                return;
            }

            if( szerokosc>0 && szerokosc<=100 && wysokosc>0 && wysokosc<=100 && kopniecie>=-100 && kopniecie<=100){
                // args spelniaja oczekiwania
            }else{
                //System.out.println("  Złe wartości.");
                return;
            }

        }else {
            //System.out.println("  Nieprawidłowaowa ilość argumentów.");
            return;
        }


        // kopniecie dodatnie, dol idzie w prawo; dla kopniecia = 0 bedzie warunek konczacy petle dodawania spacji

        if(kopniecie >= 0) {
            for (int j = 0; j < szerokosc; j ++) {
                napis+="*";
            }

            for(int i = 0; i < wysokosc; i ++) {
                System.out.println(napis);
                for(int k=0;k<kopniecie;k++) {
                    napis = " " + napis;
                }
            }
        }


        //	kopniecie ujemne, dol idzie w lewo
        else {

            for (int i = 0; i < wysokosc; i++) {
                for (int k = wysokosc - i - 1; k > 0; k--) {
                    for (int x = 0; x < -kopniecie; x++) {
                        napis += " ";
                    }
                }
                for (int j = 0; j < szerokosc; j++) {
                    napis += "*";
                }
                System.out.println(napis);
                napis = "";
            }
        }
    }
}