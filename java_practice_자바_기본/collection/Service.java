
public class Service {

	private String sName;
	private String sTel;
	private ServCont cont;
	public Service(String sName, String sTel, ServCont cont)
	{
		this.sName = sName;
		this.sTel = sTel;
		this.cont = cont;
	}
	public String getName() {
		return sName;
	}
	public String getTel() {
		return sTel;
	}
	public ServCont getCont() {
		return cont;
	}
	public void setTel(String sTel) {
		this.sTel = sTel;
	}
}


