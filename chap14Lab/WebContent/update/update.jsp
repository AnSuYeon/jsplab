<%@ page contentType = "text/html; charset=utf-8" %>

<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.SQLException" %>
<%-- <%@ page import = "java.sql.PreparedStatement" %> --%>
<%
	request.setCharacterEncoding("utf-8");
	
	String memberID = request.getParameter("memberID");
	String name = request.getParameter("name");
	
	int updateCount = 0;
	
	Class.forName("com.mysql.jdbc.Driver");
	
	Connection conn = null;
	Statement stmt = null;
	//PreparedStatement pstmt = null;
	
	try {
		String jdbcDriver = "jdbc:mysql://localhost:3306/chap14?" +
							"useUnicode=true&characterEncoding=utf8";
		String dbUser = "jspexam";
		String dbPass = "jsppw";
		
		String query = "update MEMBER set NAME = '"+name+"' "+
					   "where MEMBERID = '"+memberID+"'";
		
		//String query2 = "update MEMBER set NAME =? where MEMBERID =?";
		//pstmt.setString(1,name);
		//pstmt.setString(2,memberID);
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		//pstmt = conn.prepareStatement(query2);
		
		updateCount = stmt.executeUpdate(query);
		//updateCount = pstmt.executeUpdate();
	} finally {
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	}
%>
<html>
<head><title>이름 변경</title></head>
<body>
<%  if (updateCount > 0) { %>
<%= memberID %>의 이름을 <%= name %>(으)로 변경
<%  } else { %>
<%= memberID %> 아이디가 존재하지 않음
<%  } %>

</body>
</html>
