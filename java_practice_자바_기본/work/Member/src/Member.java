
public class Member {

	private String name;
	private String tel;
	public Member(String name, String tel)
	{
		this.name = name;
		this.tel = tel;
	}
	public String getName()
	{
			return name;
	}
	public String getTel()
	{
		return tel;
	}
	
	public String toString()
	{
		String str;
		str = "이름: "+ name + ",전화번호:" + tel;
		return str;
	}
	
}
