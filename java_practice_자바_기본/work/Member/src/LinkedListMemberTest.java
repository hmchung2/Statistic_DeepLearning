import java.util.*;
public class LinkedListMemberTest {
	public static LinkedList st;
	public static void main(String[] args) {
		// TODO Auto-generated method stu
	
		Member x[] = {new Member("이성자", "123-1212"),
				new Member("박우영", "111-1021"),
				new Member("최지우", "133-1301")};
		st = new LinkedList();
		st.add(x[0]);
		st.add(x[1]);
		st.add(x[2]);
		
		System.out.println("  전방향 순환");
		ListIterator it = st.listIterator();

		while(it.hasNext())
		{
			Member me = (Member)it.next();
			System.out.println(me);
			
		}
		ListIterator et = st.listIterator(3);
		System.out.println("\n 역방향 순환");
		while(et.hasPrevious())
		{
			Member me = (Member)et.previous();
			System.out.println(me);
		}
	}
}
