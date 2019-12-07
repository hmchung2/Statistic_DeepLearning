import java.util.Map;
import java.util.HashMap;
import java.util.Iterator;

public class ServCont {
	private Map ats;
	public ServCont(Map ats)
	{
		if(ats == null) {
			ats = new HashMap();
		}
		else {
			this.ats = new HashMap(ats);
		}
	}
	public Map getAts()
	{
		return ats;
	}
	public Object getAts(String atName)
	{
		return ats.get(atName);
	}
}
