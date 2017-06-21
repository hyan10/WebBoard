<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/Mission-Web/css/layout.css"/>
<link rel="stylesheet" href="/Mission-Web/css/board.css"/>
<script src="/Mission-Web/js/checkForm.js"></script>
<script>
	
/* 	function isNull(obj, msg){
		
		if(obj.value==""){
			alert(msg);
			obj.focus();
			return true;
		}
		
		return false;
	} */
	
	function chkForm(){
		var form = document.lform;
	
		if(isNull(form.id, '아이디를 입력하세요')){
			return false;
		}
	
		if(isNull(form.pw, '패스워드를 입력하세요')){
			return false;
		}
		
		/* if(form.id.value==""){
			alert("아이디를 입력하세요.");
			form.id.focus();
			return false;
		}
		
		if(form.pw.value==""){
			alert("패스워드를 입력하세요");
			form.pw.focus();
			return false;
		} */
		
		return true;
	}
</script>
</head>
<body>

	<header>
		<jsp:include page="/jsp/include/topMenu.jsp"/>
	</header>
	
	<section>
		<div align="center">
		<br/>
			<hr/>
			<h2>로그인</h2>
			<hr/><br/><br/>
			
			<form name="lform" action="loginProcess.jsp" method="post" onsubmit="return chkForm()">
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
				<input type="submit" value="로그인"/>
			</form>
		</div>
	</section>
	
	<footer>
		<%@ include file="/jsp/include/bottom.jsp" %>
	</footer>

</body>
</html>