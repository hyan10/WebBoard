<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	function addFavorite(){
		try{
			window.external.AddFavorite('http://localhost:8000/Mission-Web', '첫번째 웹');
		}catch (e) { // var형이므로 Exception 이런거 안써도됨
			alert('현재 브라우저에서는 사용할 수 없습니다.\n크롬에서는 ctrl+d를 사용해주세요.');
		}
	}
	
	function noMember(){
		if(confirm('로그인이 필요합니다. 로그인하시겠습니까?')){
			location.href="/Mission-Web/jsp/member/loginForm.jsp";
		}
	}
</script>
<table border="1" width="100%" style="min-width:700px">
	<tr>
		<td rowspan="2" style="width:200px; height:50px">
			<!-- <img src="http://static.campaign.naver.com/0/hangeul/2013/img/logo.png"/> -->
			<a href="/Mission-Web">
				<!-- 경로를 프로젝트이름까지만 적었을 때는 web.xml에 있는 welcome-file 리스트를 보고 순서대로 파일을 찾는다. -->
			<img src="/Mission-Web/images/logo.png" />
			</a>
		</td>
		<!-- 익플에서만 됨 -->
		<!-- <td align="right">
			<a href="javascript:window.external.addFavorite('http://localhost:8000/Mission-Web', '첫번째 나의 웹')">즐겨찾기</a>
		</td>
		 -->
		<td  align="right">
			<a href="#" onclick="addFavorite()">즐겨찾기</a>
			<c:if test="${ not empty member }">
				[${sessionScope.member.id}님 로그인 중]
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td>
		<nav>
		<c:if test="${sessionScope.member.type eq 'S' }">
			<a href="/Mission-Web/jsp/member/members.jsp">회원관리</a>
			||
		</c:if>
		<a href="/Mission-Web/jsp/board/list.jsp">게시판</a>
		||
		<c:choose>
		<c:when test="${not empty sessionScope.member.id}">
			<a href="/Mission-Web/jsp/member/mypage.jsp">마이페이지</a>  <!-- ?id=${sessionScope.member.id} -->
		</c:when>
		<c:otherwise>
			<a href="/Mission-Web/jsp/member/joinForm.jsp">회원가입</a>
			<!-- ||
			<a href="javascript:noMember()" >마이페이지</a>		 -->
		</c:otherwise>
		</c:choose>
		||
		<c:choose>
		<c:when test="${empty sessionScope.member.id}">
			<a href="/Mission-Web/jsp/member/loginForm.jsp">로그인</a>
		</c:when>
		<c:otherwise>
			<a href="/Mission-Web/jsp/member/logout.jsp">로그아웃</a>			
		</c:otherwise>
		</c:choose>
	<!-- 	||
		로그아웃</td> -->
		</nav>
		</td>
	</tr>
</table>
