import java.sql.*;

public class JDBCExample {
	String url = "jdbc:mysql://localhost:3306/";
	
		String user;
		String passwd;
		Connection conn;
		Statement stmt;
		ResultSet rs;
		
		public JDBCExample(String dbname, String user, String passwd){
			this.url = this.url + dbname + "?serverTimezone = UTC";
			this.user = user;
			this.passwd = passwd;
		}
		//데이터 베이스 연결
		public boolean dbConnect(){
			boolean flag = true;
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
				conn = DriverManager.getConnection(url, user, passwd);
				
				
			} catch(Exception e) {
				System.out.println(e);
				flag = false;
			}
			return flag;
		}
		public void dbCreate(){
			try {
				stmt = conn.createStatement();
				stmt.executeUpdate("create table emp(name char(20),job char(10))");
				stmt.close();
				
			}catch (Exception e) {e.printStackTrace();}
		}
		public void dbInsert(String name, String job) {
			try {
			stmt = conn.createStatement();
			stmt.executeUpdate("insert into emp values('"+name+"','"+job+"')");
			stmt.close();
			
			}catch(Exception e) {e.printStackTrace();}
		}
		public void dbSearch() {
			try {
				stmt = conn.createStatement();
				rs = stmt.executeQuery("select* from emp");
				while(rs.next()) {
					String name = rs.getString(1);
					String job = rs.getString(2);
					System.out.println(name + " "+ job);		
				}
				stmt.close();
		
			}catch(Exception e) {e.printStackTrace();}
		}
		public static void main(String args[]) {
			JDBCExample jdbcEx = new JDBCExample("test","root","1234");
			if(jdbcEx.dbConnect()) {
				//jdbcEx.dbCreate();
				jdbcEx.dbInsert("John","Singer");
				jdbcEx.dbInsert("Hong", "Student");
				jdbcEx.dbSearch();
				
			
			
			}
		}
}
