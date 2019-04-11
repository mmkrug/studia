package lab01.si.sudoku;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import sac.graph.BestFirstSearch;
import sac.graph.GraphSearchAlgorithm;
import sac.graph.GraphSearchConfigurator;
//import sac.graph.AStar;
import sac.graph.GraphState;
import sac.graph.GraphStateImpl;

public class Sudoku extends GraphStateImpl {



	public static final int n = 3;
	public static final int n2 = n * n;
	
	private byte[][] board = null;
	public int zeros=n2*n2;

	public Sudoku(){
		board = new byte[n2][n2];
		for (int i=0; i<n2; i++)
			for (int j=0; j<n2;j++)
				board[i][j]=0;
	}
	
	public Sudoku(Sudoku parent){
		board = new byte[n2][n2];
		for (int i=0; i<n2; i++)
			for (int j=0; j<n2;j++)
				board[i][j]=parent.board[i][j];
		
		zeros = parent.zeros;
	}
	
	private void refreshZeros(){
		zeros =0;
		for(int i=0; i<n2 ; i++)
			for(int j=0; j<n2; j++)
				if(board[i][j]==0)
					zeros++;
	}
	
	/*
	@Override
	public String toString() {
		String txt ="";
		
		for(int i=0;i<n2;i++){
			for(int j=0;j<n2;j++){
				txt+=board[i][j];
				if(j<n2-1)txt+=", ";
				
			}
			txt+="\n";
		}
		
		return txt;
	}
	*/
	
	@Override
	public String toString() {
		//String txt ="";
		StringBuilder txt = new StringBuilder();
		
		for(int i=0;i<n2;i++){
			txt.append(" | ");
			for(int j=0;j<n2;j++){
				//txt+=board[i][j];
				txt.append(board[i][j]);
				if(j<n2-1)txt.append(" ");	//txt+=", ";
				if(j%10==8)			txt.append(" ");
				if(j%3==2)			txt.append("| ");


			}
			//txt+="\n";
			txt.append("\n");
			if(i%3==2)			txt.append(" -------------------------\n");


		}
		
		//return txt;
		return txt.toString();
	}
	
	
	public void fromStringN3(String txt){
		int k=0;
		for(int i=0; i<n2; i++)
			for (int j=0; j<n2; j++){
				board[i][j]=Byte.valueOf(txt.substring(k, k+1));
			    k++;
			}
		refreshZeros();
	}
	
	public boolean isLegal(){
	    byte[] group = new byte[n2];
		//wiersze
	    for (int i=0; i<n2; i++){
	    	for (int j=0; j<n2; j++)
	    		group[j]=board[i][j];
	    	if(!isGroupLegal(group))
	    		return false;
	    }
		
	    //kolumny
	    for (int i=0; i<n2; i++){
	    	for (int j=0; j<n2; j++)
	    		group[j]=board[j][i];
	    	if(!isGroupLegal(group))
	    		return false;
	    }
		
	    //kwadraaaaty
	    for (int i=0; i<n; i++)
	    	for (int j=0; j<n; j++){
	    		int k=0;
	    		for (int l=0; l<n; l++)
	    			for (int m=0; m<n; m++)
	    				group[k++]=board[i*n+l][j*n+m];
	    		if(!isGroupLegal(group))
	    			return false;
	    	}
		return true;
	}
	
	private boolean isGroupLegal(byte[] group){
		boolean[] visited = new boolean[n2];
		for(int i=0; i<n2; i++)
			visited[i]=false;
		for(int i=0; i<n2; i++){
			if(group[i]==0)continue;
			if(visited[group[i]-1])
				return false;
			visited[group[i]-1]=true;
		}
		return true;
	}
	

	public static void main(String[] args) {
		
		String sudokuTxt = "003020600900305001001806400008102900700000008006708200002609500800203009005010300";
		//String sudokuTxt = "003000002000005001001806400008102900700000008006708200002609500800203009005010300";
		
	
				
		Sudoku s=new Sudoku();
		s.fromStringN3(sudokuTxt);
		System.out.println(s);
		System.out.println(s.zeros);
			
		
		
		Sudoku.setHFunction(new HEmptyPlaces());
		GraphSearchConfigurator conf = new GraphSearchConfigurator();
			conf.setWantedNumberOfSolutions(Integer.MAX_VALUE);
		
		GraphSearchAlgorithm a = new BestFirstSearch(s, conf);
		a.execute();
			List<GraphState> solutions = a.getSolutions();
			for(GraphState sol:solutions) {
				System.out.println(" -------------------------");
				System.out.println(sol);
			}
			
		
			System.out.println("  Time:" + a.getDurationTime());
			System.out.println("  Closed:" + a.getClosedStatesCount());
			System.out.println("  Open:" + a.getOpenSet().size());
			System.out.println("  Solutions:" + a.getSolutions().size());
			
		/*
		int[] t1 = new int[] {1,1};
		int[] t2 = new int[] {1,5,9};
		
		// normalnei hashuje po adresie jesli nie jes stringiem
		// jesli chcemy hashowac po zawartosci tablicy a nie po adresie to uzywamy Arrays.hashCode(obiekt);
		
		//System.out.println(Arrays.hashCode(t1));
		//System.out.println(Arrays.hashCode(t2));
		 */
			
	}

	@Override
	public List<GraphState> generateChildren() {
		// kolekcyjne rzeczy w java.util
		List<GraphState> children = new ArrayList<GraphState>(); // Linker List
		
		int i=0,j=0;
		skok:
		for(i=0;i<n2;i++) 
			for(j=0;j<n2;j++)
				if(board[i][j]==0)
					break skok;
		if(i == n2)
			return children;
			
		for(int k=0;k<n2;k++) {
			Sudoku child = new Sudoku(this);
			child.board[i][j]=(byte)(k+1);
			if(child.isLegal()) {
				children.add(child);
				child.zeros--;
			}
		}
		return children;
		
	}


	/*
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		//return super.hashCode();
		return toString().hashCode();
	}
	 */
	
	@Override
	public int hashCode() {
		// TODO Auto-generated method stub
		//return super.hashCode();
		//return toString().hashCode();
		Byte[] linSudoku = new Byte[n2*n2];
		int k=0;
		for(int i=0;i<n2;i++)
			for(int j=0;j<n2;j++)			
				linSudoku[k++] = board[i][j];
		return Arrays.hashCode(linSudoku);
		
	
	}
	
	@Override
	public boolean isSolution() {
		return ((zeros==0) && (isLegal()));
	}
	

	
}
