
public class Student {
	static int num;  // ���� ������� ����
 	String name;
 	String major;			
 	Student(String name, String major)
    {
 	   this.name = name;
 	   this.major = major;
 	   ++num;
 	}	
 	static int getNum( )  // ���� �޼ҵ� 
   {
	   return num;	
 	 } 
    public void setMajor(String major) 
 	{
 	   this.major = major;
 	   
 	}
 	public String toString( )
	{
 	   String str ="";
 	   str +=  "�̸�: " + name + ", ����: " + major;
 	   return str;
 	}
	  
}
