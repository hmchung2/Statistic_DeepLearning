import java.util.*;
public class IfTestPass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int score, basescore, gap;
Scanner scn = new Scanner(System.in);
System.out.print("���� : ");
score = scn.nextInt();
System.out.print("�հݱ��� ���� : ");
basescore = scn.nextInt();

 
if (score >= basescore)
{System.out.print(basescore + "��(��������), �հ��Դϴ�" );
gap = score - basescore;
System.out.print("\n ���̴�" + gap);
}

else if (score <= basescore)
{System.out.print(basescore + "��(��������), ���а��Դϴ�");
gap =  basescore - score;
System.out.print("\n ���̴�" + gap);
		}	
	}
}
