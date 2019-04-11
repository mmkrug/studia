import sac.game.*;
import sac.graph.AStar;
import sac.graph.GraphSearchAlgorithm;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;


public class Connect extends GameStateImpl {


    public static final int m = 10;     // m - ilosc wierszy, wysokosc
    public static final int n = 8;      // n - ilosc kolumn, szerokosc

    public static final byte E=0;
    public static final byte X=1;
    public static final byte O=2;

    int counter1 = 0;
    int counter2 = 0;

    int wynik1 = 0;
    int wynik2 = 0;


    private byte[][] board = null;

    public Connect(){
        board = new byte[m][n];
        for(int i=0; i<m; i++){
            for(int j=0; j<n;j++){
                board[i][j] = E;
            }
        }
    }

    public Connect(Connect parent){

        board = new byte[m][n];
        for(int i=0; i<m; i++){
            for(int j=0; j<n;j++){
                board[i][j] = parent.board[i][j];
            }
        }
        setMaximizingTurnNow(parent.isMaximizingTurnNow());
    }

     public byte[][] getBoard() {
        return board;
    }

//     public List <GameState > generateChildren () {
//     List<GameState> children = new LinkedList<GameState>();
//         for (int i = 1; i <= 2 && i < n; i++) {
//             HelloWorldGameState child = new HelloWorldGameState(n - i);
//             child.setMoveName(Integer.toString(i));
//            child.setMaximizingTurnNow(!isMaximizingTurnNow());
//            children.add(child);
//         }
//        return children;
//    }


    @Override
    public List<GameState> generateChildren() {

        List<GameState> children = new ArrayList<GameState>();

        for(int j=0; j<n;j++){
            Connect child = new Connect(this);
            if(child.make_move(j)){
                //child.setMaximizingTurnNow(!isMaximizingTurnNow());
                children.add(child);
                child.setMoveName(Integer.toString(j));
            }
        }

        return children;
    }

    @Override
    public String toString() {

        // m - ilosc wierszy, wysokosc
        // n - ilosc kolumn, szerokosc
        StringBuilder txt = new StringBuilder();

        txt.append("\n");
        for(int i=0; i<m; i++){
            txt.append(i+"\\\t\t| ");
            for(int j=0; j<n; j++){

                if(board[i][j]==0){
                    txt.append("  | ");

                }else if(board[i][j]==1){
                    txt.append("x | ");

                }else{
                    txt.append("O | ");
                }
            }
            txt.append("\n");
        }

        txt.append("\t\t=");//=================================\n\t\t  ");

        for(int k=0; k<n; k++){
            txt.append("====");
        }
        txt.append("\n\t\t  ");

        for(int i=0; i<n; i++){
            txt. append(i +"   ");
        }
        //txt.append("\t(n-1)");

        return txt.toString();
    }

    public boolean make_move(int kolumna){
        boolean result = false;

        for(int i=m-1; i>=0; i--){

            if(board[i][kolumna] == E){
                board[i][kolumna] = (isMaximizingTurnNow()) ? O : X; // bylo-  is? X:O;
                //is_win();
                result = true;
                break;
            }
        }
        if(result){
            setMaximizingTurnNow(!isMaximizingTurnNow());
        }

        return  result;
    }

