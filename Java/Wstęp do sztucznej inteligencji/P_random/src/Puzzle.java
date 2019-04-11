import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import sac.graph.AStar;
import sac.graph.GraphSearchAlgorithm;
import sac.graph.GraphState;
import sac.graph.GraphStateImpl;

public class Puzzle extends GraphStateImpl
{
	public static final int n = 3;
	public static final Random rand = new Random();
	
	private int[][] tab;
	
	public Puzzle()
	{
		tab = new int[n][n];
		
		int k = 0;
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				tab[i][j] = k++;
	}

	public Puzzle(Puzzle parent)
	{
		tab = new int[n][n];
		
		for (int i = 0; i < n; i++)
			tab[i] = Arrays.copyOf(parent.tab[i], n);
	}
		
	public boolean makeMove(Move move)
	{
		int i = 0;
		int j = 0;
		
		death:
		for (i = 0; i < n; i++)
			for (j = 0; j < n; j++)
				if (tab[i][j] == 0)
					break death;
		
		try
		{
			switch (move)
			{
				case MOVE_UP:
					tab[i][j] = tab[i - 1][j];
					tab[i - 1][j] = 0;
					break;
					
				case MOVE_DOWN:
					tab[i][j] = tab[i + 1][j];
					tab[i + 1][j] = 0;
					break;
					
				case MOVE_LEFT:
					tab[i][j] = tab[i][j - 1];
					tab[i][j - 1] = 0;
					break;
					
				case MOVE_RIGHT:
					tab[i][j] = tab[i][j + 1];
					tab[i][j + 1] = 0;
					break;
			}
		}
		catch (IndexOutOfBoundsException ex)
		{
			return false;
		}
		
		return true;
	}
	
	public void shuffle(int m)
	{
		boolean isMove = false;
		
		for (int i = 0; i < m; i++)
			do
			{
				isMove = makeMove(Move.values()[rand.nextInt(4)]);
			}
			while (!isMove);
			
	}

	@Override
	public List<GraphState> generateChildren()
	{
		List<GraphState> children = new ArrayList<GraphState>();
		
		for (int i = 0; i < 4; i++)
		{
			Puzzle child = new Puzzle(this);
			
			if (child.makeMove(Move.values()[i]))
				children.add(child);
		}
		
		return children;
	}

	@Override
	public boolean isSolution()
	{
		int k = 0;
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				if (tab[i][j] != k++)
					return false;
				
		return true;
	}

	@Override
	public String toString()
	{
		StringBuilder builder = new StringBuilder();
		
		for (int i = 0; i < n; i++)
		{
			for (int j = 0; j < n; j++)
				builder.append(tab[i][j] + " ");
			builder.append("\n");
		}
		
		return builder.toString();
	}

	@Override
	public int hashCode()
	{
		int[] t = new int[n*n]; 
		
		int k = 0;
		for (int i = 0; i < n; i++)
			for (int j = 0; j < n; j++)
				t[k++] = tab[i][j];
		
		return Arrays.hashCode(t);
	}

	public int[][] getTab()
	{
		return tab;
	}
	
	public static void main(String[] args)
	{
		int tests = 1;
		
		System.out.println("MISPLACED TILES\n\n");
		Puzzle.setHFunction(new MisplacedTilesFunction());
		
		for (int i = 0; i < tests; i++)
		{
			Puzzle puzzle = new Puzzle();
			
			puzzle.shuffle(1000);
		
			System.out.println(puzzle);
			
			GraphSearchAlgorithm algorithm = new AStar(puzzle);
			
			algorithm.execute();
			
			List<GraphState> solutions = algorithm.getSolutions();
			
			//for (GraphState solution : solutions)
			//	System.out.println(solution);
			
			System.out.println("OPEN: " + algorithm.getOpenSet().size());
			System.out.println("CLOSED: " + algorithm.getClosedStatesCount());
			System.out.println("EXECUTION TIME: " + algorithm.getDurationTime());
			
			System.out.println();
			System.out.println();
			
		}	
		
		System.out.println("MANHATTAN\n\n");
		Puzzle.setHFunction(new ManhattanFunction());
		
		 for (int i = 0; i < tests; i++)
		{
			Puzzle puzzle = new Puzzle();
			
			puzzle.shuffle(1000);
		
			System.out.println(puzzle);
			
			GraphSearchAlgorithm algorithm = new AStar(puzzle);
			
			algorithm.execute();
			
			List<GraphState> solutions = algorithm.getSolutions();
			
			//for (GraphState solution : solutions)
			//	System.out.println(solution);
			
			System.out.println("OPEN: " + algorithm.getOpenSet().size());
			System.out.println("CLOSED: " + algorithm.getClosedStatesCount());
			System.out.println("EXECUTION TIME: " + algorithm.getDurationTime());
			
			System.out.println();
			System.out.println();
		}
	}
	
}
