import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.Iterator;

public class ServiceTest {

	public static void main(String[] args) 
	{
		// TODO Auto-generated method stub
		ServiceGrp srin = new ServiceGrp();
		initialize(srin);
		System.out.println("      ** ����� ����Ʈ **");
		List astin = srin.getAll();
		for(Iterator i = astin.iterator(); i.hasNext();)
		{
			Service ser = (Service)i.next();
			prntCont(ser);
			System.out.println();
		}
	String stname = "�ڼ���";
	System.out.println("\n ������̸� (" + stname+ ") �˻�: ");
	Service s = (Service)srin.getServ(stname);
	prntCont(s);	
	}
	private static void initialize(ServiceGrp in) {
		Map atts = new HashMap();
		atts.put("��ǰ��", "�ڷ�����");
		atts.put("�ڹ�����","2018/09/07");
		atts.put("��������", "��ǰ��ü");
		in.addServ("�輱��", "010-111-1212", new ServCont(atts));
		atts.put("��ǰ��","������");
		atts.put("�湮����","2018/9/18");
		atts.put("��������","����Ŭ����");
		
		in.addServ("������", "010-222-2121",new ServCont(atts));
		
		atts.put("�湮����","2018/10/12");
		atts.put("��������", " ���̺���");
		in.addServ("�ڼ���", "010-333-3131", new ServCont(atts));
		atts.put("��ǰ��", "�ڷ�����");
		atts.put("�湮����", "2018/10/12");
		atts.put("��������", "���۹�ư����");
		in.addServ("����ȣ", "010=121=1321", new ServCont(atts));
		
		
	}
	private static void prntCont(Service s) {
		String name = (String)s.getName();
		System.out.println("������̸�" + name+ ",��ȭ��ȣ" + s.getTel()+ "\n <�����׸�>");
		ServCont cont = s.getCont();
		for ( Iterator j = cont.getAts().keySet().iterator(); j.hasNext();)
		{
			String atname = (String)j.next();
			System.out.print("  " +atname + "; "+ cont.getAts(atname));
		}
		System.out.println();
	}	
}
