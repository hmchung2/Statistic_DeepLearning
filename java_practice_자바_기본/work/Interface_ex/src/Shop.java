
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
		System.out.println("주문: "+ item.MAKER + "전화번호" + item.TEL);
		System.out.println("품복멸 가격 (만원)" + item.getPrice(1));
	}
	public static void main(String[] args) {
		orderList(elec);
	}
}
