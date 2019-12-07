
public class Electronics implements Product {
	public long getPrice(int productld)
	{
	if( productld == 1)
		return 1000;
	else
		return 2000;
	}
	public void printName()
	{
	System.out.println("electrical parts ... ");
	}
}
