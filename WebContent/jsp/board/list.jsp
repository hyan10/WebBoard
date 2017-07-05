<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.bit.board.vo.BoardVO"%>
<%@page import="kr.co.bit.board.dao.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.bit.util.JDBCClose"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.bit.util.ConnectionFactory"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% 

/*  DAO로 변환된 부분
	Connection conn = new ConnectionFactory().getConnection();
	StringBuilder sql = new StringBuilder();
	sql.append("select no, title, writer, to_char(reg_date,'yyyy-mm-dd') as reg_date from t_board order by no desc");
	
	PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	ResultSet rs = pstmt.executeQuery();
*/
	
	BoardDAO dao = new BoardDAO();
	List<BoardVO> listAll = dao.selectAllBoard();
	
	String nextNo = request.getParameter("nextNo");
	List<BoardVO> pageList = dao.selectBoard(Integer.parseInt(nextNo!=null?nextNo:"1"));
	
	System.out.println(pageList);
	
	pageContext.setAttribute("listAll", listAll);
	pageContext.setAttribute("list", pageList);
	pageContext.setAttribute("size", 5);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 목록</title>
<script src="/Lecture-Web/jquery/js/jquery-3.2.1.min.js"></script>
<script>
	function goWriteForm(){
		location.href = "writeForm.jsp";
//		location.href = "/Mission-Web/jsp/board/writeForm.jsp";
	}
	
	function onAction(boardNo){
		<c:choose>
			<c:when test="${not empty member}">
				location.href = "detail.jsp?type=list&no="+boardNo;
			</c:when>
			<c:otherwise>
				if(confirm('로그인이 필요합니다. 로그인하시겠습니까?')){
					location.href = "/Mission-Web/jsp/member/loginForm.jsp?url=board/detail&no="+boardNo;
				}
			</c:otherwise>
		</c:choose>
	}
	
	function next(nextNo){
		location.href = "list.jsp?nextNo="+nextNo;
	}
	
	<%-- function getList(nextNo){
		var endNo = <%=list.size()%>;
		
		if(endNo > (nextNo+2)){
			endNo = nextNo+2;
		}
		
		<% List<BoardVO> list1 = new ArrayList<>(); %>
		for(var i=nextNo; i<endNo ; i++){
			<%
				list1.add(list.get(i-1));
			%>
		}
		
		return <%= list1 %>;
	} --%>
	
/* 	function goJoinForm(){
		location.href = "../member/joinForm.jsp";
	}

	function goLoginForm(){
		location.href = "../member/loginForm.jsp";
	} */
	
	<%-- $(document).ready(function(){
		$('#member').hide();

	 	if(<%=request.getParameter("user")!=null%>){ 
			$('#login').hide();
			$('#user_id').text("<%=request.getParameter("user")%>");
			$('#member').show();
			
		} else {
			$('#login').show(); 
			$('#member').hide();
		}
	}); --%>
	
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
			<h2 >게시판 목록</h2>
		<hr width="100%"/>
		<br/>
		
		<!-- <p id="login" align="right">
			<input type="button" value="회원가입" onclick="goJoinForm()"/>&nbsp;
			<input type="button" value="로그인" onclick="goLoginForm()"/>
		</p>
		
		<p id="member" align="right">
			현재 사용자: <span id="user_id"></span>
		</p>
		<br/><br/> -->
		<table border="1" width="100%" class="list">
		
			<tr>
				<th width="7%">번호</th>
				<th>제목</th>
				<th width="16%">작성자</th>
				<th width="20%">등록일</th>
			</tr>
			<!-- (not empty param.nextNo)?(param.NextNo+2):2 -->
			<!-- javascript:getList(${param.nextNo}) -->
			<!-- begin="${(not empty param.nextNo)?param.nextNo:1}" end="${ 10 }" -->
			
		<c:forEach var="board"  items="${list}" varStatus="loop">
			<tr <c:if test="${loop.index%2 == 1}">class="even"</c:if>>
				<td>${board.no}</td>
				<%-- title 내용에 태그가 있으면 수행되므로 el 표현식 권장 안함
				 	<td><a href="detail.jsp?no=${board.no}">${board.title}</a></td>
				  --%>
				<td>
					<a href="javascript:onAction('${board.no}')"><c:out value="${board.title}"/></a>
					<!-- href="detail.jsp?no=${board.no}" -->
					<!-- onclick="onAction('${board.no}')"  --> <!-- 클릭 이벤트이기 때문에 hover시 css 적용이 안된다 -->
				</td>
				<td>${board.writer}</td>
				<td>${board.regDate}</td>
			</tr>
		</c:forEach>
		</table>
		<br/>
		
		<c:forEach var="i" begin="0" end="<%=listAll.size() %>" step="${size}">
			<fmt:parseNumber var="page" value="${(i/size)+1}" integerOnly="true"/>
			<a href="javascript:next(${page})">${page}</a>&nbsp;
			<!-- href="list.jsp?nextNo=${i} -->
		</c:forEach>
		
		<br/><br/>
		
		<c:if test="${not empty member}">
			<input type="button" value="새글 등록" onclick="goWriteForm()"/>
		</c:if>
	</div>
	</section>
	
	<footer>
	<!-- action include 써도 된다.  -->
		<%@ include file="/jsp/include/bottom.jsp" %>
	</footer>
</body>
</html>