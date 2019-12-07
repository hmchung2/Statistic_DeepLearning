
public class AnimalTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Cat cat = new Cat("나비", 1);
		System.out.print("Cat: " + cat.toString()+ ", ") ;
		cat.bark();
		
		Dog dog = new Dog("핑클", 2);
		System.out.print("Dog: " + dog.toString()+ ", ") ;
		dog.bark();
	}

}
