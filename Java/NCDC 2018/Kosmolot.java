// Michał Krug
// krug.michal@gmail.com

public class Kosmolot {

    public static void main(String[] args) {


        int rozmiar = 0;
        boolean tarcza = false;
        String napis = "";
        String linia = "";


        if(args.length == 2){
            try {

                if((Integer.parseInt(args[0]) >= 1) && (Integer.parseInt(args[0]) <= 75)) {
                    rozmiar = Integer.parseInt(args[0]);
                }else{
                    //System.out.println("Złąwartosc arguemntu");
                    return;
                }

                if(args[1].equals("Y")){
                    tarcza = true;
                }else if(args[1].equals("N")){
                    tarcza = false;
                }else {
                    //System.out.println("Zła tarcza " + args[1]);
                    return;
                }

            } catch(NumberFormatException e) {
                //System.out.println("exception");
                return;
            }
        }
        else{
            //System.out.println("Zła ilość arg");
            return;
        }


        if(rozmiar == 1 && tarcza == false){
            System.out.println("*");
            return;
        }else if(rozmiar == 1 && tarcza == true){
            System.out.println(">");
            return;
        }


        if(tarcza == false){

            // gorne skrzydlo
            // numer lini skrzydla, zmontowanie pojedynczego elementu w linii
            for(int i=1; i<rozmiar; i++){
                // ile gwiazdek
                for(int j=0; j<i; j++){
                    napis += "*";
                }
                // ile spacji
                for(int k=0; k<rozmiar-i; k++){
                    napis += " ";
                }

                // zmontowanie linii
                for(int l=0; l<rozmiar; l++){
                    linia += napis;
                }
                System.out.println(linia);
                napis = "";
                linia = "";

            }

            // srodek
            for(int i=0; i<rozmiar*rozmiar; i++){
                napis += "*";
            }
            System.out.println(napis);
            napis = "";

            // dolne skrzydlo
            for(int i=rozmiar-1; i>0; i--){
                // ile gwiazdek
                for(int j=0; j<i; j++){
                    napis += "*";
                }
                // ile spacji
                for(int k=0; k<rozmiar-i; k++){
                    napis += " ";
                }

                // zmontowanie linii
                for(int l=0; l<rozmiar; l++){
                    linia += napis;
                }
                System.out.println(linia);
                napis = "";
                linia = "";

            }


        }
        // jednak ma byc tarcza
        else {

            // gorne skrzydlo z tarcza
            // numer lini skrzydla, zmontowanie pojedynczego elementu w linii
            for (int i = 1; i < rozmiar; i++) {

                // SRODKOWY KAFELEK
                // ile gwiazdek, o 1 mniej wszedzie bo tarcza musi byc
                for (int j = 1; j < i; j++) {
                    napis += "*";
                }

                // dodajemy tarcze
                napis += "\\";

                // ile spacji
                for (int k = 0; k < rozmiar - i; k++) {
                    napis += " ";
                }

                // POCZATEK RAKIETY
                // przygotowanie poczatku z silnikami
                linia = ">";
                // ile gwiazdek, o 1 mniej wszedzie bo tarcza musi byc
                for (int j = 2; j < i; j++) {
                    linia += "*";
                }

                // dodajemy tarcze
                if (i != 1) {
                    linia += "\\";
                }

                // ile spacji
                for (int k = i; k < rozmiar; k++) {
                    linia += " ";
                }


                // zmontowanie linii
                for (int l = 1; l < rozmiar; l++) {
                    linia += napis;
                }
                System.out.println(linia);
                napis = "";
                linia = "";

            }

            // srodek
            napis = ">";
            for (int i = 2; i < rozmiar * rozmiar; i++) {
                napis += "*";
            }
            napis += ">";
            System.out.println(napis);
            napis = "";


            // dolne skrzydlo z tarcza
            // numer lini skrzydla, zmontowanie pojedynczego lementu w linii
            for (int i = rozmiar - 1; i > 0; i--) {

                // SRODKOWY KAFELEK
                // ile gwiazdek, o 1 mniej wszedzie bo tarcza musi byc
                for (int j = 1; j < i; j++) {
                    napis += "*";
                }

                // dodajemy tarcze
                napis += "/";

                // ile spacji
                for (int k = 0; k < rozmiar - i; k++) {
                    napis += " ";
                }

                // POCZATEK RAKIETY
                // przygotowanie poczatku z silnikami
                linia = ">";
                // ile gwiazdek, o 1 mniej wszedzie bo tarcza musi byc
                for (int j = 2; j < i; j++) {
                    linia += "*";
                }

                // dodajemy tarcze
                if (i != 1) {
                    linia += "/";
                }

                // ile spacji
                for (int k = i; k < rozmiar; k++) {
                    linia += " ";
                }


                // zmontowanie linii
                for (int l = 1; l < rozmiar; l++) {
                    linia += napis;
                }
                System.out.println(linia);
                napis = "";
                linia = "";

            }
        }

    }
}