
public class OneDArray {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		int[]y =  new int[100];
		int i = 0, sum = 0;
		while(i < y.length)
		{
			y[i] = i+1;
					i++;
		}
		for(int j = 0 ; j < y.length; j++)
			sum += y[j];
				System.out.println(sum);
	}

}
