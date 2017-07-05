<%@page import="kr.co.bit.board.vo.BoardFileVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.bit.board.vo.MemberVO"%>
<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	/* 
		1. 상세보기 할 게시물 번호 추출  (detail.jsp)
		2. DB에서 게시물 번호의 데이터를 조회  (BoardDAO)
		3. 화면에 출력 (deetail.jsp)
	*/
	
	int no = Integer.parseInt(request.getParameter("no"));

	BoardDAO dao = new BoardDAO();
	
	// 게시물 조회
	BoardVO board = dao.selectByNo(no);
	
	// 첨부파일 조회
	List<BoardFileVO> files = dao.selectFileByNo(no);
	
	pageContext.setAttribute("fileList", files);


	// form 태그 쓸 때 새로고침 시 증가시키고 싶지 않으면 method로 구분해도 됨 (post/get) 
	// list.jsp에서 상세페이지로 접속했을 경우에만 조회수 증가
/*
	String type = request.getParameter("type");
	if(type != null && type.equals("list")){
		dao.updateViewCnt(no);
	}
*/

	if(!((MemberVO)session.getAttribute("member")).getName().equals(board.getWriter())){
		 board.setViewCnt(board.getViewCnt()+1);
		 dao.updateViewCnt(board);
	}

	

	// 자바 객체를 쓰려면 공유영역에 추가해야함
	pageContext.setAttribute("board", board);
	

	// DAO
/* 	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no , title, writer, content, view_cnt, to_char(reg_date, 'yyyy-mm-dd') as reg_date ");
	sql.append(" from t_board where no = ?");
	
	PreparedStatement st = conn.prepareStatement(sql.toString());
	st.setInt(1,no);
	ResultSet rs = st.executeQuery();
	
	rs.next();  // if로 안써도됨. 무조건 1개 나오니까
	
	String title = rs.getString("title");
	String writer = rs.getString("writer");
	String content = rs.getString("content");
	int view_cnt = rs.getInt("view_cnt");
	String reg_date = rs.getString("reg_date");
 */	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 보기</title>
<script>
	function onAction(type){
		switch(type){
		case 'u' :
			location.href = "updateForm.jsp?no=${param.no}";
			break;
		case 'd' :
			if(confirm("${param.no}번 게시물을 삭제하시겠습니까?"))
				location.href = "delete.jsp?no=<%=no%>";
			break;
		case 'l' :
			location.href = "list.jsp";
			break;
		}
	}
	
	function download(no){
		if(confirm("다운로드 하시겠습니까?")){
		 	location.href = "/Mission-Web/jsp/file/download.jsp?no="+no;
		}
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
		<hr width="100%"/>
		<h2>상세페이지</h2>
		<hr width="100%"/>
		<br/>
		
		<table width="100%" border="1">
		
		<tr>
			<th width="25%">번호</th>
			<%-- <td>${board.no}</td> --%>
			<td>${param.no}</td>
			<%-- <td> <%= rs.getInt("no") %> </td> --%>
		</tr>
		
		<tr>
			<th >제목</th>
			<td><c:out value="${board.title}"/></td>
			<%-- <td> <%= title %> </td> --%>
		</tr>

		<tr>
			<th >작성자</th>
			<td>${board.writer}</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td><c:out value="${board.content}"/></td>
			<%-- <td> <%= rs.getString("content") %> </td> --%>
		</tr>
		
		<tr>
			<th>조회수</th>
			<td>${board.viewCnt}</td>
			<%-- <td> <%= rs.getInt("view_cnt") %> </td> --%>
		</tr>
		
		<tr>
			<th>등록일</th>
			<td>${board.regDate}</td>
			<%-- <td> <%= rs.getString("reg_date") %> </td> --%>
		</tr>
		
		<tr>
			<th>첨부파일</th>
			<td>
			<c:forEach var="file" items="${fileList}">
			<!-- /Mission-Web/upload/${file.fileSaveName} -->
				<a href="javascript:download(${file.no})">${file.fileOriName}</a>&nbsp;(${file.fileSize} bytes)<br/>  <!-- .이 getter 역할 -->
			</c:forEach>
			</td>
		</tr>
		
		</table>
		
		<br/><br/>
		<c:if test="${member.name eq board.writer }">
			<input type="button" value="수정" onclick="onAction('u')"/>&nbsp;&nbsp;
		</c:if>
		<c:if test="${member.name eq board.writer or member.type eq 'S'}">
			<input type="button" value="삭제" onclick="onAction('d')" />&nbsp;&nbsp;
		</c:if>
		<input type="button" value="목록" onclick="onAction('l')" />
		</div>
	</section>
	
	<footer>
	<!-- action include 써도 된다.  -->
		<%@ include file="/jsp/include/bottom.jsp" %>
	</footer>
</body>
</html>