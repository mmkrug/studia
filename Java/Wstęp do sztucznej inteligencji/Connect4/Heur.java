import sac.State;
import sac.StateFunction;

public class Heur extends StateFunction {


    @Override
    public double calculate(State state) {


        int h = 0;
        byte [][] board = ((Connect)state).getBoard();

        int m = Connect.m;
        int n = Connect.n;
        int znak = 0;

        // m - ilosc wierszy, wysokosc
        // n - ilosc kolumn, szerokosc

        int streak=0;
        int krok=0;
        int start_col = 0;      // numer kolumny
        int start_wier = m-1;   // numer wiersza
        int x=0;
        int y=0;

        if(((Connect) state).isMaximizingTurnNow()) {

            // regula sufitu
            for(int i=0; i<n; i++){
                if(board[0][i] == Connect.O)
                    return Double.POSITIVE_INFINITY;
            }

            // wszystko w prawo
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (board[i][j] == Connect.E) {
                        continue;
                    }

                    streak = 0;
                    krok = 0;

                    // znlazlo jakis Connect.O
                    while (j + krok < n) {
                        if (board[i][j + krok] == Connect.O) {
                            streak++;
                            krok++;
                            if (streak == 4) return Double.POSITIVE_INFINITY;
                        } else {
                            j += krok;
                            break;
                        }
                    }
                    if(streak!=0)
                    h += Math.pow(10,streak);
                }
            }


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
            //((Connect)state).getMoveName()

//            System.out.println("1 Imie: " + state.getMoveName());
//            if(state.getMoveName().equals(n/2)){
//                h+=100000;
//            }
//
//            try {
//                int imie = Integer.parseInt(((Connect)state).getMoveName());
//                if(imie < n/2){
//                    h += imie * imie;
//                }else{
//                    h += (n-imie-1)*(n-imie-1);
//                }
//            } catch (NumberFormatException e) {
//                e.printStackTrace();
//            }

            // 0 1 2 3 || 4 5 6 7
            // 0 1 4 9 ||

            // do dolu
            for(int j=0; j<n; j++) {
                streak = 0;
                krok = 0;
                for (int i = 0; i < m; i++) {
                    if (board[i][j] == Connect.E) {
                        continue;

                    } else if (board[i][j] == Connect.O) {
                        streak++;
                        if (streak == 4) return Double.POSITIVE_INFINITY;
                    }else{
                        if(streak!=0)
                            h += Math.pow(10,streak);
                        streak = 0;
                    }


                }
                if(streak!=0)
                    h += Math.pow(10,streak);
            }




//            // wszystko w dol
//            for (int j = 0; j < n; j++) {
//                for (int i = 0; i < m; i++) {
//                    if (board[i][j] == Connect.E) {
//                        continue;
//                    }
//
//                    streak = 0;
//                    krok = 0;
//
//                    // znlazlo jakis Connect.O
//                    while (i + krok < m) {
//                        if (board[i + krok][j] == Connect.O) {
//                            streak++;
//                            krok++;
//                            if (streak == 4) return Double.POSITIVE_INFINITY;
//                        } else {
//                            i += krok;
//                            break;
//                        }
//                    }
//                    if(streak!=0)
//                    h += Math.pow(10,streak);
//                }
//            }


            // wszystkie po skosie prawo i dol
            start_col = 0;      // numer kolumny
            start_wier = m - 1;   // numer wiersza

            while (true) {
                streak = 0;
                x = 0;
                y = 0;

                // przeszukiwanie jednego skosu
                while ((start_col + x < n) && (start_wier + y < m)) {

                    if (board[start_wier + y][start_col + x] == Connect.E) {
                        x++;
                        y++;
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        streak = 0;

                    } else if (board[start_wier + y][start_col + x] == Connect.O) {

                        streak++;
                        x++;
                        y++;
                        if (streak == 4) return Double.POSITIVE_INFINITY;

                    } else {
                        if(streak!=0)
                        h += Math.pow(10,streak);
                        x++;
                        y++;
                        krok = 0;
                        streak = 0;
                    }
                }
                h += Math.pow(10,streak);

                if (start_wier != 0) {
                    start_wier--;
                } else {
                    start_col++;
                }

                if (start_col > n) break;
            }


            // wszystkie po skosie lewo i dol

