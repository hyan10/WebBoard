<%@page import="kr.co.bit.board.vo.MemberVO"%>
<%@page import="kr.co.bit.board.dao.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	MemberVO member = new MemberVO();
	member.setId(request.getParameter("id"));
	member.setPassword(request.getParameter("pw"));

	MemberDAO dao = new MemberDAO();
	MemberVO result = dao.loginMember(member);
	
	System.out.println(result);
	
	String msg = null;
	String url = null;
	
	if(result==null){
		msg = "아이디 또는 패스워드가 잘못되었습니다.";	
		url = "/Mission-Web/jsp/member/loginForm.jsp";
		
	}else {
		session.setAttribute("member", result);
		switch(result.getType()){
			case "S":
				msg = "관리자님 환영합니다.";
				break;
			case "U":
				msg = result.getName()+"("+result.getId()+")님 환영합니다."; // ${member.name}(${member.id})님 환영합니다.";
				break;
		}
		
		String detail_url = (String)request.getParameter("url");
		
		System.out.println(detail_url);
		
		if(detail_url.equals("")){
			url = "/Mission-Web";		
		}else if(detail_url.contains("detail")){
			String no = (String)request.getParameter("no");
			url = "/Mission-Web/jsp/"+detail_url+".jsp?no="+no;
		}
		
	}
	
//	System.out.println(msg);
	
	pageContext.setAttribute("msg", msg);
	pageContext.setAttribute("url", url);
	
	/* Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select id, name from t_member where ");
	sql.append(" id=? and password=?");
	PreparedStatement st = conn.prepareStatement(sql.toString());
	st.setString(1, request.getParameter("id"));
	st.setString(2, request.getParameter("pw"));
	
	ResultSet rs = st.executeQuery();
	
	if(rs.next()){ */
		
%>

<script>
	alert("${msg}"); <%--  (<%= msg%>"); --%>
	location.href = "${url}"; <%-- <%=url%>; --%>
</script>