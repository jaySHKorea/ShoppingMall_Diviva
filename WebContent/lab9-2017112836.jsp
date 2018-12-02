<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!-- import JDBC package -->
<!-- [IMPORTANT] Complete your scripting. -->
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Test for mysql</title>
</head>
<body>
	<h2>Lab #9: Repeating Lab #5-3 via JSP</h2>
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
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url,user,pass);
	//transaction, lock 설정 
	//String TransQuery = "SET TRANSACTION ";
%>

<h3> test result </h3>
<%
String query1 = "SELECT DISTINCT Main_category FROM category";
   
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