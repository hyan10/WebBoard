<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	int no = Integer.parseInt(request.getParameter("no"));

	BoardDAO dao = new BoardDAO();
	BoardVO board = dao.selectByNo(no);

	// 자바 객체를 쓰려면 공유영역에 추가해야함
	pageContext.setAttribute("board", board);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 수정 페이지</title>
<link rel="stylesheet" href="/Mission-Web/css/layout.css" />
<link rel="stylesheet" href="/Mission-Web/css/board.css" />
<script>
	function back(){
		location.href="list.jsp";
	}
</script>
</head>
<body>
	<!-- html5 -->
	<header>
		<!-- xml, include, forward는 /가 Mission-Web/ 까지를 의미 -->
		<jsp:include page="/jsp/include/topMenu.jsp" />
	</header>

	<section>
		<div align="center">
			<br />
			<hr width="100%" />
			<h2>게시글 수정</h2>
			<hr width="100%" />
			<br />

			<form action="update.jsp" method="post">
				<input type="hidden" name="no" value="${param.no }" />
				<input type="hidden" name="writer" value="${sessionScope.member.name}"/>
				<table style="width:100%;">

					<tr>
						<th width="25%">번호</th>
						<%-- <td>${board.no}</td> --%>
						<td>${param.no}</td>
					</tr>

					<tr>
						<th>제목</th>
						<td><input type="text" name="title" value="<c:out value='${board.title}'/>" size="70%" /></td>
						<%-- <td><input type="text" value="<c:out value="${board.title}"/>" size="70%" /></td> --%>
					</tr>

					<tr>
						<th>작성자</th>
						<td>${sessionScope.member.name}</td>
						<%-- <td><input type="text" name="writer" value="${board.writer}" size="70%" /></td> --%>
					</tr>

					<tr>
						<th>내용</th>
						<td>
						<textarea rows="7" cols="70" name="content">${board.content}</textarea>
						</td>
					</tr>

					<tr>
						<th>등록일</th>
						<td>${board.regDate}</td>
					</tr>

				</table>

				<br/><br/>
				
				<input type="submit" value="수정" />&nbsp;&nbsp;
				<input type="button" value="목록" onclick="back()" />&nbsp;&nbsp;

			</form>
		</div>
	</section>

	<footer>
		<!-- action include 써도 된다.  -->
		<%@ include file="/jsp/include/bottom.jsp"%>
	</footer>
</body>
</html>