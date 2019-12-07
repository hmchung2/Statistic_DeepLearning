import java.util.*;
public class VectorMemberTest {
	
	public static Vector v;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		v = new Vector(20,5);
		Member m1 = new Member("이성자", "123-1212");
		Member m2 = new Member("박우영", "111-1021");
		Member m3 = new Member("최지우", "133-1301");
		v.add(m1);
		v.add(m2);
		v.add(m3);
		output(" 회원 리스트");
		System.out.print("\n 두번째 회원 \n");
		Member a = (Member)v.get(1);
		System.out.println(a.toString());
		Member n1 = new Member("최지우", "");
		
		
		check(n1);
		n1 = new Member("김지숙","");
		check(n1);
		v.remove(m2);
		System.out.println("\n" + m2.getName()+ " : 삭제되었습니다.");
		System.out.println("\n 회원수" + v.size() + "명");
		output("\n 회원 리스트");
	}
		

	public static void output(String cont)
	{
		System.out.println(cont);
		Iterator it = v.iterator();
		while(it.hasNext()) {
			Member me = (Member)it.next();
			System.out.println(me);
		}
	}
	public static void check(Member n1) {
		boolean flag = false;
		int n = 0;
		Member b = null;
		for(int i = 0; i < v.size(); i++) {
			b = (Member)v.get(i);
			if(b.getName().equals(n1.getName())) {
				flag = true;
				n = i+1;
			}
		}
		if(flag)
			System.out.println("\n" + b.getName()+ ":" + n + "번째 회원입니다. \n" + b.toString());
		else
			System.out.println("\n" + n1.getName()+ ": 회원이 아닙니다." );
	}
	
}
	
