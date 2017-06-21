<%@page import="kr.co.bit.board.vo.BoardFileVO"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
		int no = Integer.parseInt(request.getParameter("no"));

		BoardDAO dao = new BoardDAO();
		List<BoardFileVO> fileList = dao.selectFileByNo(no);
		
		// 첨부파일 삭제
//		boolean result = dao.deleteFile(no);
		
//		if(result){
			// 게시물 삭제
			boolean result = dao.deleteBoard(no);
//		}
		
		pageContext.setAttribute("result", result);
		
		// 파일 삭제
		for(BoardFileVO fileVO : fileList){
			String root = request.getSession().getServletContext().getRealPath("/");
			String filePath = root + "upload";
			String fileName = fileVO.getFileSaveName();
			File file = new File(filePath,fileName);
			
			System.out.println(file.getPath()+" "+file.getName());
			
			if(file.exists()){
				if(file.delete()){
					System.out.println("삭제 완료");
				}else {
					System.out.println("삭제 실패");
				}
			}else {
				System.out.println("파일이 존재하지 않음");
			}
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:if test="${ result }">
		<script>
			alert("삭제되었습니다.");
			location.href="list.jsp";
		</script>
	</c:if>

</body>
</html>