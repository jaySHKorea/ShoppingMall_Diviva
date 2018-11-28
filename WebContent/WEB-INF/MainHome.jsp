<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<!-- [IMPORTANT] Complete your scripting. -->
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action = "MainHome.html" method = "POST">
</form>
<%
	String serverIP = "localhost";
	String strSID = "ShoppingMall_X";
	String portNum = "3306";
	String url = "jdbc:mysql://"+serverIP+":"+portNum+"/"+strSID;
	String user = "knu";
	String pass = "comp322";
	//Complete your code.
	Connection conn;
	PreparedStatement pstmt1;
	ResultSet rs1,rs2,rs3;
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url,user,pass);
	//transaction, lock ¼³Á¤ 
	//String TransQuery = "SET TRANSACTION ";
	
	String query1 = "SELECT Name "+
        "FROM CATEGORY "+
        "WHERE Id = ";
   
    pstmt1 = conn.prepareStatement(query1);
    rs1 = pstmt1.executeQuery();
    
	// list of tuples
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd1 = rs1.getMetaData();
	int cnt = rsmd1.getColumnCount();
	for (int i=1; i<= cnt ; i++){
		out.println("<th>"+rsmd1.getColumnName(i)+"</th>");
	}
	while(rs1.next()){
		out.println("<tr>");
		out.println("<td>"+rs1.getString(1)+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
	%>
</body>
</html>