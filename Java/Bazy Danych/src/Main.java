import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main {

    public static void main(String[] args) throws IOException {
        System.out.println("Start");

        String linia;
        String linia1[];
        String rodzaje[];
        String spr="";



        Pattern pattern = Pattern.compile("game");
        Matcher matcher;



        List<String> zoom = new ArrayList<>();
        boolean flaga = true; // mozna wstawiac


        String proba1 = "a b 1 2 3";
        String proba2 = "a b c d 1 2";
        String nazwa = "";
        String liczba = "";
        String roz[] = proba1.split(" ");
        for(int i=0; i<roz.length; i++){

            try{
                Integer.parseInt(roz[i]);
                liczba += roz[i];


            }catch(NumberFormatException e){
                nazwa += roz[i];
            }
        }

        System.out.println(nazwa + " " + liczba);
        nazwa = "";
        liczba = "";

        roz = proba2.split(" ");
        for(int i=0; i<roz.length; i++){

            try{
                Integer.parseInt(roz[i]);
                liczba += roz[i];


            }catch(NumberFormatException e){
                nazwa += roz[i];
            }
        }

        System.out.println(nazwa + " " + liczba);

        if(flaga==true)return;



        PrintWriter zapisz = new PrintWriter(
                new FileWriter("kraje3.txt"));
        //                  ZAPISZ DO


        BufferedReader odczyt = new BufferedReader(
                new InputStreamReader(
                        new FileInputStream(
                                "kraje2.txt")));
        //              CZYTAJ Z


//        String napis = "RPG, RPG game, RPG-game";
//        String proba[] = napis.split(", ");
//
//        for(int i=0; i<proba.length; i++){
//
//            Pattern p = Pattern.compile("game");
//            Matcher m = p.matcher(proba[i]);
//            if (m.find()){
//                if((proba[i].charAt(proba[i].length()-5)=='-')){
//                    System.out.println(i+1 + " " + proba[i].substring(0,proba[i].length()-5));
//                }else{
//                    System.out.println(i+1 + " " + proba[i].substring(0,proba[i].length()-4));
//                }
//
//            }
//
//        }

//        String napis = "RPG, RPG game, RPG-game";
//        String proba[] = napis.split(", ");
//
//
//        System.out.println(proba.length);
//
//        String cap = proba[0].toUpperCase();//substring(0, 1).toUpperCase() + proba[0].substring(1);
//        System.out.println(cap);
//
//        cap = proba[1].toUpperCase();//.substring(0, 1).toUpperCase() + proba[1].substring(1);
//        System.out.println(cap);
//        cap = proba[2].toUpperCase();//substring(0, 1).toUpperCase() + proba[2].substring(1);
//        System.out.println(cap);
//
//        if(flaga==true)return;


        try {

//            zoom.add("String 1");
//            zoom.add("String 2");
//
//            for (String z : zoom) {
//                System.err.println(z);
//            }

//            String napis1 = "RPG";
//            zoom.add(napis1);


//            if(zoom.get(0) == "RPG"){
//                zoom.add("no jest rpg");
//            }
//
//            zoom.add(napis1);
//
//
//            System.out.println(zoom.get(0));



            int licz=1;
            String napis="";
            while ((linia = odczyt.readLine()) != null) {

                linia1 = linia.split("\t");         // cala linia w pliku rozdzielona
                rodzaje = linia1[3].split(", ");    // rozdrobniony fragment genres




//
//
//                napis += linia1[1];
//                for(int i=2; i<linia1.length; i++){
//                    napis += " ";
//                    napis += linia1[i];
//                }
//                zapisz.println(napis);
//                napis = "";


//                for(int i=0; i<rodzaje.length; i++){
//                    spr = rodzaje[i].substring(0, 1).toUpperCase() + rodzaje[i].substring(1);
//                    if(i==0){
//                        napis += spr;
//                    }else{
//                        napis += ", ";
//                        napis += spr;
//                    }
//                    System.out.println(napis);
//                }
//
//                String dozapisu ="";
//
//                for(int i=0; i<linia1.length; i++){
//                    if(i == 3){
//                        dozapisu += napis;
//                        dozapisu += "\t";
//                    }else {
//                        dozapisu += linia1[i];
//                        if (i != linia1.length) {
//                            dozapisu += "\t";
//                        }
//                    }
//                }
//
//                //System.out.println(linia1[3]);
//                zapisz.println(dozapisu);
//                System.out.println(dozapisu);
//                dozapisu = "";
//                napis = "";





                //        String napis = "Tactical shooter, military simulation, open world";
                // rodzaje.length = 3
                //


                // na kazdy rodzaj przejrze cala liste
//                for(int i=0; i<rodzaje.length; i++){
//                    spr = rodzaje[i].toUpperCase();//substring(0, 1).toUpperCase() + rodzaje[i].substring(1);
//
//                    matcher = pattern.matcher(spr);
//                    if (matcher.find()) {
//                        if ((spr.charAt(spr.length() - 5) == '-')) {
//                            spr = spr.substring(0, spr.length() - 5);
//                        } else {
//                            spr = spr.substring(0, spr.length() - 4);
//                        }
//
//                    }
//
//                    // przelatuje cala liste
//                    for(int j=0; j<zoom.size(); j++) {
//
//                        //System.out.println("J: " + j);
//                        if (zoom.get(j).equals(spr)) {
//                            flaga = false;
//                        }
//
//                    }
//
//                    if(flaga == true){
//                        zoom.add(spr);
//                        zapisz.println(spr);
//
//                    }else{
//                        flaga = true;
//                    }
//
//                }


               // System.out.println(licz + " " + spr + "\t Size: " + zoom.size());



//
//                for(int i=0; i<zoom.size(); i++){
//
//                    rodzaje = linia1[3].split(",");
//                    for(int j=0; j<rodzaje.length; j++){
//
//
//                        if(zoom.get(i).equals(rodzaje[j])){
//                            flaga = false;
//                        }
//                    }
//                }
//
//                if(flaga == true){
//                    zoom.add(linia1[3]);
//                }else{
//                    flaga = true;
//                }




                licz++;


                //linia2 = linia.split(" ");

//                    Integer.parseInt(linia1[0]);
//                    linia2 += linia1[0]; //numer
//                    linia2 += " ";
//                    linia2 += linia1[1];
//                    System.out.println(linia2);
//
//                    zapisz.println(linia2);
//                    linia2 = "";
               // linia2 += linia1[0]; // numer
//                linia2 += " ";
//                //linia2 += linia1[1]; // zdublowana nazwa
//                String kraj[] = linia1[1].split(" ");
//                if(kraj[0].equals(kraj[1])) {
//                    linia2 += kraj[1];
//
//                } else{
//                    linia2 += linia1[1];
//                }
//                linia2 += " ";
//                linia2 += linia1[linia1.length-1];
//                    System.out.println(linia2);
//
//                    zapisz.println(linia2);
//                                    linia2 = "";
//
//
//


            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            odczyt.close();
            zapisz.close();
        }


//        String napis="";
//        for(int i=0; i<zoom.size(); i++){
//            napis += zoom.get(i);
//            zapisz.write("CHUUUJ");
//            System.out.println(napis);
//            napis = "";
//        }
//
//        zapisz.println("CASDSA");

        System.out.println(zoom);
        System.out.println(zoom.size());




//            this.wymiary = linia.split(" ");
//            this.wiersze = Integer.parseInt(this.wymiary[0]);
//            this.kolumny = Integer.parseInt(this.wymiary[1]);
//            this.wartosci = new int[this.wiersze][this.kolumny];
//
//            for(int i = 0; i < this.wiersze; ++i) {
//                linia = scan.nextLine();
//
//                for(int j = 0; j < this.kolumny; ++j) {
//                    this.wymiary = linia.split(" ");
//                    this.wartosci[i][j] = Integer.parseInt(this.wymiary[j]);
//                }
//            }

//
//
//        public static void wykonaj_mnozenie(Macierz m1, Macierz m2) throws IOException {
//            FileWriter stworz = new FileWriter("macierz_wynikowa.txt");
//            PrintWriter zapisz = new PrintWriter(stworz);
//
//            for(int i = 0; i < m1.wiersze; ++i) {
//                for(int j = 0; j < m2.kolumny; ++j) {
//                    int suma = 0;
//
//                    for(int k = 0; k < m1.kolumny; ++k) {
//                        int wartosc = m1.wartosci[i][k] * m2.wartosci[k][j];
//                        suma += wartosc;
//                    }
//
//                    System.out.print(suma + "\t");
//                    zapisz.print(suma + " ");
//                }
//
//                zapisz.println();
//                System.out.println();
//            }
//
//            zapisz.close();
//        }

        zapisz.close();
        System.out.println("Koniec");
    }
}