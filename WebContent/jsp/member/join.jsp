<%@page import="kr.co.bit.board.vo.MemberVO"%>
<%@page import="kr.co.bit.board.dao.MemberDAO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* request.setCharacterEncoding("utf-8");
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("insert into t_member values (");
	sql.append("?,?,?,?,?,?,?,?,?,?,?,?,sysdate)");
	PreparedStatement st = conn.prepareStatement(sql.toString());
	st.setString(1, request.getParameter("id"));
	st.setString(2, request.getParameter("name"));
	st.setString(3, request.getParameter("pw"));
	st.setString(4, request.getParameter("email_id"));
	st.setString(5, request.getParameter("email_domain"));
	st.setString(6, request.getParameter("tel1"));
	st.setString(7, request.getParameter("tel2"));
	st.setString(8, request.getParameter("tel3"));
	st.setString(9, request.getParameter("post"));
	st.setString(10, request.getParameter("basic_addr"));
	st.setString(11, request.getParameter("detail_addr"));
	st.setString(12, request.getParameter("type"));
	
	int result = st.executeUpdate(); */
	
	request.setCharacterEncoding("utf-8");
	
	MemberDAO dao = new MemberDAO();
	
	// (String id, String name, String password, String email_id, String email_domain, String post,
	//		String tel1, String tel2, String tel3, String basic_addr, String detail_addr)
	MemberVO member = new MemberVO (
			request.getParameter("id"),
			request.getParameter("name"),
			request.getParameter("pw"),
			request.getParameter("email_id"),
			request.getParameter("email_domain")
			, request.getParameter("post")
			, request.getParameter("tel1")
			, request.getParameter("tel2")
			, request.getParameter("tel3")
			, request.getParameter("basic_addr")
			, request.getParameter("detail_addr")
			);
	
	boolean result = dao.joinMember(member);
	
	if(result){
		%>
		<script>
			alert("회원가입이 완료되었습니다.");
			location.href="../board/list.jsp";
		</script>
<%	}else {
	%>
	<script>
		alert('회원가입 실패');
	</script>
<%	
}
%>