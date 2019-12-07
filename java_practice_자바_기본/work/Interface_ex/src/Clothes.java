
public class Clothes implements Product{
	public long getPrice(int productld)
	{
		if( productld == 1)
			return 100;
		else
			return 10;
		
	}
	public void printName()
	{
		System.out.println("clothes... ");
	}
}
