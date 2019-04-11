import sac.State;
import sac.StateFunction;

public class Manhattan extends StateFunction {
    @Override
    public double calculate(State state) {

        int plansza[][] = ((Puzzle)state).getPlansza();
        int manhattan = 0;

        for(int i=0; i< Puzzle.n; i++){
            for(int j=0; j<Puzzle.n; j++){
                if(plansza[i][j] == 0){
                    continue;
                }

                manhattan += Math.abs(i - plansza[i][j] / Puzzle.n) + Math.abs(j - plansza[i][j] % Puzzle.n);
            }
        }

        return manhattan;
    }
}
