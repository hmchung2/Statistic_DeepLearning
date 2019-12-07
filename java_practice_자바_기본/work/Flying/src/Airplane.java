

public class Airplane extends Flying {
	public void takeOff()
	{
	super.output();
	System.out.println("ºñÇà±â ÀÌ·ú : ");
	wheelstat = false;
	}
	public void landing()
	{
	super.output();
	System.out.println("ºñÇà±â Âø·ú : ");
	wheelstat = true;
	}
}