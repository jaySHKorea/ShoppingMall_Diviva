package phase3;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class connection {
	
	Connection conn;
	Savepoint orderStart;
	
	// constructor
	public connection() {
	String url = "jdbc:mysql://localhost:3306/ShoppingMall_X?useUnicode=true&characterEncoding=utf8";
	String user = "knu";
	String pass = "comp322";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(url,user,pass);
			conn.setTransactionIsolation(Connection.TRANSACTION_READ_COMMITTED);
			conn.setAutoCommit(false);
			//transaction, lock 
		}catch(Exception e){
			DriverManager.println("SQL connection error");
			e.printStackTrace();
		}
	}
	
	// 로그인할때 사용자가 존재하는지 확인 메소드
	public boolean InUser(String Id, String password) {
		PreparedStatement pstmt;
		ResultSet rs = null;
		String query1 = "SELECT Id,Password FROM CUSTOMER WHERE Id = '"+Id+ "' AND Password = '"+password+"'";
		String i,p;
		
		try {
			pstmt = conn.prepareStatement(query1);
			rs = pstmt.executeQuery();
			rs.next();
			i = rs.getString(1);
			p = rs.getString(2);
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	    
		if ( i.equals(Id) && p.equals(password)) {
			if ( Id.equals("admin") && password.equals("admin")) {			
				DriverManager.println("관리자 계정 : 로그인 성공");
			}
			else {
				DriverManager.println("로그인 성공");
			}
			return true;
		}
		else {
    			DriverManager.println("잘못된 아이디 혹은 비밀번호 입니다.");
    			return false;
    			}
	}
	
	// 회원가입 화면정보로 DB에 회원 생성 
	public boolean InsertUser(String Id, String Password, String Name, String Address, String Phone_num, String Sex, String Age, String Job) {
		PreparedStatement pstmt = null;
		ResultSet rs;
		String query1 = "SELECT Id FROM CUSTOMER WHERE Id = '"+Id+"'";
		String i;
		
		try {
			pstmt = conn.prepareStatement(query1);
			rs = pstmt.executeQuery();
			rs.next();
			i = rs.getString(1);
		}catch(SQLException e) {
			i = null;
		}
		
		if ( i == null) { // 중복 아이디가 없으면 
			String query2 = "INSERT INTO CUSTOMER VALUES ('"+Id+"', '"+Password+"','"+Name+"'"
					+ ",'"+Address+"','"+Phone_num+"','"+Sex+"',"+Age+",'"+Job+"',0)";
			try {
			pstmt.executeUpdate(query2);
			conn.commit();
			return true;
			}catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		return false;
	}
	
	// 유저 회원 정보 수정 
		public boolean UpdateUser(String Id,String Name, String Address, String Phone_num, String Sex, String Age, String Job) {
			Statement stmt = null;
			//ResultSet rs;
			
			String query2 = "UPDATE CUSTOMER SET Name = '"+Name+"' AND Address = '"+Address+"' AND Phone_num = '"
								+Phone_num+"' AND Sex = '"+Sex+"' AND Age = "+Age+" AND Job = '"+Job+"' Where Id = '"+Id+"'";
			try {
				stmt = conn.createStatement();
				stmt.executeUpdate(query2);
				conn.commit();
				return true;
			}catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	
	// ITEM 창에서 장바구니 추가 버튼을 눌렀을때 장바구니 정보 업데이트/ 혹은 인서트 메소드 
	public boolean addItemOnItem(String Num, String Item_Id, String Custom_Id,String Retail_Name) {
		PreparedStatement pstmt = null;
		Statement stmt;
		ResultSet rs;
		String query1 = "SELECT custom_id FROM SHOPPINGBAG WHERE custom_id = '"+Custom_Id+"' AND item_id ="+Item_Id+" AND Retail_Name ='"+Retail_Name+"'";
		String i;
		
		try {
			pstmt = conn.prepareStatement(query1);
			rs = pstmt.executeQuery();
			rs.next();
			i = rs.getString(1);
		}catch(SQLException e) {
			i = null;
		}
		
		// 고객 쇼핑백에 해당 아이템이 존재하는 경우 -> 갯수만 증가 
		if ( i != null) {
			String query2 = "UPDATE SHOPPINGBAG SET Num = Num+"+Num+" WHERE item_id = "+Item_Id+" AND custom_id = '"+Custom_Id+"' AND Retail_Name = '"+Retail_Name+"'";
			try {
			stmt = conn.createStatement();
			stmt.executeUpdate(query2);
			conn.commit();
			return true;
			}catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
		else { // 고객 쇼핑백에 해당 아이템이 없는 경우
			String query3 = "INSERT INTO SHOPPINGBAG VALUES ("+Num+", "+Item_Id+",'"+Custom_Id+"','"+Retail_Name+"')";
			try {
			pstmt.executeUpdate(query3);
			conn.commit();
			return true;
			}catch(Exception e) {
				e.printStackTrace();
				return false;
			}
		}
	}
	
	// 장바구니창에서 개수 수정 버튼을 눌렀을때 장바구니 정보 업데이트
		public boolean updateItemOnShoppingbag(String Num, String Item_Id, String Custom_Id,String Retail_Name) {
			Statement stmt = null;
			int num;
			//ResultSet rs;
			String query2;
			if (Num.equals("")) num = 0;
			else num = Integer.parseInt(Num);
			
			if  (num < 0)
				query2 = "UPDATE SHOPPINGBAG SET Num = Num"+Num+" WHERE item_id = "+Item_Id+" AND custom_id = '"+Custom_Id+"' AND Retail_Name = '"+Retail_Name+"'";
			else
				query2 = "UPDATE SHOPPINGBAG SET Num = Num+"+Num+" WHERE item_id = "+Item_Id+" AND custom_id = '"+Custom_Id+"' AND Retail_Name = '"+Retail_Name+"'";
			
			System.out.println(query2);
			try {
				stmt = conn.createStatement();
				stmt.executeUpdate(query2);
				conn.commit();
				return true;
			}catch(Exception e) {
			e.printStackTrace();
				return false;
				
			}
		}
	
	// 구매버튼이 눌리고 완전히 완료되면 구매 정보가 ships와 delivery에 저장, retailer와 고객의 order count 한개 증가 
	public boolean addship(String Item_Id,String Num,String Custom_Id,String Address, String Name, String Retail_name){
		PreparedStatement pstmt;
		Statement stmt;
		ResultSet rs;
		String query1 = "SELECT count(*) from ships";
		Date today = new Date();
		SimpleDateFormat formatType = new SimpleDateFormat("yyyy-MM-dd");
		int i;
		String orderStart = "orderStart";
		String query = "SELECT Num FROM STORED_IN WHERE Retail_Name = '"+Retail_name+"' AND Item_Id = "+Item_Id;
		
		try {
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		rs.next();
		int num = rs.getInt(1);
		System.out.println("현재 재고 :"+num);
		System.out.println("구매할 갯수 : "+Num);
		if ( num < Integer.parseInt(Num))
			return false;
		}catch(Exception e) {
			return false;
		}
		
		try {
			conn.setSavepoint(orderStart);
			pstmt = conn.prepareStatement(query1);
			rs = pstmt.executeQuery();
			rs.next();
			i = rs.getInt(1);
			String query2 = "INSERT INTO SHIPS VALUES ("+Item_Id+",'"+Custom_Id+"',"+Num+","+(i+1)+",'N','"+formatType.format(today)+"','"+Retail_name+"')";
			pstmt.executeUpdate(query2);
			String query3 = "INSERT INTO DELIVERY VALUES ('"+Address+"','"+Name+"',"+Item_Id+","+(i+1)+",'"
					+ Retail_name+"')";
			pstmt.executeUpdate(query3);
			stmt = conn.createStatement();
			String query4 = "UPDATE RETAILER SET order_count = order_count+1 WHERE Name = '"+ Retail_name+"'";
			stmt.executeUpdate(query4);
			String query5 = "UPDATE CUSTOMER SET order_count = order_count+1 WHERE id = '"+Custom_Id+"'";
			stmt.executeUpdate(query5);
			conn.commit();
			return true;
		}catch(Exception e) {
			try {
				conn.rollback();}
			catch(Exception e2) {
				e.printStackTrace();
			}
			e.printStackTrace();
			return false;
		}
	}
	
	// 구매가 완료되면 shoppingbag에 있는 현재 접속자가 담은 아이템을 삭제
	public boolean delbag(String item_id, String Custom_Id,String Retail_Name) throws SQLException {
		Statement stmt = conn.createStatement();
		//ResultSet rs;
		String query1 = "DELETE FROM SHOPPINGBAG WHERE item_id = "+ item_id +" AND custom_id = '"+Custom_Id+"' AND retail_name = '"+Retail_Name+"'";
	
		stmt.addBatch(query1);
		try {
			stmt.executeBatch();
			stmt.executeUpdate(query1);
			conn.commit();
			//System.out.println("정보를 지웠음");
			return true;
		}catch(Exception e) {
			if ( orderStart != null)
				conn.rollback(orderStart);
			e.printStackTrace();
			return false;
		}
	}
	
	// 트랜잭션을 애초에 addship에서 체크하고 날려버리기 
	// 구매가 완료되면 특정 매장의 아이템의 재고를 감소시킴 
	public boolean delstock(String Retail_name, String Item_id, String Num) throws SQLException {
		Statement stmt = null;
		//PreparedStatement pstmt = null;
		//ResultSet rs = null;
		String query1 = "UPDATE STORED_IN SET Num = Num-"+ Num +" WHERE Retail_Name = '"+Retail_name+"' AND Item_Id = "+Item_id;
		
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(query1);
			conn.commit();
			return true;
		}catch(Exception e) {
			if ( orderStart != null)
				conn.rollback(orderStart);
			e.printStackTrace();
			return false;
		}
	}
	
	// 재고관리 - 특정 매장의 아이템의 재고를 증가시킴 
	public boolean addStock(String Retail_name, String Item_id, String Num) {
		Statement stmt = null;
		//ResultSet rs;
		String query1 = "UPDATE STORED_IN SET Num = Num +"+ Num +" WHERE Retail_Name = '"+Retail_name+"' AND Item_Id = "+Item_id;
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(query1);
			conn.commit();
			return true;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	// 관리자 통계 화면 파라미터 x가 ‘y’면  해당 retail_name의 전체 매출, ‘m’이면 모든달의 매출,  그 외의 값이면(else) x월의 일별 매출 반환
	public String[] sell(String x) {
		PreparedStatement pstmt;
		ResultSet rs;
		String[] result = new String[31];
		//Date today = new Date();
		//SimpleDateFormat formatType = new SimpleDateFormat("yyyy-mm-dd");
		
		if ( x.equals("y")) { // 전체 매출 
			String query1 = "select sum(price*num) from ships,item where ships.item_id = item.id";
			try {
				pstmt = conn.prepareStatement(query1);
				rs = pstmt.executeQuery();
				rs.next();
				int num = rs.getInt(1);
				result[0] = Integer.toString(num);
				System.out.println("전체: "+result[0]);
				return result;
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		else if ( x.equals("m")) { // 모든 달의 매출 
			int temp;
			try {
				for ( int i = 1 ; i <= 12 ; i++) {
					String k = "0"+ Integer.toString(i);
					if ( i >= 10 ) k = Integer.toString(i);
					String query1 = "select sum(price*num) from ships,item where ships.item_id = item.id and order_date like '2018-"+k+"%'";	
					pstmt = conn.prepareStatement(query1);
					rs = pstmt.executeQuery();
					rs.next();
					try {
						temp = rs.getInt(1);
					}catch(SQLException e) {
						temp = -1;
					}
					if ( temp == -1)
						result[i-1] = "0";
					else
						result[i-1] = Integer.toString(temp);
				}
				return result;
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else { // 일별 매출 반환
			x = x.substring(0, x.length()-2);
			int smonth = Integer.parseInt(x);
			System.out.println("smonth: "+x);
			if ( Integer.parseInt(x) < 10) x = "0"+x;
			//Date start = new Date();
			String startO = "2018-"+x+"-01";
			//String startX = "2018 "+x+" 01";
			int temp;
			
			Calendar calendar = Calendar.getInstance();

			int year = 2018;
			int month = smonth-1;
			calendar.set(year, month, 1);
			
			int DayOfMonth = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

			
			try {
				for ( int i = 1 ; i <= DayOfMonth  ; i++) {
					
					System.out.println(startO);
					String query1 = "select sum(price*num) from ships,item where ships.item_id = item.id and order_date = '"+startO+"'";;
							pstmt = conn.prepareStatement(query1);
							rs = pstmt.executeQuery();
							rs.next();
							try {
								temp = rs.getInt(1);
							}catch(SQLException e) {
								temp = -1;
							}
							if ( temp == -1)
								result[i-1] = "0";
							else
								result[i-1] = Integer.toString(temp);
						
							SimpleDateFormat dateDisplay = new SimpleDateFormat("yyyy-MM-dd");
							calendar.add(Calendar.DATE, 1);
							startO = dateDisplay.format(calendar.getTime());
						/*
							SimpleDateFormat dateDisplay = new SimpleDateFormat("yyyy MM dd");
							Calendar c = Calendar.getInstance();
							c.setTime(dateDisplay.parse(startX));
							
							startX = dateDisplay.format(c.getTime());
							month = c.MONTH;;
							System.out.println("c.");
							*/
							
				}
				return result;
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	// 현재 로그인된 회원의 구매횟수 반환 - 신규 추천상품을 띄울건지 말건지 
	public int getOrderCount(String Id, String password) {
		PreparedStatement pstmt;
		ResultSet rs;
		String query1 = "SELECT order_count from CUSTOMER WHERE Id = '"+Id+"' AND Password = '"+password+"'";
		
		try {
			pstmt = conn.prepareStatement(query1);
			rs = pstmt.executeQuery();
			rs.next();
			int order_count = rs.getInt(1);
			return order_count;
		}catch(Exception e) {
	    		DriverManager.println("로그인정보가 없거나 불러오기에 실패했습니다.");
			e.printStackTrace();
			return 999;
		}
	}
	
	// 로그인된 회원의 패스워드 설정 
	public void setPasswd(String Id, String password) {
		Statement stmt = null;
		//ResultSet rs;
		String query1 = "UPDATE CUSTOMER SET Password='"+password+"' WHERE Id ='"+Id+"'";
		
		try {
			stmt = conn.createStatement();
			stmt.executeUpdate(query1);
			DriverManager.println("비밀번호가 수되었습니다.");
			conn.commit();
		}catch(Exception e) {
	    		DriverManager.println("수정 오류 : failed");
			e.printStackTrace();
		}
	}
	
	// 현재 커넥션 반환
	public Connection getConnection() {
		return conn;
	}
	
	// 현재 커넥션 정보 반환
	public String IdentifyConnection() {
		return conn.toString();
	}
	
	// string이 숫자인지 확인 
	public boolean isNumeric(String str){
		try{
			int i = Integer.parseInt(str);
		}catch(NumberFormatException e){
			return false;
		}
		return true;
	}
}
