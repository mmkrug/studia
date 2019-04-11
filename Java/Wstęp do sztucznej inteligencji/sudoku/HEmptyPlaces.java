package lab01.si.sudoku;

import sac.State;
import sac.StateFunction;

public class HEmptyPlaces extends StateFunction {
	@Override
	public double calculate(State state) {
		
		Sudoku s = (Sudoku)state;
		return s.zeros;
		
		
		
		// TODO Auto-generated method stub
	}
}
