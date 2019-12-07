import java.util.*;
public class IfTestPass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
int score, basescore, gap;
Scanner scn = new Scanner(System.in);
System.out.print("점수 : ");
score = scn.nextInt();
System.out.print("합격기준 점수 : ");
basescore = scn.nextInt();

 
if (score >= basescore)
{System.out.print(basescore + "점(기준점수), 합격입니다" );
gap = score - basescore;
System.out.print("\n 차이는" + gap);
}

else if (score <= basescore)
{System.out.print(basescore + "점(기준점수), 불학겹입니다");
gap =  basescore - score;
System.out.print("\n 차이는" + gap);
		}	
	}
}
