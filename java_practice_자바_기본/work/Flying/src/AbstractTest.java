
public class AbstractTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Airplane a = new Airplane();
		a.takeOff();
		a.landing();
		Flying f;
		f = (Flying)a;
		f.takeOff();
		f.landing();
		f.takeOff();
		Airplane g;
		g = new Airplane();
		g.landing();
	}

}
