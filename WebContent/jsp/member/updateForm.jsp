<%@page import="kr.co.bit.board.vo.MemberVO"%>
<%@page import="kr.co.bit.board.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDAO dao = new MemberDAO();
	MemberVO member = dao.getMember(((MemberVO)session.getAttribute("member")).getId()); //.getParameter("id"));
	
	pageContext.setAttribute("member", member);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/Mission-Web/css/layout.css" />
<link rel="stylesheet" href="/Mission-Web/css/board.css" />
<script src="/Mission-Web/js/checkForm.js"></script>
<script>
	function check(){
		var form = document.memberForm;
		
		if(isNull(form.name),'이름을 입력해주세요.'){
			return false;
		}
		
		if(isNull(form.pw),'비밀번호를 입력해주세요.'){
			return false;
		}
	}
</script>
</head>
<body>
	<!-- html5 -->
	<header> <!-- xml, include, forward는 /가 Mission-Web/ 까지를 의미 -->
	<jsp:include page="/jsp/include/topMenu.jsp" /> </header>

	<section>
	<div align="center">
		<br />
		<hr width="80%" />
		<h2>회원정보 수정</h2>
		<hr width="80%" />
		<br />

		<form action="update.jsp" method="post" name="memberForm"
			onsubmit="return check()">

			<input type="hidden" name="id" value="${member.id }"/>
			아이디: ${member.id }<br />
			<br /> 이름: <input type="text" name="name" value="${member.name }"/><br />
			<br /> 비밀번호: <input type="password" name="pw"/><br />
			<br /> 이메일: <input type="text" name="email_id" value="${member.email_id }" />@
			<select	name="email_domain">
				<option value="">도메인 선택</option>
				<option value="naver.com">naver.com</option>
				<option value="daum.net">daum.net</option>
				<option value="google.com">google.com</option>
			</select><br />
			<br /> 전화번호: <input type="text" name="tel1" size="3" value="${member.tel1 }"/>-<input
				type="text" name="tel2" size="4" value="${member.tel2 }"/>-<input type="text" name="tel3"
				size="3" value="${member.tel3 }"/> <br />
			<br /> 우편번호: <input type="text" name="post" size="7" value="${member.post }" /><br />
			<br /> 주소: <input type="text" name="basic_addr" value="${member.basic_addr }" />&nbsp; <input
				type="text" name="detail_addr" value="${member.detail_addr }"/> <br />
			<br /> <input type="submit" value="수정" />&nbsp;&nbsp; <input
				type="button" value="취소" onclick="back()" />
		</form>
	</div>
	</section>

	<footer> <!-- action include 써도 된다.  --> <%@ include
		file="/jsp/include/bottom.jsp"%> </footer>
</head>
<body>
</html>