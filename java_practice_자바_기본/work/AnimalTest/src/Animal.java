
public class Animal {
    protected String name;
    protected  int age;	
   public Animal( String name, int age )
   {
	   this.name = name;
	   this.age = age;
   }
  public void bark( )
  {
	  System.out.println("WooWoo~");
  }
  public String toString()
   {
	   return String.format("이름: %s, 나이: %d", name, age);
   }
}
