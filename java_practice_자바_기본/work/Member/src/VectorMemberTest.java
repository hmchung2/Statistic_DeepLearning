import java.util.*;
public class VectorMemberTest {
	
	public static Vector v;
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		v = new Vector(20,5);
		Member m1 = new Member("�̼���", "123-1212");
		Member m2 = new Member("�ڿ쿵", "111-1021");
		Member m3 = new Member("������", "133-1301");
		v.add(m1);
		v.add(m2);
		v.add(m3);
		output(" ȸ�� ����Ʈ");
		System.out.print("\n �ι�° ȸ�� \n");
		Member a = (Member)v.get(1);
		System.out.println(a.toString());
		Member n1 = new Member("������", "");
		
		
		check(n1);
		n1 = new Member("������","");
		check(n1);
		v.remove(m2);
		System.out.println("\n" + m2.getName()+ " : �����Ǿ����ϴ�.");
		System.out.println("\n ȸ����" + v.size() + "��");
		output("\n ȸ�� ����Ʈ");
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
			System.out.println("\n" + b.getName()+ ":" + n + "��° ȸ���Դϴ�. \n" + b.toString());
		else
			System.out.println("\n" + n1.getName()+ ": ȸ���� �ƴմϴ�." );
	}
	
}
	
