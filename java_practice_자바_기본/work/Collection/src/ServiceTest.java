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
		System.out.println("      ** 사용자 리스트 **");
		List astin = srin.getAll();
		for(Iterator i = astin.iterator(); i.hasNext();)
		{
			Service ser = (Service)i.next();
			prntCont(ser);
			System.out.println();
		}
	String stname = "박수진";
	System.out.println("\n 사용자이름 (" + stname+ ") 검색: ");
	Service s = (Service)srin.getServ(stname);
	prntCont(s);	
	}
	private static void initialize(ServiceGrp in) {
		Map atts = new HashMap();
		atts.put("제품명", "텔레비젼");
		atts.put("박문일자","2018/09/07");
		atts.put("서비스유형", "부품교체");
		in.addServ("김선균", "010-111-1212", new ServCont(atts));
		atts.put("제품명","에어콘");
		atts.put("방문일자","2018/9/18");
		atts.put("서비스유형","필터클리닝");
		
		in.addServ("이정민", "010-222-2121",new ServCont(atts));
		
		atts.put("방문일자","2018/10/12");
		atts.put("서비스유형", " 케이블연결");
		in.addServ("박수진", "010-333-3131", new ServCont(atts));
		atts.put("제품명", "텔레비젼");
		atts.put("방문일자", "2018/10/12");
		atts.put("서비스유형", "조작버튼수리");
		in.addServ("조민호", "010=121=1321", new ServCont(atts));
		
		
	}
	private static void prntCont(Service s) {
		String name = (String)s.getName();
		System.out.println("사용자이름" + name+ ",전화번호" + s.getTel()+ "\n <서비스항목>");
		ServCont cont = s.getCont();
		for ( Iterator j = cont.getAts().keySet().iterator(); j.hasNext();)
		{
			String atname = (String)j.next();
			System.out.print("  " +atname + "; "+ cont.getAts(atname));
		}
		System.out.println();
	}	
}
