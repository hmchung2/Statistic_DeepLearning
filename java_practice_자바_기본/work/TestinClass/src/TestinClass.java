
public class TestinClass {

	static int ofx = 1;
	class MemberinCls{
		String sta = "Memeber inner class..";
		int x = 100;
		public void outCont() {
			System.out.println(sta + ",x : " + x + ", ofx:" + ofx);	
		}
		
	}
	static class StaticinCls{
		static String sts = "Static Inner class..";
		static int sty = 20;
		public static void staticinMd() {
			System.out.println(sts + ", static method - ofx :"  + ofx + ", sty:" + sty);
		}
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TestinClass t = new TestinClass();
		MemberinCls mem = t.new MemberinCls();
		mem.outCont();
		
		class LocalinCls{
			String stl = "Local inner class..";
			int x = 100;
			public void localMd(){
				System.out.println(stl + ",x : " + x + ",ofx:" + ofx);
			}
			
		}
		LocalinCls lc = new LocalinCls();
		lc.localMd();
		
		
		System.out.println(new Object() {
			public String toString()
			{
				return "Anonymous inner class" ;
			}
			
		});
		StaticinCls a = new StaticinCls();
		a.staticinMd();
		System.out.println("Static class 이름 사용:" + StaticinCls.sts + ",sty:" + StaticinCls.sty);
		float e = 12.367f;
		Float ee = new Float(e);
		System.out.println(e+ " "+ ee);
		int wow = 20;
		Integer really = new Integer(10); 
	}
	
}