    void punktuj(int osoba){
        int streak=0;
        int krok=0;
        int start_col = 0;      // numer kolumny
        int start_wier = m-1;   // numer wiersza
        int x=0;
        int y=0;
        wynik1=0;
        wynik2=0;


        // wszystko w prawo
        for(int i=0; i<m; i++){
            for(int j=0; j<n; j++){
                 if (board[i][j] == E) {
                    continue;
                }

                streak = 0;
                krok = 0;

                // znlazlo jakis X
                 while(j+krok < n) {
                     if (board[i][j+krok] == osoba) {
                        streak++;
                        krok++;
                     }else{
                         j += krok;
                         break;
                     }
                 }
                if(osoba == X){wynik1 += streak*streak;}
                    else{wynik2 += streak*streak;}
            }
        }


//         //wszystko w dol
//        for(int j=0; j<n; j++) {
//            for (int i = 0; i < m; i++) {
//                if(board[i][j] == E){
//                    continue;
//                }
//
//                streak = 0;
//                krok = 0;
//
//
//                while(i+krok < m){
//
//                }
//                if(osoba == X){wynik1 += streak*streak;}
//                    else{wynik2 += streak*streak;}
//            }
//        }




        // m - ilosc wierszy, wysokosc
        // n - ilosc kolumn, szerokosc
//
//            0\		|   |   |   |   |   |   |   |   |
//            1\		|   |   |   |   |   |   |   |   |
//            2\		|   |   |   |   |   |   |   |   |
//            3\		|   |   |   |   |   |   |   |   |
//            4\		| x |   |   |   |   |   |   |   |
//            5\		| O |   |   |   |   |   |   |   |
//            6\		| x |   |   |   |   |   |   |   |
//            7\		| O |   |   |   |   |   |   |   |
//            8\		| O |   |   |   |   |   |   |   |
//            9\		| x |   |   |   |   |   | O |   |
//		                =================================
//                        0   1   2   3   4   5   6   7
//

        // do dolu
        for(int j=0; j<n; j++) {
            streak = 0;
            krok = 0;
            for (int i = 0; i < m; i++) {
                if (board[i][j] == E) {
                    continue;

                } else if (board[i][j] == osoba) {
                    streak++;
                }else{
                    if(osoba == X){wynik1 += streak*streak;}
                        else{wynik2 += streak*streak;}
                    streak = 0;
                }


            }
            if(osoba == X){wynik1 += streak*streak;}
            else{wynik2 += streak*streak;}
        }



        // wszystkie po skosie prawo i dol
        start_col = 0;      // numer kolumny
        start_wier = m-1;   // numer wiersza

        while(true){
            streak=0;
            x=0; y=0;

            // przeszukiwanie jednego skosu
            while ((start_col+x < n) && (start_wier+y < m)){

                if (board[start_wier + y][start_col + x] == E){
                    x++; y++;
                    if(osoba == X){wynik1 += streak*streak;}
                        else{wynik2 += streak*streak;}

                    streak = 0;

                }else if (board[start_wier + y][start_col + x] == osoba) {

                    streak++; x++; y++;

                } else {
                    if(osoba == X){wynik1 += streak*streak;}
                        else{wynik2 += streak*streak;}
                    x ++;
                    y ++;
                    krok = 0;
                    streak = 0;
                }
            }
            if(osoba == X){wynik1 += streak*streak;}
                else{wynik2 += streak*streak;}

            if(start_wier!=0){start_wier--;}
                else{start_col++;}

            if(start_col>n)break;
        }


        // wszystkie po skosie lewo i dol

        start_col = n-1;    //start_col = 0;      // numer kolumny
        start_wier = m-1;                         // numer wiersza

        while(true){
            //System.out.println("#1.");
            streak=0;
            x=0; y=0;

            // przeszukiwanie jednego skosu
            while ((start_col-x >= 0) && (start_wier+y < m)){

                if (board[start_wier + y][start_col - x] == E){
                    x++; y++;
                    if(osoba == X){wynik1 += streak*streak;}
                        else{wynik2 += streak*streak;}

                    streak = 0;

                }else if (board[start_wier + y][start_col - x] == X) {
                    streak++; x++; y++;

                } else {
                    if(osoba == X){wynik1 += streak*streak;}
                        else{wynik2 += streak*streak;}

                    x ++;
                    y ++;
                    krok = 0;
                    streak = 0;
                }
            }
            if(osoba == X){wynik1 += streak*streak;}
                else{wynik2 += streak*streak;}

            if(start_wier!=0){start_wier--;}
            else{start_col--;}

            if(start_col<0)break;
        }


        if(osoba == X){
            System.out.println("Twój wynik:      " + wynik1);
        }
        else{
            System.out.println("Wynik komputera: " + wynik2);
        }


    }


    // 0 - nikt nie wygral, 1 - wygral gracz, 2 - wygral komputer
    int sprawdz(){
        //System.out.println("counter 1: " + counter1 + "\t counter2: " + counter2);
        if(counter1==4){
            System.out.println("Gratulacje, wygrales!!");
            //System.out.println("Twój wynik:      " + wynik1);
            //System.out.println("Wynik komputera: " + wynik2);

            punktuj(X);
            punktuj(O);
            return 1;

        } else if(counter2==4) {
            System.out.println("YOU LOOOOOOOOOOSE");
            //System.out.println("Twój wynik:      " + wynik1);
            //System.out.println("Wynik komputera: " + wynik2);

            punktuj(X);
            punktuj(O);
            return 2;
        }
        counter1 = 0;
        counter2 = 0;
        return 0;
    }




