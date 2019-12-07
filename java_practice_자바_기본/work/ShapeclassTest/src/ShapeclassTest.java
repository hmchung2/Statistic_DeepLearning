class Shape{
	int width, height;
	String color;
	
	Shape()
	{
		
		this(10,10,"white");
		//width = 10;
		//height = 10;
		//color = "white";
	}
	Shape(int w, int h, String c)
	{
		width = w;
		height = h;
		color = c;
	}
	int calArea()
	{
		return width * height;
	}
	void draw()
	{
		System.out.println("drawing");
	}
}
public class ShapeclassTest {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Shape shape;
		shape = new Shape();
		int w = shape.calArea();
		System.out.println(w+" " +shape.color);
		shape.draw();
		
	Shape huh;
	huh = new Shape();
	System.out.println(huh.calArea() + 50);
	}
}













