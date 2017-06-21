<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.bit.util.JDBCClose"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 

	// DAO로 변환될 부분
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no, title, writer, to_char(reg_date,'yyyy-mm-dd') as reg_date from t_board order by no desc");
	
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	ResultSet rs = pstmt.executeQuery();

	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/Lecture-Web/jquery/js/jquery-3.2.1.min.js"></script>
<script>
	function goWriteForm(){
		location.href = "writeForm.jsp";
//		location.href = "/Mission-Web/jsp/board/writeForm.jsp";
	}
	
	function goJoinForm(){
		location.href = "../member/joinForm.jsp";
	}

	function goLoginForm(){
		location.href = "../member/loginForm.jsp";
	}
	
	$(document).ready(function(){
		$('#member').hide();
		
	<%-- 	String id = <%=request.getParameter("user")!=null?request.getParameter("user"):" "%>; --%>
		<%--  new String("<%=request.getParameter("user")!=null?request.getParameter("user"):""%>"); --%>
		
		if(request.getParameter("user")==null){
			$('#login').hide();
			$('#member').show();
		} else{
			$('#login').show(); 
			$('#member').hide();
		}
	});
</script>
</head>
<body>
	<div align="center">
		<br/>
		<hr width="80%"/>
			<h2 >게시판 목록</h2>
		<hr width="80%"/>
		<br/>
		
		<p id="login" align="right">
			<input type="button" value="회원가입" onclick="goJoinForm()"/>&nbsp;
			<input type="button" value="로그인" onclick="goLoginForm()"/>
		</p>
		
		<p id="member" align="right">
			로그인 아이디: <span id="user_id"></span>
		</p>
		<br/><br/>
		<table border="1" width="80%">
		
			<tr>
				<th width="7%">번호</th>
				<th>제목</th>
				<th width="16%">작성자</th>
				<th width="20%">등록일</th>
			</tr>
	<% 		
			while(rs.next()){
	%>
	<tr>
	
	<td> <%= rs.getInt("no") %> </td>
	<td><a href="detail.jsp?no=<%= rs.getInt("no") %>"> <%= rs.getString("title") %> </a></td>
	<td> <%= rs.getString("writer") %> </td>
	<td> <%= rs.getString("reg_date") %> </td>
	
	</tr>
		
<%
			}
%>	
		</table>
		<br/>
		<input type="button" value="새글 등록" onclick="goWriteForm()"/>
	</div>
	
	
</body>
</html>

<%
	JDBCClose.close(conn, pstmt);
%>