import java.util.EnumSet;
enum FourSeason {
	Spring("��", "������"), SUMMER("����","����Ȩ"),AUTUMN("����","�ڽ���"), WINTER("�ܿ�","���μ�ġ��");
	private final String season;
	private final String flower;
	FourSeason(String season, String flower){
		this.season = season;
		this.flower = flower;
	}
	public String getSeason()
	{
		return season;
	}
	public String getflower()
	{
		return flower;
	}
}

public class SeasonTest {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		System.out.println("[������ ��]");
		for(FourSeason i: FourSeason.values())
		{
			System.out.printf("%-7s%-5s%-20s\n", i, i.getSeason(),i.getflower());
		}
		System.out.println("\n [����~�ܿ�]");
		for(FourSeason k: EnumSet.range(FourSeason.SUMMER, FourSeason.WINTER))
		{
			System.out.printf("%-5s%-20s\n", k.getSeason(),k.getflower());
		}
	}

}
