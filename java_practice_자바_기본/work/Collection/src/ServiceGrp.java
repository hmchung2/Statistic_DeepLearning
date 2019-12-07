import java.util.List;
import java.util.LinkedList;
import java.util.Iterator;

public class ServiceGrp {

	private List srin;
	public ServiceGrp() {
		srin = new LinkedList();
	}
	public void addServ(String sName, String sTel, ServCont cont) {
		Service st = new Service(sName, sTel, cont);
		srin.add(st);
	}
	public List getAll() {
		return srin;
	}
	public Service getServ(String sName) {
	 for (Iterator i = srin.iterator(); i.hasNext();)
		{
			Service rst = (Service)i.next();
			if (rst.getName().contentEquals(sName))
			{
				return rst;
			}
		}
		return null;
	}
}