    // zwraca 0 gdy nikt nie wygral, 1 gdy wygral gracz, 2 gdy wygral komputer
    public double is_win() {

        // element pierwszy dla gracza, element 2 dla komputera
        // E=0, X=1, O=2

        // m - ilosc wierszy, wysokosc
        // n - ilosc kolumn, szerokosc

        for(int i=0; i<n; i++){
            if(board[0][i] != Connect.E){
                if(board[0][i] == Connect.X){
                    System.out.println("Gratulacje, wygrales!!");
                    punktuj(X);
                    punktuj(O);
                    System.exit(0);
                }else{
                    System.out.println("YOU LOOOOOOOOOOSE");
                    punktuj(X);
                    punktuj(O);
                    System.exit(0);                }
            }
        }

        int wygrana = 0;
            for (int i = m - 1; i >= 0; i--) {                // i = wybrany wiersz
                for (int j = 0; j < n; j++) {           // j = wybrana kolumna

                    if (board[i][j] == E) {
                        continue;
                    }

                    // sprawdzanie w prawo;
                    if(j < n-3) {
                        for (int k = 0; k < 4; k++) {
                            if (board[i][j + k] == X) counter1++;
                            if (board[i][j + k] == O) counter2++;
                        }
                        //System.out.print("w Prawo - ");
                        wygrana = sprawdz();
                        if(wygrana==1) {
                            System.exit(0);
                        }else if(wygrana==2){
                            System.exit(0);
                        }
                    }

                    // sprawdzanie w gore
                    if(i >= 3) {
                        for (int k = 0; k < 4; k++) {
                            if (board[i - k][j] == X) counter1++;
                            if (board[i - k][j] == O) counter2++;
                        }
                        //System.out.print("w Gore  - ");
                        wygrana = sprawdz();
                        if(wygrana==1) {
                            System.exit(0);
                        }else if(wygrana==2){
                            System.exit(0);
                        }                    }

                    // sprawdzanie po skosie, prawo gora
                    if((j < n-3) && (i >= 3)) {
                        for (int k = 0; k < 4; k++) {
                            if (board[i - k][j + k] == X) counter1++;
                            if (board[i - k][j + k] == O) counter2++;
                        }
                        //System.out.print("Skos -> - ");
                        wygrana = sprawdz();
                        if(wygrana==1) {
                            System.exit(0);
                        }else if(wygrana==2){
                            System.exit(0);
                        }                    }

                    // sprawdzanie po skosie, lewo gora
                    if((j >= 3) && (i >= 3)) {
                        for (int k = 0; k < 4; k++) {
                            if (board[i - k][j - k] == X) counter1++;
                            if (board[i - k][j - k] == O) counter2++;
                        }
                        //System.out.print("Skos <- - ");
                        wygrana = sprawdz();
                        if(wygrana==1) {
                            System.exit(0);
                        }else if(wygrana==2){
                            System.exit(0);
                        }                    }
                }
            }


        System.out.println("Graj dalej.");
        return 0;
    }


    public static void main(String[] args){

        int liczba = 0;
        Random rand = new Random();
        Scanner scan = new Scanner(System.in);
        int wczytaj;

        Connect.setHFunction(new Heur());

        Connect plansza = new Connect();

        //System.out.println(plansza);

        //algorithm.execute();
        //algorithm.doEvaluateMaxState(plansza,X,O,1,2);
        GameSearchConfigurator configurator = new GameSearchConfigurator();
        configurator.setDepthLimit(4);//(49.5);
        //GameSearchAlgorithm algorithm = new MinMax(new HelloWorldGameState (6) , configurator );
        GameSearchAlgorithm algorithm = new AlphaBetaPruning(plansza,configurator);



        System.out.println("Kto zaczyna? g - k");
        String kto = scan.nextLine();
        if(kto.equals("g") || kto.equals("G") || kto.equals("p") || kto.equals("P")){
            plansza.setMaximizingTurnNow(false);
            System.out.println(plansza);
        }else{
            plansza.setMaximizingTurnNow(true);
            System.out.println("Komputer myśli");
            //algorithm.execute();
            //String ruch = algorithm.getFirstBestMove();

//            plansza.make_move(Integer.parseInt(algorithm.getFirstBestMove()));
//            System.out.println(plansza);
//            System.out.println("Graj dalej.");
//            System.out.println( "MOVES_SCORES: " + algorithm . getMovesScores ());
//            System.out.println("Time: " + algorithm.getDurationTime()/1000 + "s");

//
            plansza.make_move(n/2);//Integer.parseInt(algorithm.getFirstBestMove()));
            System.out.println(plansza);
            System.out.println("Graj dalej.");
//


            //System.out.println(algorithm.getFirstBestMove() + "  " + Integer.parseInt(algorithm.getFirstBestMove()));
            //System.out.println(algorithm.getBestMoves());
            //System.out.println( "MOVESSCORES: " + algorithm . getMovesScores ());
        }


        while(true){

            wczytaj = scan.nextInt();
            if(wczytaj>n || wczytaj<0){
                return;

            } else{
                // ruch gracza
                plansza.make_move(wczytaj);
                System.out.println(plansza);
                plansza.is_win();


                System.out.println("Komputer myśli");
                algorithm.execute();
                plansza.make_move(Integer.parseInt(algorithm.getFirstBestMove()));
                System.out.println(plansza);
                plansza.is_win();

                //System.out.println(Integer.parseInt(algorithm.getFirstBestMove()));
                System.out.println(algorithm.getFirstBestMove());
                System.out.println(algorithm.getBestMoves());
                System.out.println( "MOVES_SCORES: " + algorithm . getMovesScores ());
                System.out.println("Time: " + algorithm.getDurationTime() + "[ms]");


            }
        }



        // napisanie funkcji heurystycznej oceniajacej pozycje
        //  szkielet

//        if(stan->zwycieski)
//            return double positive inf/ negative infinite
//                else
//                        dsadass 0 czy sie bokuje ?
                    //wymyslic funkcje punktujaca
//                 else
    }




}
