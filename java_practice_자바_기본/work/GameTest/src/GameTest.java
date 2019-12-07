
public class GameTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		RSP_Game myRSPGame = new RSP_Game();
		myRSPGame.playRSP();
		System.out.println("New RSP Game with Constructor!");
		RSP_GameWithConstructor anotherGame = new RSP_GameWithConstructor();
		anotherGame.playRSP();
		System.out.println("Bye Bye ~!");
		System.out.println(anotherGame.winner);
	}

}
