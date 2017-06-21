<%@page import="kr.co.bit.board.vo.MemberVO"%>
<%@page import="kr.co.bit.board.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

	request.setCharacterEncoding("utf-8");

	MemberDAO dao = new MemberDAO();
	MemberVO member = new MemberVO();
	
	member.setId(request.getParameter("id"));
	member.setName(request.getParameter("name"));
	member.setEmail_id(request.getParameter("email_id")!=null?request.getParameter("email_id"):null);
	member.setEmail_domain(request.getParameter("email_domain")!=null?request.getParameter("email_domain"):null);	
	member.setBasic_addr(request.getParameter("basic_addr")!=null?request.getParameter("basic_addr"):null);
	member.setDetail_addr(request.getParameter("detail_addr")!=null?request.getParameter("detail_addr"):null);
	member.setPost(request.getParameter("post")!=null?request.getParameter("post"):null);
	member.setTel1(request.getParameter("tel1")!=null?request.getParameter("tel1"):null);
	member.setTel2(request.getParameter("tel2")!=null?request.getParameter("tel2"):null);
	member.setTel3(request.getParameter("tel3")!=null?request.getParameter("tel3"):null);
	
	if(request.getParameter("pw")!=null){
		member.setPassword(request.getParameter("pw"));
	}

	String msg = null;
	String url = null;
	
	System.out.println(member);
	
	if(dao.update(member)){
		msg = "수정 완료";
		url = "/Mission-Web/jsp/member/mypage.jsp";
	}else {
		msg = "수정 실패";
		url = "/Mission-Web/jsp/member/updateForm.jsp";
	}
	
	pageContext.setAttribute("msg", msg);
	pageContext.setAttribute("url", url);
	
	System.out.println(msg);
	
%>

<script>
	alert('${msg}');
	location.href= "${url}";
</script>