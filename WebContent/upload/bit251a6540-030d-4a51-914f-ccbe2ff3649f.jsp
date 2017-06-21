<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*" %>

<%
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no, title, writer, reg_date ");
	sql.append("  from t_board ");
	sql.append(" order by no desc ");
	
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	
	ResultSet rs = pstmt.executeQuery();
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
	<br/>
	<hr width="80%"/>
		<h2>게시판 목록</h2>
	<hr width="80%"/>
	<br/>
	
	<table border="1" width="80%" >
		<tr>
			<td width="7%">번호</td>
			<td>제목</td>
			<td width="16%">작성자</td>
			<td width="20%">등록일</td>
		</tr>
	</table>
	
	</div>
</body>
</html>