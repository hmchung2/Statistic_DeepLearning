
public class StaticTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Student s1 = new Student("�̿���" , "����Ʈ�������");
		Student s2 = new Student("�ڼ���","��ǻ�� ���");
		Student s3 = new Student("���ȭ","�ΰ�����");
		System.out.print("num ����: " + Student.num );
		System.out.println(", s1: " + s1.num+ ", s2: "+s2.num + ", s3: "+s3.num);
		System.out.println("�ν��Ͻ��� ����: " + Student.getNum());
		System.out.println("\ns1: " + s1 + "\ns2" + s2 + "\ns3: "+ s3);
		Student wow = new Student("sdsd", "Sdsdsd");
		System.out.println(wow.toString());
	}

}
