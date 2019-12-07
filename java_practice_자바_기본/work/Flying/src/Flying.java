
public abstract class Flying {

	protected int wingcnt = 2;
	protected boolean wheelstat = true;
	abstract public void takeOff();
	
	abstract public void landing();
	public void output()
	{
		System.out.println(wingcnt + " " + wheelstat);
	}
}



