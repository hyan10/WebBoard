<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/Mission-Web/jsp/js/checkForm.js"></script>
<script>
	function check(){
		var form = document.loginForm;
		
		if(isNull(form.id, '아이디를 입력하세요.')){
			return false;
		}
		
		if(isNull(form.pw, '비밀번호를 입력해주세요.')){
			return false;
		}
	
	
		/* 
		if(form.id.value==""){
			alert("아이디를 입력해주세요.");
			form.id.focus();
			return false;
		}
			

		if(form.pw.value==""){
			alert("비밀번호를 입력해주세요.");
			form.pw.focus();
			return false;
		} */
		
		return true;
	}
	
	function back(){
		location.href="/Mission-Web";
	}
</script>
<link rel="stylesheet" href="/Mission-Web/css/layout.css" />
<link rel="stylesheet" href="/Mission-Web/css/board.css"/>
</head>
<body>
<!-- html5 -->
	<header>
		<!-- xml, include, forward는 /가 Mission-Web/ 까지를 의미 -->
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	
	<section>
		<div align="center">
		<br/>
		<hr width="80%"/>
		<h2>로그인</h2>
		<hr width="80%"/>
		<br/>
	
		<form action="login.jsp?url=${param.url}&no=${param.no}" method="post" name="loginForm" onsubmit="return check()">
		
			<table width="40%">
				<tr>
					<th>ID</th>
					<td><input type="text" name="id" size="20"/></td>
				</tr>
				<tr>
					<th>PASSWORD</th>
					<td><input type="password" name="pw" size="20"/></td>
				</tr>
			</table>
			
			<br/>
			
			<input type="submit" value="로그인"/>&nbsp;&nbsp;
			<input type="button" value="돌아가기" onclick="back()"/>
			
		</form>
	</div>
	</section>
	
	<footer>
	<!-- action include 써도 된다.  -->
		<%@ include file="/jsp/include/bottom.jsp" %>
	</footer>
</body>
</html>