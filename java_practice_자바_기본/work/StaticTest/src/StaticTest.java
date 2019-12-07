
public class StaticTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Student s1 = new Student("이영미" , "소프트웨어공학");
		Student s2 = new Student("박선영","컴퓨터 통신");
		Student s3 = new Student("김미화","인공지능");
		System.out.print("num 변수: " + Student.num );
		System.out.println(", s1: " + s1.num+ ", s2: "+s2.num + ", s3: "+s3.num);
		System.out.println("인스턴스의 개수: " + Student.getNum());
		System.out.println("\ns1: " + s1 + "\ns2" + s2 + "\ns3: "+ s3);
		Student wow = new Student("sdsd", "Sdsdsd");
		System.out.println(wow.toString());
	}

}
