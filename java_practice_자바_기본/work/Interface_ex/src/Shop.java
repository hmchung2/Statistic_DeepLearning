
public class Shop {
	static Electronics elec;
	static Clothes cls;
	public static void init()
	{
		elec = new Electronics();
		cls = new Clothes();
	}
	public static void orderList(Product item)
	{
		item.printName();
		System.out.println("�ֹ�: "+ item.MAKER + "��ȭ��ȣ" + item.TEL);
		System.out.println("ǰ���� ���� (����)" + item.getPrice(1));
	}
	public static void main(String[] args) {
		orderList(elec);
	}
}
