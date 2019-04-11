import sac.graph.AStar;
import sac.graph.GraphSearchAlgorithm;
import sac.graph.GraphState;
import sac.graph.GraphStateImpl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

public class Puzzle extends GraphStateImpl {

    public static final int n = 3;
    public static Random r = new Random();

    private int[][] plansza;


    public Puzzle(){

        plansza = new int[n][n];
        int k = 0;

        for(int i=0;i<n;i++) {
            for (int j = 0; j < n; j++) {
                plansza[i][j] = k++;
            }
        }
    }

    public Puzzle(Puzzle parent){

        plansza = new int [n][n];

        for(int i=0;i<n;i++){
            plansza[i] = Arrays.copyOf(parent.plansza[i], n);

        }
    }

    // 0 - góra,    1 - prawo,  2 - dół,    3 - lewo
    public boolean Ruch (int ruch){
        int i = 0;
        int j = 0;

        death:
        for(i=0; i<n; i++){
            for(j = 0; j<n; j++){
                if (plansza[i][j] == 0) {
                    break death;
                }
            }
        }

        try{
            switch(ruch){
                //  góra
                case 0:
                    plansza[i][j] = plansza[i-1][j];
                    plansza[i-1][j] = 0;
                    break;

                //  prawo
                case 1:
                    plansza[i][j] = plansza[i][j+1];
                    plansza[i][j+1] = 0;
                    break;

                //  dół
                case 2:
                    plansza[i][j] = plansza[i+1][j];
                    plansza[i+1][j] = 0;
                    break;

                //  lewo
                case 3:
                    plansza[i][j] = plansza[i][j-1];
                    plansza[i][j-1] = 0;
                    break;
            }
        }catch(IndexOutOfBoundsException ex){
            return false;
        }
        return true;
    }

    public void mieszaj(int ile){
        boolean isMove = false;

        for(int i=0; i<ile; i++){
            do{
                isMove = Ruch(r.nextInt(4));
            }
            while (!isMove);
        }
    }

    @Override
    public List<GraphState> generateChildren() {

        List<GraphState> children = new ArrayList<GraphState>();

        for(int i=0; i<4; i++){
            Puzzle child = new Puzzle(this);

            if(child.Ruch(i)){
                children.add(child);
                switch(i){
                    case 0:
                        child.setMoveName("G");
                        break;
                    case 1:
                        child.setMoveName("P");
                        break;
                    case 2:
                        child.setMoveName("D");
                        break;
                    case 3:
                        child.setMoveName("L");
                        break;

                }
            }
        }

        return children;
    }

    @Override
    public boolean isSolution() {
        int k=0;
        for(int i=0; i<n; i++){
            for(int j=0; j<n; j++){
                if(plansza[i][j] != k++){
                    return false;
                }
            }
        }
        return true;
    }


    @Override
    public String toString() {

        StringBuilder txt = new StringBuilder();

        for(int i=0; i<n; i++){
            for(int j=0; j<n; j++){
                txt.append(plansza[i][j] + " ");
            }
            txt.append("\n");
        }

        return txt.toString();
    }

    @Override
    public int hashCode() {

        int[] t = new int[n*n];

        int k=0;
        for(int i=0; i<n; i++){
            for(int j=0; j<n; j++){
                t[k++]=plansza[i][j];
            }
        }

        return Arrays.hashCode(t);
    }

    public int[][] getPlansza() {
        return plansza;
    }



    public static void main(String[] args) {

        int punkt = 5;
        int ile = 200;
        int losuj = 1000;
        int sr_czas = 0;
        int sr_open = 0;
        int sr_close = 0;
        float calkowity_czas = 0;

        // MISPLACED TILES
        r = new Random(punkt);
        for(int i=0; i<ile; i++){
            Puzzle.setHFunction(new MisplacedTiles());

            Puzzle puzzle = new Puzzle();
            puzzle.mieszaj(losuj);
            //System.out.println(puzzle);

            GraphSearchAlgorithm algorithm = new AStar(puzzle);
            algorithm.execute();

            List<GraphState> solutions = algorithm.getSolutions();
            for(GraphState solution : solutions){
                //System.out.println(solution);
                System.out.println(solution.getMovesAlongPath());
            }

            sr_czas += algorithm.getDurationTime();
            sr_open += algorithm.getOpenSet().size();
            sr_close += algorithm.getClosedSet().size();
        }
        calkowity_czas += sr_czas;

        System.out.println("\n  Misplaced Tiles.");
        System.out.println("  Sredni Czas: \t\t" + sr_czas/ile + "ms");
        System.out.println("  Srednie Open: \t" + sr_open/ile);
        System.out.println("  Srednie Closed: \t" + sr_close/ile + "\n");




        // MANHATTAN
        sr_czas = 0;
        sr_open = 0;
        sr_close = 0;
        r = new Random(punkt);

        for(int i=0; i<ile; i++){
            Puzzle.setHFunction(new Manhattan());

            Puzzle puzzle = new Puzzle();
            puzzle.mieszaj(losuj);
            //System.out.println(puzzle);

            GraphSearchAlgorithm algorithm = new AStar(puzzle);
            algorithm.execute();

            List<GraphState> solutions = algorithm.getSolutions();
            for(GraphState solution : solutions){
                //System.out.println(solution);
                System.out.println(solution.getMovesAlongPath());
            }

            sr_czas += algorithm.getDurationTime();
            sr_open += algorithm.getOpenSet().size();
            sr_close += algorithm.getClosedSet().size();
        }
        calkowity_czas += sr_czas;

        System.out.println("  Manhattan.");
        System.out.println("  Sredni Czas: \t\t" + sr_czas/ile + "ms");
        System.out.println("  Srednie Open: \t" + sr_open/ile);
        System.out.println("  Srednie Closed: \t" + sr_close/ile);

        System.out.println("___________________________");
        System.out.println("  Całkowity czas:\t" + calkowity_czas/1000 + "s");

/*
Random ro = new Random(5);
int liczba = ro.nextInt(100);
System.out.println(liczba);
ro = new Random(5);
liczba = ro.nextInt(100);
System.out.println(liczba);
liczba = ro.nextInt(100);
System.out.println(liczba);
*/
    }
}

































