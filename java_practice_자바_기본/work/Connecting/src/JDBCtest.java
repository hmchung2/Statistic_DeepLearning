
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCtest {
	public static void main(String[] args) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
		// Connection ��ü�� �ڵ��ϼ����� import�� ���� com.mysql.connection�� �ƴ�
		// java ǥ���� java.sql.Connection Ŭ������ import�ؾ� �Ѵ�.

		try{
			// 1. ����̹� �ε�
			// ����̹� �������̽��� ������ Ŭ������ �ε�
			// mysql, oracle �� �� ������ ���� Ŭ���� �̸��� �ٸ���.
			// mysql�� "com.mysql.jdbc.Driver"�̸�, �̴� �ܿ�� ���� �ƴ϶� ���۸��ϸ� �ȴ�.
			// ����� ������ �����ߴ� jar ������ ���� com.mysql.jdbc ��Ű���� Driver ��� Ŭ������ �ִ�.
			Class.forName("oracle.jdbc.driver.OracleDriver");


			// 2. �����ϱ�
			// ����̹� �Ŵ������� Connection ��ü�� �޶�� ��û�Ѵ�.
			// Connection�� ��� ���� �ʿ��� url ����, �����縶�� �ٸ���.
			// mysql�� "jdbc:mysql://localhost/�����db�̸�" �̴�.
			String url = "jdbc:oracle:thin:@192.168.1.90:1521:dink";
			conn = DriverManager.getConnection(url, "scott", "tiger");

            stmt = conn.createStatement();
			// @param  getConnection(url, userName, password);
			// @return Connection

			System.out.println("���� ����");
			String sql = "SELECT * FROM SCOTT.CUSTOMER";


			// 5. ���� ����
			// ���ڵ���� ResultSet ��ü�� �߰��ȴ�.
			rs = stmt.executeQuery(sql);

			// 6. ������ ����ϱ�
			while(rs.next()){
				// ���ڵ��� Į���� �迭�� �޸� 0���� �������� �ʰ� 1���� �����Ѵ�.
				// �����ͺ��̽����� �������� �������� Ÿ�Կ� �°� getString �Ǵ� getInt ���� ȣ���Ѵ�.
				String name = rs.getString(1);
				String owner = rs.getString(2);
				String date = rs.getString(3);

				System.out.println(name + " " + owner + " " + date);
			}
		}
		catch(ClassNotFoundException e){
			System.out.println("����̹� �ε� ����");
		}
		catch(SQLException e){
			System.out.println("����: " + e);
		}
		finally{
			try{
				if( conn != null && !conn.isClosed()){
					conn.close();
				}
			}
			catch( SQLException e){
				e.printStackTrace();
			}
		}
	}
}


