<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>전송된 정보 출력</h2>
	
	<%
		InputStreamReader isr = new InputStreamReader(request.getInputStream(),"utf-8");
		BufferedReader br = new BufferedReader(isr);
		
		while(true){
			String str = br.readLine();
			if(str==null) break;
			out.print(str + "<br/>");
		}
		
	%>
</body>
</html>