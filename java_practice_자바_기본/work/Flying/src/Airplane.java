

public class Airplane extends Flying {
	public void takeOff()
	{
	super.output();
	System.out.println("����� �̷� : ");
	wheelstat = false;
	}
	public void landing()
	{
	super.output();
	System.out.println("����� ���� : ");
	wheelstat = true;
	}
}