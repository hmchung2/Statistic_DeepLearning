
public class TwoArray {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int x[][] = new int[5][];
		
		for(int i = 0; i < x.length; i ++) {
			x[i] = new int[i+1];
			for(int j = 0; j < x[i].length; j++)
				x[i][j] = j+1;
		}
		for(int m = 0; m < x.length; m++)
		{
			for( int y : x[m])
				System.out.print(y + "");
				System.out.println();
		}
		int g[][] = new int[6][];
		g[0] =  new int[3];
		g[1] = new int[2];
		System.out.println(g[1].length + " " + g[0].length );
		
	}

}