            start_col = n - 1;    //start_col = 0;      // numer kolumny
            start_wier = m - 1;                         // numer wiersza

            while (true) {
                //System.out.println("#1.");
                streak = 0;
                x = 0;
                y = 0;

                // przeszukiwanie jednego skosu
                while ((start_col - x >= 0) && (start_wier + y < m)) {

                    if (board[start_wier + y][start_col - x] == Connect.E) {
                        x++;
                        y++;
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        streak = 0;

                    } else if (board[start_wier + y][start_col - x] == Connect.O) {
                        streak++;
                        x++;
                        y++;
                        if (streak == 4) return Double.POSITIVE_INFINITY;

                    } else {
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        x++;
                        y++;
                        krok = 0;
                        streak = 0;
                    }
                }
                h += Math.pow(10,streak);

                if (start_wier != 0) {
                    start_wier--;
                } else {
                    start_col--;
                }

                if (start_col < 0) break;
            }


        }
        else{

            // regula sufitu
            for(int i=0; i<n; i++){
                if(board[0][i]== Connect.X)
                    return Double.NEGATIVE_INFINITY;
            }

            // wszystko w prawo
            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    if (board[i][j] == Connect.E) {
                        continue;
                    }

                    streak = 0;
                    krok = 0;

                    // znlazlo jakis Connect.O
                    while (j + krok < n) {
                        if (board[i][j + krok] == Connect.X) {
                            streak++;
                            krok++;
                            if (streak == 4) return Double.NEGATIVE_INFINITY;
                        } else {
                            j += krok;
                            break;
                        }
                    }
                    h += Math.pow(10,streak);
                }
            }


            // wszystko w dol
            for (int j = 0; j < n; j++) {
                for (int i = 0; i < m; i++) {
                    if (board[i][j] == Connect.E) {
                        continue;
                    }

                    streak = 0;
                    krok = 0;

                    // znlazlo jakis Connect.O
                    while (i + krok < m) {
                        if (board[i + krok][j] == Connect.X) {
                            streak++;
                            krok++;
                            if (streak == 4) return Double.NEGATIVE_INFINITY;
                        } else {
                            i += krok;
                            break;
                        }
                    }
                    h += Math.pow(10,streak);
                }
            }


            // wszystkie po skosie prawo i dol
            start_col = 0;      // numer kolumny
            start_wier = m - 1;   // numer wiersza

            while (true) {
                streak = 0;
                x = 0;
                y = 0;

                // przeszukiwanie jednego skosu
                while ((start_col + x < n) && (start_wier + y < m)) {

                    if (board[start_wier + y][start_col + x] == Connect.E) {
                        x++;
                        y++;
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        streak = 0;

                    } else if (board[start_wier + y][start_col + x] == Connect.X) {

                        streak++;
                        x++;
                        y++;
                        if (streak == 4) return Double.NEGATIVE_INFINITY;

                    } else {
                        if(streak!=0)
                        h += Math.pow(10,streak);
                        x++;
                        y++;
                        krok = 0;
                        streak = 0;
                    }
                }
                h += Math.pow(10,streak);

                if (start_wier != 0) {
                    start_wier--;
                } else {
                    start_col++;
                }

                if (start_col > n) break;
            }


            // wszystkie po skosie lewo i dol

            start_col = n - 1;    //start_col = 0;      // numer kolumny
            start_wier = m - 1;                         // numer wiersza

            while (true) {
                //System.out.println("#1.");
                streak = 0;
                x = 0;
                y = 0;

                // przeszukiwanie jednego skosu
                while ((start_col - x >= 0) && (start_wier + y < m)) {

                    if (board[start_wier + y][start_col - x] == Connect.E) {
                        x++;
                        y++;
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        streak = 0;

                    } else if (board[start_wier + y][start_col - x] == Connect.X) {
                        streak++;
                        x++;
                        y++;
                        if (streak == 4) return Double.NEGATIVE_INFINITY;

                    } else {
                        if(streak!=0)
                        h += Math.pow(10,streak);

                        x++;
                        y++;
                        krok = 0;
                        streak = 0;
                    }
                }
                if(streak!=0)
                h += Math.pow(10,streak);

                if (start_wier != 0) {
                    start_wier--;
                } else {
                    start_col--;
                }

                if (start_col < 0) break;
            }




        }


        return h;
    }
}
