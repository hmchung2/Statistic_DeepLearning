import java.util.*;
public class StringTokenizerTest {
	public static void main(String[] args) {
		
		Scanner scn = new Scanner(System.in);
		final int N = 10;
		String sentence = new String(" ");
		String s = new String("");
		for ( int i = 0 ; i < N ; i++)
		{
			System.out.println("�Ľ��� ������ �Է��ϼ���.");
			sentence = scn.nextLine();
			if (sentence.equals(s))
			{
				System.out.println("ó�� ����");
				break;
			}
			StringTokenizer st = new StringTokenizer(sentence," ");
			System.out.println("��ū��:" + st.countTokens());
			while(st.hasMoreTokens()) {
				System.out.print(st.nextToken()+" |");
			}
			System.out.println("\n");
		}
	
		StringTokenizer q = new StringTokenizer("asda ssdas sadas", " ");
		System.out.println(q.nextToken() );
		System.out.println(q.nextToken() );
		System.out.println(q.nextToken() );
	}
}
