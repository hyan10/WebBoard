<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("utf-8");

	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String content = request.getParameter("content");
	
	BoardDAO dao = new BoardDAO();
	BoardVO board = new BoardVO();

	board.setNo(Integer.parseInt(request.getParameter("no")));
	board.setTitle(title);
	board.setContent(content);
	board.setWriter(writer);
	
//	out.println(board);
	
	if(dao.updateBoard(board)){
%>
<script>
	alert('수정이 완료되었습니다.');
	/* location.href="detail.jsp?no=${param.no}"; */
</script>
	<jsp:forward page="detail.jsp?no=${param.no}"/>
<%	
	}
%>